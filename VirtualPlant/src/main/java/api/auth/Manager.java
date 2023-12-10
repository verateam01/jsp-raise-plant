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
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import db.util.DBConn;
import model.User;

@WebServlet("/api/magager")
public class Manager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Manager() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("id");
		String findUserSql = "select * from users where id=?";
		String findAllUserSql = "select * from users";
		try(Connection conn=DBConn.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(findUserSql)){
			pstmt.setString(1, userId);
			ResultSet rs = pstmt.executeQuery();
			User loginUser = null;
			if(rs.next()) {
				String userType=rs.getString("user_type");
				HttpSession session = request.getSession();
				session.setAttribute("userType",userType);
				
				if(userType=="admin") {
					try(PreparedStatement findUserPstmt = conn.prepareStatement(findAllUserSql)) {
						ResultSet result = findUserPstmt.executeQuery();
						if(result.next()) {
							loginUser = new User();
							loginUser.setId(rs.getString("id"));
							loginUser.setPw(rs.getString("user_name"));
							loginUser.setNick(rs.getString("user_nick"));
						}
					} 
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
