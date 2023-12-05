package api.plants;

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

@WebServlet("/api/plant/favorable")
public class favorable extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId=request.getParameter("userId");
		String plantId=request.getParameter("plantId");
		
		String findUserId = "select * from users where id=?;";
		String affectionSql = "SELECT affection FROM user_plants WHERE user_id = ? AND plant_id = ?;";
		
		try (Connection conn=DBConn.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(findUserId)){
			
			pstmt.setString(1, userId);
			ResultSet result = pstmt.executeQuery();
			
				try(PreparedStatement affectionPstmt=conn.prepareStatement(affectionSql)){
					affectionPstmt.setString(1, userId);
					affectionPstmt.setString(2, plantId);
					ResultSet rs = affectionPstmt.executeQuery();
					if (rs.next()) {
						
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
