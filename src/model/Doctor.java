package model;

public class Doctor extends User {
    private String specialty;

    public Doctor(String username, String firstName, String lastName, String specialty) {
        super(username, firstName, lastName);
        this.specialty = specialty;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

//    public void setAvailability() {
//        System.out.println("Doctor " + firstName + " availability updated.");
//    }
//
//    public void viewSchedule() {
//        System.out.println("Doctor " + firstName + " viewing appointment schedule.");
//    }
}