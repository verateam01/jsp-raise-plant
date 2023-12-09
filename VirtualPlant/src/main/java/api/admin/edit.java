package api.admin;

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

@WebServlet("/api/admin/user/edit")
public class edit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public edit() {
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
			userPstmt.setString(1,userId);
			ResultSet rsUser = userPstmt.executeQuery();
			if(rsUser.next()) {
				boolean isChanged = false;
                if (!rsUser.getString("id").equals(id)) isChanged = true;
                if (!rsUser.getString("userName").equals(userName)) isChanged = true;
                if (!rsUser.getString("userNick").equals(userNick)) isChanged = true;
                if (!rsUser.getString("email").equals(email)) isChanged = true;
                if (!rsUser.getString("userType").equals(userType)) isChanged = true;
                
                if(isChanged) {
                	String updateUser = "UPDATE users SET id = ?, userName = ?, userNick = ?, email = ?, userType = ? WHERE userId = ?";
                	try (PreparedStatement updatePstmt = conn.prepareStatement(updateUser)) {
                        updatePstmt.setString(1, id);
                        updatePstmt.setString(2, userName);
                        updatePstmt.setString(3, userNick);
                        updatePstmt.setString(4, email);
                        updatePstmt.setString(5, userType);
                        updatePstmt.setString(6, userId);

                        int updateCount = updatePstmt.executeUpdate();
                        
                        response.setContentType("application/json");
            			response.setCharacterEncoding("UTF-8");
                        if (updateCount > 0) {
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
