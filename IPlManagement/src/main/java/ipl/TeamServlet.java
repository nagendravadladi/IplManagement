package ipl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/TeamServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 5,        // 5MB
    maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class TeamServlet extends HttpServlet {

    // Assuming you have a TeamDaoImp class available
    private TeamDaoImp dao = new TeamDaoImp();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addTeam(request, response);
        } else if ("update".equals(action)) {
            updateTeam(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteTeam(request, response);
        }
    }

    private void addTeam(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Team team = new Team();
            String teamCode = request.getParameter("teamCode");
            team.setTeamCode(teamCode);
            team.setTeamName(request.getParameter("teamName"));
            team.setCountry(request.getParameter("country"));
            team.setCoachName(request.getParameter("coachName"));
            team.setCaptainName(request.getParameter("captainName"));

            // 1. Check for duplicate team code
            if (dao.getTeamByCode(teamCode) != null) {
                // Redirect back to the form with a specific 'duplicate' status
                response.sendRedirect("addTeam.jsp?status=duplicate&teamCode=" + teamCode);
                return;
            }

            // 2. Handle file upload (keeping your existing logic)
            String uploadPath = getServletContext().getRealPath("/images");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            Part filePart = request.getPart("teamLogo");
            String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            String contextPath = request.getContextPath();
            team.setLogoPath(contextPath + "/images/" + fileName);

            // 3. Attempt to add the team
            boolean success = dao.addTeam(team);

            if (success) {
                // Redirect to dashboard with success status
                response.sendRedirect("admindash.jsp?status=success");
            } else {
                // Redirect to form with generic error status
                response.sendRedirect("addTeam.jsp?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addTeam.jsp?status=error");
        }
    }
    
    private void updateTeam(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Team team = new Team();
            team.setTeamCode(request.getParameter("teamCode"));
            team.setTeamName(request.getParameter("teamName"));
            team.setCountry(request.getParameter("country"));
            team.setCoachName(request.getParameter("coachName"));
            team.setCaptainName(request.getParameter("captainName"));
    
            Part filePart = request.getPart("teamLogo");
    
            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("/images");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
    
                String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
    
                String contextPath = request.getContextPath(); 
                team.setLogoPath(contextPath + "/images/" + fileName);
            } else {
                // Use existing logo path if no new file is uploaded
                Team existing = dao.getTeamByCode(team.getTeamCode());
                if (existing != null) {
                    team.setLogoPath(existing.getLogoPath());
                }
            }
    
            boolean updated = dao.updateTeam(team);
            
            if (updated) {
                // Redirect to dashboard with a specific 'updated' status
                response.sendRedirect("admindash.jsp?status=updated");
            } else {
                response.sendRedirect("updateTeam.jsp?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateTeam.jsp?status=error");
        }
    }


    private void deleteTeam(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String code = request.getParameter("teamCode");
            dao.deleteTeam(code);
            // Redirect to dashboard with a specific 'deleted' status
            response.sendRedirect("admindash.jsp?status=deleted");
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect to dashboard with error status
            response.sendRedirect("admindash.jsp?status=error");
        }
    }
}
