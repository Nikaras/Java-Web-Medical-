package servlet;
 
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.DBConnection;
 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Appointment;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/history")
public class AppointmentHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("ConnectedUser");
        if (user != null) {
            String type = session.getAttribute("UserType").toString();
            ArrayList<Appointment>  appointments;
            try {
                 appointments = DBConnection.getAppointments(user.getUsername(), type);
            } catch (SQLException e) {
                response.sendRedirect("WEB-INF/error.jsp");
                throw new RuntimeException(e);
            }

            request.setAttribute("Appointments", appointments);
            request.getRequestDispatcher("WEB-INF/appointmentHistory.jsp").forward(request, response);
        } else  {
            response.sendRedirect("WEB-INF/error.jsp?error=1");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("ConnectedUser");
        if (user != null) {
            System.out.println("/history doPost");
            JsonObject gson = new Gson().fromJson(request.getReader().readLine(), JsonObject.class);
            String date = gson.get("date").getAsString();
            String time = gson.get("time").getAsString();
            String status = gson.get("status").getAsString();
            String otherUser = gson.get("otherUser").getAsString();
            boolean freeUpAvailability = gson.get("freeUpAvailability").getAsBoolean();
            String doctorUsername = "";
            String patientUsername = "";

            System.out.println("UserType 1 = " + session.getAttribute("UserType"));
            if (session.getAttribute("UserType") != null) {
                if (session.getAttribute("UserType").toString().equals("patient") ) {
                    System.out.println("UserType 2 = patient");
                    doctorUsername = otherUser;
                    patientUsername = user.getUsername();
                } else if (session.getAttribute("UserType").toString().equals("doctor") ) {
                    System.out.println("UserType 2 = doctor");
                    doctorUsername = user.getUsername();
                    patientUsername = otherUser;
                }
                System.out.println(date + " " + time + " " + status + " " + doctorUsername + " " + patientUsername);
                try {
                    DBConnection.updateAppointmentStatus(doctorUsername, patientUsername, date, time, status);
                    if (status.equals("cancelled") || (status.equals("completed") && freeUpAvailability)) {
                        DBConnection.addAvailability(doctorUsername, date, time);
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        }
//        request.getRequestDispatcher("appointmentHistory.jsp").forward(request, response);
        response.setContentType("application/json");
        response.getWriter().write("{\"redirect\":\"" + request.getContextPath() + "/history\"}");

    }
}