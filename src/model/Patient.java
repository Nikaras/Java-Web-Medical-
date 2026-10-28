package model;

public class Patient extends User {
    private final String amka;

    public Patient(String username, String firstName, String lastName, String amka) {
        super(username, firstName, lastName);
        this.amka = amka;
    }

    public String getAmka() {
        return amka;
    }
}
