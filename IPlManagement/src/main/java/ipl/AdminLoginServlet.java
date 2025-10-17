package ipl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;

import java.io.IOException;

@WebServlet("/adminloginservlet")
public class AdminLoginServlet extends HttpServlet {

    private static final String ADMIN_USER = "admin";
    private static final String ADMIN_PASS = "admin123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        if (ADMIN_USER.equals(user) && ADMIN_PASS.equals(pass)) {
            // ✅ Login success
            HttpSession session = request.getSession();
            session.setAttribute("admin", user);
            response.sendRedirect("admindash.jsp");
        } else {
            // ❌ Login failed
            request.setAttribute("error", "Invalid username or password.");
            RequestDispatcher rd = request.getRequestDispatcher("adlogin.jsp");
            rd.forward(request, response);
        }
    }
}
