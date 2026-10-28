package model;



public class Appointment {
    private Patient patient;
    private Doctor doctor;
    private String date;
    private String hour;
    private String status;

    public Appointment(Patient patient, Doctor doctor, String date, String hour, String status) {
        this.patient = patient;
        this.doctor = doctor;
        this.date = date;
        this.hour = hour;
        this.status = status;
    }

    public Patient getPatient() { return patient; }
    public Doctor getDoctor() { return doctor; }
    public String getDate() { return date; }
    public String getHour() { return hour; }
    public String getStatus() { return status; }

    public void setDate(String date) { this.date = date; }
    public void setHour(String hour) { this.hour = hour; }
    public void setStatus(String status) { this.status = status; }
}
