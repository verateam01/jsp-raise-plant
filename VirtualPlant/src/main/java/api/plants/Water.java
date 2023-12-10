package api.plants;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import db.util.DBConn;

@WebServlet("/api/plant/water")
public class Water extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId=request.getParameter("userId");
		String plantId=request.getParameter("plantId");
		String lastWatered=request.getParameter("lastWaterd");
		
		String findUserId = "select * from users where id=?;";
		String checkWaterCountSql = "SELECT water_count, last_watered FROM user_plants WHERE user_id = ? AND plant_id = ?;";
		String updateWaterSql = "UPDATE user_plants SET last_watered = ?, water_count = ?, affection = affection + ? WHERE user_id = ? AND plant_id = ?;";
		String updateLastWaterTimeSql="UPDATE user_plants SET last_watered = ? WHERE user_id = ? AND plant_id = ?;";
		String resultSql="select * from user_plants where user_id=? and plant_id=?";
		
		try (Connection conn=DBConn.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(findUserId)){
			
			pstmt.setString(1, userId);
			ResultSet rs =pstmt.executeQuery();
			
			if(rs.next()) {
				String user_id=rs.getString("user_id");
				
				//water_count, last_waterd값 찾기
				try(PreparedStatement checkWaterCountPstmt=conn.prepareStatement(checkWaterCountSql)){
					checkWaterCountPstmt.setString(1, user_id);
					checkWaterCountPstmt.setString(2, plantId);
					ResultSet rsWaterCount=checkWaterCountPstmt.executeQuery();
					
					if(rsWaterCount.next()) {
						
						int waterCount = rsWaterCount.getInt("water_count");
						Timestamp lastWateredTimestamp = rsWaterCount.getTimestamp("last_watered");
						//last_water시간이 null일경우 시간넣기
						if(lastWateredTimestamp == null) {
							try(PreparedStatement updateLastWaterTime=conn.prepareStatement(updateLastWaterTimeSql)){
								updateLastWaterTime.setString(1, lastWatered);
								updateLastWaterTime.setString(2, user_id);
								updateLastWaterTime.setString(3, plantId);
								updateLastWaterTime.executeUpdate();
							}
						}
						
						//시간이 null일경우도 그냥 지금시간넣고해주기위한로직
						LocalDate lastWateredDate = (lastWateredTimestamp != null) ? lastWateredTimestamp.toLocalDateTime().toLocalDate() : LocalDate.now();
						LocalDate currentDate = LocalDate.now();
						
						if (!lastWateredDate.equals(currentDate)) {
                            waterCount = 0; // 날짜가 변경되었으므로 waterCount 리셋
                        }
						
						//-20: 10으로  애정도 우선설정
						int affectionChange = (waterCount >= 3) ? -10:20;
						waterCount++;
						
						try (PreparedStatement updateWaterPstmt=conn.prepareStatement(updateWaterSql)){
							updateWaterPstmt.setString(1, lastWatered);
							updateWaterPstmt.setInt(2, waterCount);
							updateWaterPstmt.setInt(3, affectionChange);
							updateWaterPstmt.setString(4, user_id);
							updateWaterPstmt.setString(5, plantId);
							int rowUpdate = updateWaterPstmt.executeUpdate();
							if(rowUpdate>0) {
								try(PreparedStatement findPlantInfoPstmt=conn.prepareStatement(resultSql)){
									findPlantInfoPstmt.setString(1, user_id);
									findPlantInfoPstmt.setString(2, plantId);
									ResultSet result = findPlantInfoPstmt.executeQuery();
									
									if(result.next()) {
										System.out.println("실행완료");
										Timestamp lastWateredTimes = result.getTimestamp("last_watered");
										Timestamp lastFertilizedTimestamp = result.getTimestamp("last_fertilized");
										
								
										
										JSONObject json = new JSONObject();
										json.put("plantId",result.getInt("plant_id"));
										json.put("affection", result.getInt("affection"));
										json.put("currStage", result.getInt("curr_stage"));
										json.put("fertilizerCount", result.getInt("fertilizer_count"));
										json.put("waterCount", result.getInt("water_count"));
										json.put("lastWatered", (lastWateredTimes != null) ? lastWateredTimes.toString() : JSONObject.NULL);
										json.put("lastFertilized", (lastFertilizedTimestamp != null) ? lastFertilizedTimestamp.toString() : JSONObject.NULL);
										
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
			// TODO: handle exception
				e.printStackTrace();
		}
		
	}

}
