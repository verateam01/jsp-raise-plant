package api.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.util.DBConn;

@WebServlet("/api/admin/user/delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Delete() {
        super();
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String userId = request.getParameter("userId");

        try (Connection conn = DBConn.getConnection()) {
            // 트랜잭션 시작
            conn.setAutoCommit(false);

            // user_plants 테이블에서 해당 user_id를 가진 레코드의 plant_id 찾기
            String findPlantIds = "SELECT plant_id FROM user_plants WHERE user_id = ?";
            List<String> plantIds = new ArrayList<>();
            try (PreparedStatement pstmt = conn.prepareStatement(findPlantIds)) {
                pstmt.setString(1, userId);
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    plantIds.add(rs.getString("plant_id"));
                }
            }

            // plants 테이블에서 찾은 plant_id를 가진 레코드 삭제
            for (String plantId : plantIds) {
                String deletePlant = "DELETE FROM plants WHERE plant_id = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(deletePlant)) {
                    pstmt.setString(1, plantId);
                    pstmt.executeUpdate();
                }
            }

            // user_plants 테이블에서 해당 user_id를 가진 레코드 삭제
            String deleteUserPlants = "DELETE FROM user_plants WHERE user_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(deleteUserPlants)) {
                pstmt.setString(1, userId);
                pstmt.executeUpdate();
            }

            // users 테이블에서 사용자 삭제
            String deleteUser = "DELETE FROM users WHERE user_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(deleteUser)) {
                pstmt.setString(1, userId);
                pstmt.executeUpdate();
            }

            // 트랜잭션 커밋
            conn.commit();
            response.getWriter().write("{\"status\":\"success\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\"}");
        }
	}

}
