package api.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.util.DBConn;

@WebServlet("/api/admin/user/edit")
public class UserEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UserEdit() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
        String id = request.getParameter("id");
        String userName = request.getParameter("userName");
        String userNick = request.getParameter("userNick");
        String email = request.getParameter("email");
        String userType = request.getParameter("userType");
        
        String findUserInfo = "select * from users where id = ?";
        
        try (Connection conn = DBConn.getConnection();
        		PreparedStatement userPstmt = conn.prepareStatement(findUserInfo)){
			userPstmt.setString(1,id);
			ResultSet rsUser = userPstmt.executeQuery();
			if(rsUser.next()) {
				System.out.println("실행1");
				boolean isChanged = false;
				if (!Objects.equals(rsUser.getString("id"), id)) isChanged = true;
		        if (!Objects.equals(rsUser.getString("user_name"), userName)) isChanged = true;
		        if (!Objects.equals(rsUser.getString("user_nick"), userNick)) isChanged = true;
		        if (!Objects.equals(rsUser.getString("email"), email)) isChanged = true;
		        if (!Objects.equals(rsUser.getString("user_type"), userType)) isChanged = true;
                
                if(isChanged) {
                	
                	String updateUser = "UPDATE users SET id = ?, user_name = ?, user_nick = ?, email = ?, user_type = ? WHERE id = ?";
                	try (PreparedStatement updatePstmt = conn.prepareStatement(updateUser)) {
                		
                        updatePstmt.setString(1, id);
                        updatePstmt.setString(2, userName);
                        updatePstmt.setString(3, userNick);
                        updatePstmt.setString(4, email);
                        updatePstmt.setString(5, userType);
                        updatePstmt.setString(6, id); /*user_id로 바꿔야함 쿼리문도*/

                        int updateCount = updatePstmt.executeUpdate();
                        
                        response.setContentType("application/json");
            			response.setCharacterEncoding("UTF-8");
                        if (updateCount > 0) {
                        	System.out.println("실행2");
                        	response.getWriter().write("{\"status\":\"success\"}");
            	            System.out.println("유저 수정성공");
                        } else {
                        	response.getWriter().write("{\"status\":\"fail\"}");
                        	System.out.println("유저 수정실패");
                        }
                	}
                }
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
