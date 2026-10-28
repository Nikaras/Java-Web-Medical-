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
import java.sql.SQLException;

@WebServlet("/availability")
public class AvailabilityServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("ConnectedUser");
        if  (user != null) {
            try {
                String availabilityJson = DBConnection.getAvailability(user.getUsername());
                request.setAttribute("Availability", availabilityJson);
//            System.out.println(availabilityJson);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.getRequestDispatcher("WEB-INF/availability.jsp").forward(request, response);
        } else {
            response.sendRedirect("WEB-INF/error.jsp?error=1");
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("ConnectedUser");

        String jsonString = request.getParameter("availabilityJson");
        try {
            DBConnection.addAvailability(user.getUsername(), jsonString);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }


}
