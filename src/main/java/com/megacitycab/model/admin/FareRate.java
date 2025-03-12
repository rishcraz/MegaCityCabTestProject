package com.megacitycab.model.admin;

public class FareRate {
    private int id;
    private String carType;
    private double baseFare;
    private double perKmRate;
    private boolean multiplierEnabled;
    private double multiplier;
    private boolean taxEnabled;
    private double taxRate;
    private double discount;

    public FareRate(int id, String carType, double baseFare, double perKmRate, boolean multiplierEnabled, double multiplier, boolean taxEnabled, double taxRate, double discount) {
        this.id = id;
        this.carType = carType;
        this.baseFare = baseFare;
        this.perKmRate = perKmRate;
        this.multiplierEnabled = multiplierEnabled;
        this.multiplier = multiplier;
        this.taxEnabled = taxEnabled;
        this.taxRate = taxRate;
        this.discount = discount;
    }

  
    public int getId() { return id; }
    public String getCarType() { return carType; }
    public double getBaseFare() { return baseFare; }
    public double getPerKmRate() { return perKmRate; }
    public boolean isMultiplierEnabled() { return multiplierEnabled; }
    public double getMultiplier() { return multiplier; }
    public boolean isTaxEnabled() { return taxEnabled; }
    public double getTaxRate() { return taxRate; }
    public double getDiscount() { return discount; }

	public double getTax() {
		// TODO Auto-generated method stub
		return 0;
	}
}
