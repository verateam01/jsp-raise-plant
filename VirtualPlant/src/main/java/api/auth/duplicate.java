package api.auth;

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

@WebServlet("/api/duplicate")
public class duplicate extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public duplicate() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String sql = "select id from users where id=?";
		try(Connection conn = DBConn.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, id);
			
			ResultSet rs = pstmt.executeQuery();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			if(rs.next()) {
				response.getWriter().write("{\"status\":\"success\"}");
				System.out.println("중복된 아이디 있음");
			}else {
				response.getWriter().write("{\"status\":\"faild\"}");
				System.out.println("중복된 아이디 없음");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
