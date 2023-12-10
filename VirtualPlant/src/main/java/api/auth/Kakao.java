package api.auth;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.util.DBConn;
import model.User;

@WebServlet("/api/login/kakao")
public class Kakao extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Kakao() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
	 	String email = request.getParameter("email");
		String name = request.getParameter("name");
		
		System.out.println(id);
		System.out.println(email);
		System.out.println(name);
		String findIdSql = "select * from users where id=?";
		String insertUsersql = "insert into users(id,email,user_name,user_type) values(?,?,?,?);";
		String insertUserPlantSql = "insert into user_plants(user_id,plant_id) values(?,?)";
		String plants_sql = "insert into plants(user_plant_id, plant_name) values (?, ?);";
		try (Connection conn = DBConn.getConnection();
			PreparedStatement insertStmt = conn.prepareStatement(insertUsersql);
			PreparedStatement findStmt = conn.prepareStatement(findIdSql);
			PreparedStatement insertUserPlant = conn.prepareStatement(insertUserPlantSql,Statement.RETURN_GENERATED_KEYS);
			PreparedStatement plants_pstmt = conn.prepareStatement(plants_sql);
			){
			
			findStmt.setString(1, id);
			ResultSet rs = findStmt.executeQuery();
			
			if(!rs.next()) {
				insertStmt.setString(1, id); 
				insertStmt.setString(2, email);
				insertStmt.setString(3, name);
				insertStmt.setString(4, "kakao");
				
				int rowsAffected = insertStmt.executeUpdate();
				if (rowsAffected > 0) {
					//user_plants에 id넣기
					findStmt.setString(1, id);
				    ResultSet rsFind = findStmt.executeQuery();
				    if(rsFind.next()) {
				    	int user_id=rsFind.getInt("user_id");
				    	String[] plants = {"Gardenia", "Hyacinth", "Cactus"};
				    	for(int i=1; i<=3; i++) {
				    		insertUserPlant.setInt(1, user_id);
				    		insertUserPlant.setInt(2, i);
				    		insertUserPlant.executeUpdate();
				    		try (ResultSet generatedKeys = insertUserPlant.getGeneratedKeys()) {
				                if (generatedKeys.next()) {
				                    int userPlantId = generatedKeys.getInt(1); //생성된키값
				                    	plants_pstmt.setInt(1, userPlantId);
				                    	plants_pstmt.setString(2, plants[i-1]); 
				                    	plants_pstmt.executeUpdate();
				                    }
				                }
				            }
				    	}
				    
				    		System.out.println("DB 저장 성공");
							request.getSession().setAttribute("kakao_name", name);
							request.getSession().setAttribute("kakao_id", id);
							response.setContentType("application/json");
				            response.setCharacterEncoding("UTF-8");
							response.getWriter().write("{\"status\":\"success\"}");
				    }
				 else {
					System.out.println("DB 저장 실패");
				}
				return;
			}
			else {
				request.getSession().setAttribute("kakao_name", name);
				request.getSession().setAttribute("kakao_id", id);
				System.out.println("세션에 kakao_user 설정됨: " + name);
				response.setContentType("application/json");
	            response.setCharacterEncoding("UTF-8");
				response.getWriter().write("{\"status\":\"success\"}");
			}
		} catch (SQLException e) {
		    System.out.println("카카오 로직 실패");
		    e.printStackTrace();
		}
	}
}