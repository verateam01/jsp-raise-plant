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

@WebServlet("/api/register")
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public register() {
        super();
    
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String nick = request.getParameter("nick");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		System.out.println(name);
		System.out.println(nick);
		System.out.println(id);
		System.out.println(pw);
		String sql = "insert into users(id,pw,user_name,user_nick) values(?,?,?,?)";
		String user_plants_sql = "insert into user_plants(user_id,plant_id) values(?,?)";
        String plants_sql = "insert into plants(user_plant_id, plant_name) values (?, ?);";
		
		try(Connection conn = DBConn.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				PreparedStatement user_plants_pstmt = conn.prepareStatement(user_plants_sql, Statement.RETURN_GENERATED_KEYS);
				PreparedStatement plants_pstmt = conn.prepareStatement(plants_sql);
				){
			 pstmt.setString(1, id);
			 pstmt.setString(2, pw);
			 pstmt.setString(3, name);
			 pstmt.setString(4, nick);
			 System.out.println("db데이터 넣기완료");
			 int affectedRows = pstmt.executeUpdate();
			 if (affectedRows > 0) {
				    try (ResultSet userGeneratedKeys = pstmt.getGeneratedKeys()) {
				        if (userGeneratedKeys.next()) {
				            int userId = userGeneratedKeys.getInt(1);			            
				            String[] plants = {"Gardenia", "Hyacinth", "Cactus"};

				            
				                // 여기서 user_plants 테이블에 데이터를 삽입합니다.
				            	 for(int i=1; i<=3; i++) {			            	
						            	
						                user_plants_pstmt.setInt(1, userId);
						                user_plants_pstmt.setInt(2, i);
						                user_plants_pstmt.executeUpdate();
						                try (ResultSet plansGeneratedKeys = user_plants_pstmt.getGeneratedKeys()) {
						                    if (plansGeneratedKeys.next()) {
						                        int userPlantId = plansGeneratedKeys.getInt(1);
						                        plants_pstmt.setInt(1, userPlantId);
						                        plants_pstmt.setString(2, plants[i-1]);
						                        plants_pstmt.executeUpdate();
						                    }
						                
						            	}
				            	 }
				        }
				    }
				}
			 	else {
		            // 실패 시, 오류 페이지로 리디렉트
//		            response.sendRedirect("error.jsp");
		        }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
