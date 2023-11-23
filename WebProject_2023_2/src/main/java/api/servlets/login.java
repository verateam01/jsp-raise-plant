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
import javax.servlet.http.HttpSession;

import db.util.DBConn;
import model.User;

@WebServlet("/api/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		String sql = "select * from users where id=? and pw=?";
		User loginUser = null;
		try (Connection conn = DBConn.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				loginUser = new User();
				loginUser.setId(rs.getString("id"));
				loginUser.setPw(rs.getString("pw"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			
			
			if (loginUser != null) {
				HttpSession session = request.getSession();
				session.setAttribute("user", loginUser);
	            response.getWriter().write("{\"status\":\"success\"}");
	            System.out.println("로그인성공");
	        } else {
	            response.getWriter().write("{\"status\":\"failed\"}");
	            System.out.println("로그인실패");
	        }
			
		}
	}


