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

@WebServlet("/api/plant/refresh")
public class refresh extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public refresh() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String plantId = request.getParameter("plantId");
        
        String findUserId = "SELECT user_id FROM users WHERE id = ?";
        String clearPlantInfo = "UPDATE user_plants SET curr_stage = ?, affection = ?, water_count = ?, fertilizer_count = ?, last_watered = ?, last_fertilized = ?, plant_day = ? WHERE user_id = ? AND plant_id = ?";
        String resultPlantInfo = "SELECT * FROM user_plants WHERE user_id = ? AND plant_id = ?";

        try (Connection conn = DBConn.getConnection();
             PreparedStatement findUserps = conn.prepareStatement(findUserId)) {

            findUserps.setString(1, userId);
            ResultSet rsFindUser = findUserps.executeQuery(); 
            if(rsFindUser.next()) {
                String user_id = rsFindUser.getString("user_id");
                try(PreparedStatement psClear = conn.prepareStatement(clearPlantInfo)) {
                    psClear.setInt(1, 1);
                    psClear.setInt(2, 0);
                    psClear.setInt(3, 0);
                    psClear.setInt(4, 0);
                    psClear.setNull(5, java.sql.Types.TIMESTAMP);
                    psClear.setNull(6, java.sql.Types.TIMESTAMP);
                    psClear.setInt(7, 1);
                    psClear.setString(8, user_id);
                    psClear.setString(9, plantId);
                    
                    int updateRows = psClear.executeUpdate();
                    if(updateRows > 0) {
                        try(PreparedStatement psResult = conn.prepareStatement(resultPlantInfo)) {
                            psResult.setString(1, user_id);
                            psResult.setString(2, plantId);
                            ResultSet rs = psResult.executeQuery();
                            if(rs.next()) {
                                JSONObject json = new JSONObject();
                                json.put("plantId",rs.getInt("plant_id"));
                                json.put("currStage", rs.getInt("curr_stage"));
                                json.put("affection", rs.getInt("affection"));
                                json.put("day", rs.getInt("plant_day"));
                                
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
        } catch (SQLException e) {
            e.printStackTrace();
            // 적절한 오류 처리 및 사용자 피드백
        }
    }
}
