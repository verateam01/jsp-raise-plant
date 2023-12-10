package api.plants;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import db.util.DBConn;

@WebServlet("/api/plant/name/edit")
public class EditPlantName extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditPlantName() {
        super();
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String newName = request.getParameter("newName");
        String userId = request.getParameter("userId");
        String plantId = request.getParameter("plantId");

        // 데이터베이스 연결 및 쿼리 실행
        try (Connection conn = DBConn.getConnection()) {
        	
        	String findUserId = "select user_id from users where id=?";
        	try(PreparedStatement userIdPstmt = conn.prepareStatement(findUserId)){
        		userIdPstmt.setString(1, userId);
        		ResultSet rsUserId = userIdPstmt.executeQuery();
        		if(rsUserId.next()) {
        			String user_id = rsUserId.getString("user_id");
        			// user_plants 테이블에서 user_id와 plant_id에 해당하는 user_plant_id 찾기
                    String findUserPlantId = "SELECT user_plant_id FROM user_plants WHERE user_id = ? AND plant_id = ?";
                    String userPlantId = "";
                    try (PreparedStatement pstmt = conn.prepareStatement(findUserPlantId)) {
                        pstmt.setString(1, user_id);
                        pstmt.setString(2, plantId);
                        var rs = pstmt.executeQuery();
                        if (rs.next()) {
                            userPlantId = rs.getString("user_plant_id");
                        }
                    }

                    // plants 테이블의 plant_name 업데이트
                    String updatePlantName = "UPDATE plants SET plant_name = ? WHERE user_plant_id = ?";
                    try (PreparedStatement pstmt = conn.prepareStatement(updatePlantName)) {
                        pstmt.setString(1, newName);
                        pstmt.setString(2, userPlantId);
                        int updated = pstmt.executeUpdate();
                        	
                        
                        if (updated > 0) {
                        		String findPlantName = "select plant_name from plants where user_plant_id = ?";
                        		try(PreparedStatement ps = conn.prepareStatement(findPlantName)){
                        			ps.setString(1, userPlantId);
                        			ResultSet rs=ps.executeQuery();
                        			if(rs.next()) {
                        				String plantName = rs.getString("plant_name");
                        				
                        				JSONObject json = new JSONObject();
                        				json.put("plantName", plantName);
                        				response.setContentType("application/json");
                        				response.setCharacterEncoding("UTF-8");
                        				response.getWriter().write(json.toString()); 
                        				}
                        		} catch (JSONException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
                        }
                    }
        		}
        	}
        	
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error: " + e.getMessage());
        }
	}

}
