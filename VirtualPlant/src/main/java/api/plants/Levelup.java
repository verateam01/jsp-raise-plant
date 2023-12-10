package api.plants;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.concurrent.ConcurrentNavigableMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import db.util.DBConn;


@WebServlet("/api/plant/levelup")
public class Levelup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Levelup() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String plantId= request.getParameter("plantId");
		
		String findUserId = "select * from users where id=?";
		String findPlantInfo="select * from user_plants where user_id = ? and plant_id = ?;";
		String updatePlantStage = "UPDATE user_plants SET curr_stage = ?, affection = ? WHERE user_id = ? AND plant_id = ?";
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
						int currStage = rsPlantInfo.getInt("curr_stage");
						int affection = rsPlantInfo.getInt("affection");
						
						//affection이 200이 넘으면두번진화할수있음 한단계씩
						if(currStage < 4 && affection >= 100) {
							affection = affection - 100;
							currStage = currStage + 1;
							
							try(PreparedStatement updatePlantPstmt = conn.prepareStatement(updatePlantStage)){
								updatePlantPstmt.setInt(1, currStage);
								updatePlantPstmt.setInt(2, affection);
								updatePlantPstmt.setString(3, user_id);
								updatePlantPstmt.setString(4, plantId);
								
								int updateRow = updatePlantPstmt.executeUpdate();
								if(updateRow > 0) {
									try(PreparedStatement findUpdatedPlantPstmt = conn.prepareStatement(findPlantInfo)){
							            findUpdatedPlantPstmt.setString(1, user_id);
							            findUpdatedPlantPstmt.setString(2, plantId);
							            ResultSet updatedRs = findUpdatedPlantPstmt.executeQuery();
							            if(updatedRs.next()) {
							                int updatedCurrStage = updatedRs.getInt("curr_stage");
							                int updatedAffection = updatedRs.getInt("affection");
							                JSONObject json = new JSONObject();
							                json.put("plantId", updatedRs.getInt("plant_id"));
							                json.put("currStage", updatedCurrStage);
							                json.put("affection", updatedAffection);
							                
							                
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
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

}
