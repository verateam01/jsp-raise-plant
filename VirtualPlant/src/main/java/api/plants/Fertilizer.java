package api.plants;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import db.util.DBConn;

@WebServlet("/api/plant/fertilizer")
public class Fertilizer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Fertilizer() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId=request.getParameter("userId");
		String plantId=request.getParameter("plantId");
		String lastFertilizedTime=request.getParameter("lastFertilizedTime");
		System.out.println(lastFertilizedTime);
		String findUserId = "select * from users where id=?;";
		String checkFertilizerCountSql = "SELECT fertilizer_count, last_fertilized FROM user_plants WHERE user_id = ? AND plant_id = ?;";
		String updateFertilizerSql = "UPDATE user_plants SET last_fertilized = ?, fertilizer_count = ?, affection = affection + ? WHERE user_id = ? AND plant_id = ?;";
		String updateLastFertilizedTimeSql="UPDATE user_plants SET last_fertilized = ? WHERE user_id = ? AND plant_id = ?;";
		String resultSql="select * from user_plants where user_id=? and plant_id=?";
		
		try (Connection conn=DBConn.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(findUserId)){
			
			pstmt.setString(1, userId);
			ResultSet rs =pstmt.executeQuery();
			
			if(rs.next()) {
				String user_id=rs.getString("user_id");
				
				//water_count, last_waterd값 찾기
				try(PreparedStatement checkFertilizerCountPstmt=conn.prepareStatement(checkFertilizerCountSql)){
					checkFertilizerCountPstmt.setString(1, user_id);
					checkFertilizerCountPstmt.setString(2, plantId);
					ResultSet rsFertilizerCount=checkFertilizerCountPstmt.executeQuery();
					
					if(rsFertilizerCount.next()) {
						
						int fertilizerCount = rsFertilizerCount.getInt("fertilizer_count");
						Timestamp lastFertilizedTimes = rsFertilizerCount.getTimestamp("last_fertilized");
						//last_water시간이 null일경우 시간넣기
						if(lastFertilizedTimes == null) {
							try(PreparedStatement updateLastFertilizedTime=conn.prepareStatement(updateLastFertilizedTimeSql)){
								updateLastFertilizedTime.setString(1, lastFertilizedTime);
								updateLastFertilizedTime.setString(2, user_id);
								updateLastFertilizedTime.setString(3, plantId);
								updateLastFertilizedTime.executeUpdate();
							}
						}
						
						//시간이 null일경우도 그냥 지금시간넣고해주기위한로직
						LocalDate lastFertilizedDate = (lastFertilizedTimes != null) ? lastFertilizedTimes.toLocalDateTime().toLocalDate() : LocalDate.now();
						LocalDate currentDate = LocalDate.now();
						
						if (!lastFertilizedDate.equals(currentDate)) {
                            fertilizerCount = 0; // 날짜가 변경되었으므로 fertilizerCount 리셋
                        }
						
						//-20: 10으로  애정도 우선설정
						int affectionChange = (fertilizerCount >= 2) ? -10:30;
						fertilizerCount++;
						
						try (PreparedStatement updateWaterPstmt=conn.prepareStatement(updateFertilizerSql)){
							updateWaterPstmt.setString(1, lastFertilizedTime);
							updateWaterPstmt.setInt(2, fertilizerCount);
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
