package servlet;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Doctor;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("ConnectedUser");
        if (user != null) {
            String type = session.getAttribute("UserType").toString();
            if (type.equals("doctor") || type.equals("admin")) {
                response.sendRedirect("WEB-INF/error.jsp?error=2");
            }
            ArrayList<Doctor> doctors = new ArrayList<>();
            try {
                doctors = DBConnection.getDoctors();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("Doctors", doctors);
            request.getRequestDispatcher("WEB-INF/appointment.jsp").forward(request, response);
        } else {
            response.sendRedirect("WEB-INF/error.jsp?error=1");
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Processing post request");
        String availability;
        ArrayList<Doctor> doctors;
        try {
            doctors = DBConnection.getDoctors(); // requesting doctor list again, since It's still needed
            availability = DBConnection.getAvailability(request.getParameter("doc_username"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("doc_username", request.getParameter("doc_username"));
        request.setAttribute("Availability", availability);
        request.setAttribute("Doctors", doctors);
        System.out.println(availability);
        request.getRequestDispatcher("WEB-INF/appointment.jsp").forward(request, response);
    }
}
