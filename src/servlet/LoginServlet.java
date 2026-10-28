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

// For ease of use all passwords are set to 123

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String type = request.getParameter("acc_type");

        User user = null;
        String extra = "";

        try {
            user = DBConnection.getUser(username, password, type);
            if (user == null) {
                request.getRequestDispatcher("login.jsp?error=1").forward(request, response);
            } else {
                if (type.equals("patient")) {
                    extra = DBConnection.getAMKA(user);
                } else if (type.equals("doctor")) {
                    extra = DBConnection.getSpeciality(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }

        HttpSession session = request.getSession();
        session.setAttribute("ConnectedUser", user);
        session.setAttribute("UserType", type);
        if (type.equals("patient")) {
            session.setAttribute("AMKA", extra);
        } else if (type.equals("doctor")) {
            session.setAttribute("Speciality", extra);
        }
        request.getRequestDispatcher("WEB-INF/welcome.jsp").forward(request, response);
    }
}