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

@WebServlet("/user")
public class UserDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("ConnectedUser");
        request.setAttribute("username", user.getUsername());
        request.setAttribute("name",user.getFirstName());
        request.setAttribute("surname", user.getLastName());
        request.setAttribute("amka", session.getAttribute("AMKA"));
        request.setAttribute("speciality", session.getAttribute("Speciality"));
        request.getRequestDispatcher("WEB-INF/userDetails.jsp").forward(request, response);

    }
}
