package ipl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MatchServlet")
public class MatchServlet extends HttpServlet {

    private final MatchDaoImp dao = new MatchDaoImp();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add" -> addMatch(request, response);
            case "update" -> updateMatch(request, response);
        }
    }

 // In MatchServlet.java
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteMatch(request, response);
        } else if ("listCompleted".equals(action)) { // <--- ADD THIS ACTION
            listCompletedMatches(request, response);
        } else {
            // Default action or redirect if needed
            listCompletedMatches(request, response); // default to listing completed matches
        }
    }

    private void listCompletedMatches(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch the data from the DAO
            List<Match> completedMatches = dao.getCompletedMatches(); 
            
            // Set it as a request attribute
            request.setAttribute("matchList", completedMatches); 
            
            // Forward to the JSP page
            request.getRequestDispatcher("adminMatches.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading matches.");
        }
    }

    private void addMatch(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Match m = mapRequestToMatch(request);

            boolean success = dao.addMatch(m);
            if (success) {
                response.sendRedirect("adminMatches.jsp?status=success");
            } else {
                response.sendRedirect("addMatch.jsp?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addMatch.jsp?status=error");
        }
    }

    private void updateMatch(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Match m = mapRequestToMatch(request);

            boolean updated = dao.updateMatch(m);
            if (updated) {
                response.sendRedirect("adminMatches.jsp?status=updated");
            } else {
                response.sendRedirect("updateMatch.jsp?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateMatch.jsp?status=error");
        }
    }

    private void deleteMatch(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int matchId = Integer.parseInt(request.getParameter("matchId"));
            dao.deleteMatch(matchId);
            response.sendRedirect("adminMatches.jsp?status=deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminMatches.jsp?status=error");
        }
    }

    // ✅ Mapping Request Params to Match Bean
    private Match mapRequestToMatch(HttpServletRequest request) {
        Match m = new Match();

        m.setMatchId(Integer.parseInt(request.getParameter("matchId")));
        m.setTeam1Code(request.getParameter("team1"));      // ✅ match JSP
        m.setTeam2Code(request.getParameter("team2"));      // ✅ match JSP
        m.setVenue(request.getParameter("venue"));
        m.setMatchDate(request.getParameter("matchDate"));  // ✅ match JSP
        m.setMatchTime(request.getParameter("matchTime"));  // ✅ match JSP
        m.setStatus(request.getParameter("status"));        // ✅ match JSP
        m.setWinnerCode(request.getParameter("winnerCode"));
        m.setTeam1Score(request.getParameter("team1Score"));
        m.setTeam2Score(request.getParameter("team2Score"));

        return m;
    }

}
