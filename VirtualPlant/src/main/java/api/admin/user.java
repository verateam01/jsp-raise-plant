package api.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.util.DBConn;


import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

@WebServlet("/api/admin/user")
public class user extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userType = request.getParameter("userType");
        if (userType.equals("admin")) {
            try (Connection conn = DBConn.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT u.user_id, u.id, u.email, u.user_name, u.user_nick, u.user_type, p.plant_name " +
                     "FROM users u " +
                     "LEFT JOIN user_plants up ON u.user_id = up.user_id " +
                     "LEFT JOIN plants p ON up.user_plant_id = p.user_plant_id"
                 );
                 ResultSet rs = pstmt.executeQuery()) {

                JSONObject usersMap = new JSONObject(); 

                while (rs.next()) {
                    String userId = rs.getString("user_id");

                    JSONObject userJson = usersMap.optJSONObject(userId);
                    if (userJson == null) {
                        userJson = new JSONObject();
                        userJson.put("user_id", userId);
                        userJson.put("id", rs.getString("id"));
                        userJson.put("email", rs.getString("email"));
                        userJson.put("user_name", rs.getString("user_name"));
                        userJson.put("user_nick", rs.getString("user_nick"));
                        userJson.put("user_type", rs.getString("user_type"));
                        userJson.put("plants", new JSONArray());

                        usersMap.put(userId, userJson);
                    }

                    JSONArray plants = userJson.getJSONArray("plants");
                    String plantName = rs.getString("plant_name");

                    if (plantName != null) {
                        boolean plantExists = false;
                        for (int i = 0; i < plants.length(); i++) {
                            if (plantName.equals(plants.getString(i))) {
                                plantExists = true;
                                break;
                            }
                        }

                        if (!plantExists) {
                            plants.put(plantName);
                        }
                    }

                }

                // 모든 사용자 정보를 JSONArray로 변환
                JSONArray usersJson = new JSONArray();
                Iterator<String> keys = usersMap.keys();
                while (keys.hasNext()) {
                    String key = keys.next();
                    usersJson.put(usersMap.get(key));
                }


                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(usersJson.toString());

            } catch (SQLException e) {
                e.printStackTrace();
                // 오류 처리...
            } catch (JSONException e) {
                e.printStackTrace();
                // JSON 관련 오류 처리
            }
        }
    }
}
