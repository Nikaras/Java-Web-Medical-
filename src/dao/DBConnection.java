package dao;

import general.General;
import model.Appointment;
import model.Doctor;
import model.Patient;
import model.User;
import java.sql.*;
import java.util.*;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/medical_system";
    private static final String USER = "root"; // change as needed
    private static final String PASSWORD = "3157"; // change as needed

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static User getUser(String username, String password, String acc_type) throws SQLException {
        User user = null;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM " + acc_type + " WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String salt =  rs.getString("salt");
                //stored hash
                String hashed_pwd = rs.getString("hashed_pwd");

                // generate new hash
                String hash = General.generateHash(password, salt);

                // check that the two hashes are the same
                if (hash.equals(hashed_pwd)) {
                    user = new User(rs.getString("username"), rs.getString("fname"), rs.getString("lname"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public static Doctor getDoctor(String username) throws SQLException {
        Doctor doctor  = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM doctor WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                doctor = new Doctor(rs.getString("username"), rs.getString("fname"), rs.getString("lname"), rs.getString("speciality"));
            }

        }
        return doctor;
    }

    public static Patient getPatient(String username) throws SQLException {
        Patient patient = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM patient WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                patient = new Patient(rs.getString("username"), rs.getString("fname"), rs.getString("lname"), rs.getString("amka"));
            }
        }
        return patient;
    }

    public static String getAMKA(User user) throws SQLException {
        String amka = "";
        try (Connection conn = DBConnection.getConnection()) {
            String  sql = "SELECT amka FROM patient WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                amka = rs.getString("amka");
            }
        }  catch (SQLException e) {
            e.printStackTrace();
        }
        return amka;
    }

    public static String getSpeciality(User user) throws SQLException {
        String speciality = "";
        try (Connection conn = DBConnection.getConnection()) {
            String  sql = "SELECT speciality FROM doctor WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                speciality = rs.getString("speciality");
            }
        }   catch (SQLException e) {
            e.printStackTrace();
        }
        return speciality;
    }


    public static void sanitizeAvailability() throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM availability WHERE `date` < CURDATE() OR `hours` IS NULL OR `hours` = ''";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.execute();
            int rs = stmt.getUpdateCount();
            System.out.println("DBConnection.sanitizeAvailability: affected " + rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static String getAvailability(String docUsername)  throws SQLException {
        sanitizeAvailability();
        HashMap<String, ArrayList<String>> availabilityMap = new HashMap<>();
        try (Connection conn = DBConnection.getConnection()) {
            String  sql = "SELECT date, hours FROM availability WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, docUsername);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                ArrayList<String> hours = new ArrayList<>(Arrays.asList(rs.getString("hours").split(",")));
                availabilityMap.put(rs.getString("date"), hours);
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return General.mapToJson(availabilityMap);
    }

    public static void addAvailability(String docUsername, String date, String time) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
          String sql = "UPDATE availability SET hours = CONCAT(hours, ?) WHERE username = ? and date = ?";
          PreparedStatement stmt = conn.prepareStatement(sql);
          stmt.setString(1, "," + time);
          stmt.setString(2, docUsername);
          stmt.setString(3, date);
          stmt.execute();
          int i  = stmt.getUpdateCount();
          System.out.println("DBConnection.addAvailability 1: affected " + i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void addAvailability(String docUsername, String availabilityJson) throws SQLException {
        System.out.println("Adding availability for user: " + docUsername);
        HashMap<String, ArrayList<String>> availabilityMap = General.jsonToMap(availabilityJson);
        for (String key : availabilityMap.keySet()) {
            ArrayList<String> hours = availabilityMap.get(key);
            if (!hours.isEmpty()) {
                StringJoiner sj= new StringJoiner(",");
                for (String hour : hours) {
                    sj.add(hour);
                }
                System.out.println("StringJoiner: " + sj);
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "INSERT INTO availability (username, date, hours) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE date = ?, hours = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, docUsername);
                    stmt.setString(2, key);
                    stmt.setString(3, sj.toString());
                    stmt.setString(4, key);
                    stmt.setString(5, sj.toString());
                    stmt.execute();
                    int i  = stmt.getUpdateCount();
                    System.out.println("DBConnection.addAvailability json: affected " + i);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static ArrayList<Doctor> getDoctors() throws SQLException {
        ArrayList<Doctor> doctors = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM doctor";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                doctors.add(new Doctor(rs.getString("username"), rs.getString("fname"), rs.getString("lname"), rs.getString("speciality")));
            }
        }
        return doctors;
    }

    public static void addAppointment(String docUsername, String patientUsername, String date, String hour) throws SQLException {
        try  (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO appointments VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE status = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, docUsername);
            stmt.setString(2, patientUsername);
            stmt.setString(3, date);
            stmt.setString(4, hour);
            stmt.setString(5, "pending");
            stmt.setString(6, "pending");
            stmt.execute();
            int i = stmt.getUpdateCount();
            System.out.println("DBConnection.addAppointment: affected " + i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void removeAvailability(String docUsername, String date, String hour) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            String  sql = "UPDATE availability SET hours = TRIM(BOTH ',' FROM REPLACE(CONCAT(',', hours, ','), ?, ',')) where username = ? and date = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "," + hour + ",");
            stmt.setString(2, docUsername);
            stmt.setString(3, date);
            System.out.println(stmt);
            stmt.execute();
            int i = stmt.getUpdateCount();
            System.out.println("DBConnection.removeAvailability: affected " + i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ArrayList<Appointment> getAppointments(String username, String userType) throws SQLException {
        ArrayList<Appointment> appointments = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql;
            if (userType.equals("doctor")) {
                sql = "SELECT * FROM appointments WHERE doctor_username = ?";
            } else {
                sql = "SELECT * FROM appointments WHERE patient_username = ?";
            }
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String doctorUsername = rs.getString("doctor_username");
                String patientUsername = rs.getString("patient_username");
                String date = rs.getString("date");
                String hour = rs.getString("hour");
                String status = rs.getString("status");
                appointments.add(new Appointment(getPatient(patientUsername), getDoctor(doctorUsername), date, hour, status));
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public static void updateAppointmentStatus(String docUsername, String patientUsername, String date, String hour, String status) throws SQLException {
        try  (Connection conn = DBConnection.getConnection()) {
            String sql = "update appointments set status = ? where doctor_username = ? and patient_username = ? and date = ? and hour = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setString(2, docUsername);
            stmt.setString(3, patientUsername);
            stmt.setString(4, date);
            stmt.setString(5, hour);
            stmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void addPatient(Patient patient, String password) throws SQLException {
        try  (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO patient VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, patient.getUsername());
            stmt.setString(2, patient.getFirstName());
            stmt.setString(3, patient.getLastName());
            stmt.setString(4, patient.getAmka());
            String salt = General.generateSalt();
            String hashedPwd = General.generateHash(password, salt);
            stmt.setString(5, hashedPwd);
            stmt.setString(6, salt);
            stmt.execute();
            int i = stmt.getUpdateCount();
            System.out.println("DBConnection.addPatient: affected " + i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void addDoctor(Doctor doctor, String password) throws SQLException {
        try  (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO doctor VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, doctor.getUsername());
            stmt.setString(2, doctor.getFirstName());
            stmt.setString(3, doctor.getLastName());
            stmt.setString(4, doctor.getSpecialty());
            String salt = General.generateSalt();
            String hashedPwd = General.generateHash(password, salt);
            stmt.setString(5, hashedPwd);
            stmt.setString(6, salt);
            stmt.execute();
            int i = stmt.getUpdateCount();
            System.out.println("DBConnection.addDoctor: affected " + i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void removeDoctor(String username, String fname, String lname) throws SQLException {
        try  (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM doctor WHERE username = ? AND fname = ?  AND lname = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, fname);
            stmt.setString(3, lname);
            stmt.execute();
            int i = stmt.getUpdateCount();
            System.out.println("DBConnection.removeDoctor: affected " + i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}