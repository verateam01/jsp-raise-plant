package api.admin;

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

@WebServlet("/api/admin/plant/edit")
public class PlantEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public PlantEdit() {
        super();
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
        String newGardeniaName = request.getParameter("gardenia");
        String newHyacinthName = request.getParameter("hyacinth");
        String newCactusName = request.getParameter("cactus");

        try (Connection conn = DBConn.getConnection()) {
            conn.setAutoCommit(false);

            // Update Gardenia Name
            updatePlantName(conn, userId, 1, newGardeniaName); // Assuming Gardenia has plant_id = 1
            // Update Hyacinth Name
            updatePlantName(conn, userId, 2, newHyacinthName); // Assuming Hyacinth has plant_id = 2
            // Update Cactus Name
            updatePlantName(conn, userId, 3, newCactusName); // Assuming Cactus has plant_id = 3

            conn.commit();
            response.getWriter().write("{\"status\":\"success\"}");
        }catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\"}");
        }
		
	}
	private void updatePlantName(Connection conn, String userId, int plantId, String newPlantName) throws SQLException {
        String query = "UPDATE plants p JOIN user_plants up ON p.user_plant_id = up.user_plant_id " +
                       "SET p.plant_name = ? WHERE up.user_id = ? AND up.plant_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, newPlantName);
            pstmt.setString(2, userId);
            pstmt.setInt(3, plantId);
            pstmt.executeUpdate();
        }
    }

}
