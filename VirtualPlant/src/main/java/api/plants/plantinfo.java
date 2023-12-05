package api.plants;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import db.util.DBConn;


@WebServlet("/api/plant/info")
public class plantinfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public plantinfo() {
        super();
    }

	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String plantId = request.getParameter("plantId");
        String findId = "select * from users where id=?";
        String findPlantInfoSql = "select * from user_plants where user_id=? and plant_id=?;";

        try (Connection conn = DBConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(findId)) {

            pstmt.setString(1, userId);
            ResultSet result = pstmt.executeQuery();
            if (result.next()) {
                String user_id = result.getString("user_id");
                try (PreparedStatement findpsmt = conn.prepareStatement(findPlantInfoSql)) {
                    findpsmt.setString(1, user_id);
                    findpsmt.setString(2, plantId);
                    ResultSet rs = findpsmt.executeQuery();
                    
                    if (rs.next()) {
                    	System.out.println("실행");
                    	System.out.println("userid: " + rs.getInt("user_id"));
                    	System.out.println("식물번호: " + rs.getInt("plant_id"));
                    	System.out.println("애정도: " + rs.getInt("affection"));
                    	System.out.println("현재단계: " +rs.getInt("curr_stage"));
                    	System.out.println("비료횟수: " + rs.getInt("fertilizer_count"));
                    	System.out.println("물횟수: " + rs.getInt("water_count"));
                    	System.out.println("마지막으로 물 준시간: " + rs.getTimestamp("last_watered"));
                    	System.out.println("마지막으로 비료 준 시간: " + rs.getTimestamp("last_fertilized"));
                    	
                    	
                    	Timestamp lastWateredTimestamp = rs.getTimestamp("last_watered");
                        Timestamp lastFertilizedTimestamp = rs.getTimestamp("last_fertilized");
                        
                        
						
                    	JSONObject json = new JSONObject();
                        json.put("plantId", rs.getInt("plant_id"));
                        json.put("affection", rs.getInt("affection"));
                        json.put("currStage", rs.getInt("curr_stage"));
                        json.put("fertilizerCount", rs.getInt("fertilizer_count"));
                        json.put("waterCount", rs.getInt("water_count"));
                        json.put("lastWatered", (lastWateredTimestamp != null) ? lastWateredTimestamp.toString() : JSONObject.NULL);
                        json.put("lastFertilized", (lastFertilizedTimestamp != null) ? lastFertilizedTimestamp.toString() : JSONObject.NULL);

                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write(json.toString());
                    }
                } catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 적절한 오류 응답을 클라이언트에 전송
        }
    }
}
	
		
	
	

	

