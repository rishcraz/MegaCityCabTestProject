package model.admin;

public class Car {
    private String carID;
    private String model;
    private String plateNumber;
    private String status;

    // Constructor with parameters
    public Car(String carID, String model, String plateNumber, String status) {
        this.carID = carID;
        this.model = model;
        this.plateNumber = plateNumber;
        this.status = status;
    }

    // Default constructor
    public Car() {}

    // Getters
    public String getCarId() { return carID; }
    public String getCarID() { return carID; }
    public String getModel() { return model; }
    public String getPlateNumber() { return plateNumber; }
    public String getStatus() { return status; }

    // Setters
    public void setCarID(String carID) { this.carID = carID; }
    public void setModel(String model) { this.model = model; }
    public void setPlateNumber(String plateNumber) { this.plateNumber = plateNumber; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "Car{" +
                "carID='" + carID + '\'' +
                ", model='" + model + '\'' +
                ", plateNumber='" + plateNumber + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
