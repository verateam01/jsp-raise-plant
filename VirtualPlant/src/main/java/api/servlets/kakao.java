package api.servlets;

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

import db.util.DBConn;
import model.User;

@WebServlet("/api/login/kakao")
public class kakao extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public kakao() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
	 	String email = request.getParameter("email");
		String name = request.getParameter("name");
		
		System.out.println(id);
		System.out.println(email);
		System.out.println(name);
		String sql = "insert into users(id,email,user_name,user_type) values(?,?,?,?);";
		String findIdSql = "select * from users where id=?";
		try (Connection conn = DBConn.getConnection();
			PreparedStatement findStmt = conn.prepareStatement(findIdSql);
			PreparedStatement insertStmt = conn.prepareStatement(sql);){
			
			findStmt.setString(1, id);
			ResultSet rs = findStmt.executeQuery();
			
			if(!rs.next()) {
				insertStmt.setString(1, id); 
				insertStmt.setString(2, email);
				insertStmt.setString(3, name);
				insertStmt.setString(4, "kakao");
				
				int rowsAffected = insertStmt.executeUpdate();
				if (rowsAffected > 0) {
					System.out.println("DB 저장 성공");
					request.getSession().setAttribute("kakao_name", name);
					request.getSession().setAttribute("kakao_id", id);
					response.setContentType("application/json");
		            response.setCharacterEncoding("UTF-8");
					response.getWriter().write("{\"status\":\"success\"}");
				} else {
					System.out.println("DB 저장 실패");
				}
				return;
			}
			else {
				request.getSession().setAttribute("kakao_user", name);
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