package ipl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PlayerServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  // 1MB
    maxFileSize = 1024 * 1024 * 5,        // 5MB
    maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class PlayerServlet extends HttpServlet {

    private final PlayerDaoImp dao = new PlayerDaoImp();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "add" -> addPlayer(request, response);
            case "update" -> updatePlayer(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) deletePlayer(request, response);
    }

    private void addPlayer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Player p = mapRequestToPlayer(request);

            // Check if jersey number already exists for this team
            Player existing = dao.getPlayerByJersey(p.getJerseyNumber(), p.getTeamCode());
            if (existing != null) {
                // Redirect with duplicate status
                response.sendRedirect("addPlayer.jsp?status=duplicate");
                return;
            }

            boolean success = dao.addPlayer(p);
            if (success) {
                response.sendRedirect("adminPlayers.jsp?status=success");
            } else {
                response.sendRedirect("addPlayer.jsp?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addPlayer.jsp?status=error");
        }
    }


    private void updatePlayer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Player p = mapRequestToPlayer(request);

            // If no new file uploaded, keep existing image
            if (p.getImagePath() == null) {
                Player existing = dao.getPlayerByJersey(p.getJerseyNumber(), p.getTeamCode());
                if (existing != null) {
                    p.setImagePath(existing.getImagePath());
                }
            }

            boolean updated = dao.updatePlayer(p);
            if (updated) {
                response.sendRedirect("adminPlayers.jsp?status=updated");
            } else {
                response.sendRedirect("updatePlayer.jsp?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updatePlayer.jsp?status=error");
        }
    }

    private void deletePlayer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int jerseyNumber = Integer.parseInt(request.getParameter("jerseyNumber"));
            String teamCode = request.getParameter("teamCode");
            dao.deletePlayer(jerseyNumber, teamCode);
            response.sendRedirect("adminPlayers.jsp?status=deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admindash.jsp?status=error");
        }
    }

    // ✅ Helper to map request parameters & handle file upload
    private Player mapRequestToPlayer(HttpServletRequest request) throws IOException, ServletException {
        Player p = new Player();
        p.setJerseyNumber(Integer.parseInt(request.getParameter("jerseyNumber")));
        p.setPlayerName(request.getParameter("playerName"));
        p.setAge(Integer.parseInt(request.getParameter("age")));
        p.setRole(request.getParameter("role"));
        p.setNationality(request.getParameter("nationality"));
        p.setTeamCode(request.getParameter("teamCode"));

        // File upload
        Part filePart = request.getPart("playerImage");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("/images");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
            filePart.write(uploadPath + File.separator + fileName);
            p.setImagePath("images/" + fileName);
        }

        return p;
    }
}
