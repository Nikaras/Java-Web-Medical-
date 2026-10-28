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

@WebServlet("/makeAppointment")
public class MakeAppointmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("ConnectedUser");
        if (user != null) {
            System.out.println("Making appointment request");
            System.out.println("Patient: " + user.getUsername());
            System.out.println("Selected Doctor: " + request.getParameter("selected_doctor"));
            System.out.println("Selected Date: " + request.getParameter("date"));
            System.out.println("Selected Time: " + request.getParameter("time"));

            try {
                DBConnection.addAppointment(request.getParameter("selected_doctor"), user.getUsername(), request.getParameter("date"), request.getParameter("time"));
                DBConnection.removeAvailability(request.getParameter("selected_doctor"),  request.getParameter("date"), request.getParameter("time"));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

}
