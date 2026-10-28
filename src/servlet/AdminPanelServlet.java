package servlet;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet("/admin")
public class AdminPanelServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("ConnectedUser");
        if (user != null) {
            String type = session.getAttribute("UserType").toString();
            if (!type.equals("admin")) {
                response.sendRedirect("WEB-INF/error.jsp?error=3");
            }
            request.getRequestDispatcher("WEB-INF/adminPanel.jsp").forward(request, response);
        } else  {
            response.sendRedirect("WEB-INF/error.jsp?error=1");
        }


    }
}
