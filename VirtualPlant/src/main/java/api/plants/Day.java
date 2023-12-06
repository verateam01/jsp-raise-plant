package api.plants;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import db.util.DBConn;

@WebServlet("/api/plant/day")
public class Day extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String plantId= request.getParameter("plantId");
		String findUserId = "select * from users where id=?";
		String findPlantInfo="select * from user_plants where user_id = ? and plant_id = ?;";
		String updatePlantDay = "UPDATE user_plants SET plant_day = ?, water_count = ?,fertilizer_count = ? WHERE user_id = ? AND plant_id = ?";
		
		try (Connection conn = DBConn.getConnection();
				PreparedStatement findUserPstmt = conn.prepareStatement(findUserId)){
			findUserPstmt.setString(1,userId);
			ResultSet result = findUserPstmt.executeQuery();
			if(result.next()) {
				String user_id = result.getString("user_id");
				try(PreparedStatement findPlantPstmt = conn.prepareStatement(findPlantInfo)){
					findPlantPstmt.setString(1, user_id);
					findPlantPstmt.setString(2, plantId);
					ResultSet rsPlantInfo = findPlantPstmt.executeQuery();
					if(rsPlantInfo.next()) {
						int plantDay = rsPlantInfo.getInt("plant_day");
						int water_count = rsPlantInfo.getInt("water_count");
						int fertilizer_count = rsPlantInfo.getInt("fertilizer_count");
						
						// 다음날로 넘어가면
						plantDay = plantDay + 1;
						water_count = 0;
						fertilizer_count = 0;
						try(PreparedStatement updateDaytPstmt = conn.prepareStatement(updatePlantDay)){
							updateDaytPstmt.setInt(1, plantDay);
							updateDaytPstmt.setInt(2, water_count);
							updateDaytPstmt.setInt(3, fertilizer_count);
							updateDaytPstmt.setString(4, user_id);
							updateDaytPstmt.setString(5, plantId);
							int updateRow = updateDaytPstmt.executeUpdate();
							if(updateRow > 0) {
								System.out.println("날짜 바뀜 :" + plantDay + "일차");
								try(PreparedStatement findUpdatedPlantPstmt = conn.prepareStatement(findPlantInfo)){
									findUpdatedPlantPstmt.setString(1, user_id);
						            findUpdatedPlantPstmt.setString(2, plantId);
						            ResultSet updatedRs = findUpdatedPlantPstmt.executeQuery();
						            if(updatedRs.next()) {
						            	int updatedDay = updatedRs.getInt("plant_day");
						                JSONObject json = new JSONObject();
						                json.put("plantId", updatedRs.getInt("plant_id"));
						                json.put("plantDay", updatedDay);
						            	
						                response.setContentType("application/json");
						                response.setCharacterEncoding("UTF-8");
						                response.getWriter().write(json.toString());
						            }							
									
								}
						}
					}
				}
			}
			
		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}



}
