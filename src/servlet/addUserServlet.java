package servlet;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Doctor;
import model.Patient;
import model.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/addUser")
public class addUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("ConnectedUser");

        if (user != null) {
            String type = session.getAttribute("UserType").toString();
            if (!type.equals("admin")) {
                response.sendRedirect("WEB-INF/error.jsp?error=3");
            }
            request.getRequestDispatcher("WEB-INF/addUser.jsp?usertype=" + request.getParameter("usertype")).forward(request, response);
        }
        response.sendRedirect("WEB-INF/error.jsp?error=1");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String amka = request.getParameter("amka");
        String acc_type = request.getParameter("acc_type");
        String speciality = request.getParameter("speciality");


        if (acc_type.equals("patient")) {
            try {
                DBConnection.addPatient(new Patient(username, fname, lname, amka), password);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else if (acc_type.equals("doctor")) {
            try {
                DBConnection.addDoctor(new Doctor(username, fname, lname, speciality), password);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin");
    }
}
