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

@WebServlet("/api/plant/wither")
public class Wither extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String plantId= request.getParameter("plantId");
		String findUserId = "select * from users where id=?";
		String findPlantInfo="select * from user_plants where user_id = ? and plant_id = ?;";
		String updateStage = "UPDATE user_plants SET curr_stage = ? WHERE user_id = ? AND plant_id = ?";
		
		try (Connection conn = DBConn.getConnection();
				PreparedStatement findUserPstmt = conn.prepareStatement(findUserId)){
			findUserPstmt.setString(1, userId);
			ResultSet userFindRs = findUserPstmt.executeQuery();
			if (userFindRs.next()) {
				String user_id = userFindRs.getString("user_id");
				try(PreparedStatement stagePstmt = conn.prepareStatement(updateStage)) {
					stagePstmt.setInt(1, 0);
					stagePstmt.setString(2, user_id);
					stagePstmt.setString(3, plantId);
					int stageRs = stagePstmt.executeUpdate();
					if (stageRs > 0) {
						try(PreparedStatement resultPstmt = conn.prepareStatement(findPlantInfo)){
							resultPstmt.setString(1, user_id);
							resultPstmt.setString(2, plantId);
							ResultSet rs = resultPstmt.executeQuery();
							if(rs.next()) {
								JSONObject json = new JSONObject();
                                json.put("plantId",rs.getInt("plant_id"));
                                json.put("currStage", rs.getInt("curr_stage"));
                                
                                response.setContentType("application/json");
                                response.setCharacterEncoding("UTF-8");
                                response.getWriter().write(json.toString());
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
