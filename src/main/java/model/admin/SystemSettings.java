package model.admin;

public class SystemSettings {
    private double baseFare;
    private double perKmRate;
    private double sedanMultiplier;
    private double suvMultiplier;
    private double luxuryMultiplier;
    private double taxRate;
    private double discountRate;

    public SystemSettings(double baseFare, double perKmRate, double sedanMultiplier, double suvMultiplier,
                          double luxuryMultiplier, double taxRate, double discountRate) {
        this.baseFare = baseFare;
        this.perKmRate = perKmRate;
        this.sedanMultiplier = sedanMultiplier;
        this.suvMultiplier = suvMultiplier;
        this.luxuryMultiplier = luxuryMultiplier;
        this.taxRate = taxRate;
        this.discountRate = discountRate;
    }

    public double getBaseFare() { return baseFare; }
    public double getPerKmRate() { return perKmRate; }
    public double getSedanMultiplier() { return sedanMultiplier; }
    public double getSuvMultiplier() { return suvMultiplier; }
    public double getLuxuryMultiplier() { return luxuryMultiplier; }
    public double getTaxRate() { return taxRate; }
    public double getDiscountRate() { return discountRate; }
}
