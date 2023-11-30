package api.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
		
		try(Connection conn = DBConn.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)){
			 pstmt.setString(1, id);
			 pstmt.setString(2, pw);
			 pstmt.setString(3, name);
			 pstmt.setString(4, nick);
			 System.out.println("db데이터 넣기완료");
			 int affectedRows = pstmt.executeUpdate();
			System.out.println(affectedRows);
		        if (affectedRows > 0) {
		            // 삽입 성공 시, 메인 페이지로 리디렉트
//		            response.sendRedirect(request.getContextPath() + "/views/main/main.jsp");
//		        System.out.println("전송성공");
		        } else {
		            // 실패 시, 오류 페이지로 리디렉트
//		            response.sendRedirect("error.jsp");
		        }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
