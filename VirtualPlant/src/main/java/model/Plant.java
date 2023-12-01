package model;

import java.time.LocalDateTime;

public class Plant {
	private String userId;
	private String plantId;
	private int affection;
	private int currStage;
	private int fertilizer;
	private int waterCount;
	private	LocalDateTime lastWatered;
	private LocalDateTime lastFertilized;
	public Plant(String userId, String plantId, int affection, int currStage, int fertilizer, int waterCount,
			LocalDateTime lastWatered, LocalDateTime lastFertilized) {
		super();
		this.userId = userId;
		this.plantId = plantId;
		this.affection = affection;
		this.currStage = currStage;
		this.fertilizer = fertilizer;
		this.waterCount = waterCount;
		this.lastWatered = lastWatered;
		this.lastFertilized = lastFertilized;
	}
	public Plant() {
		// TODO Auto-generated constructor stub
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPlantId() {
		return plantId;
	}
	public void setPlantId(String plantId) {
		this.plantId = plantId;
	}
	public int getAffection() {
		return affection;
	}
	public void setAffection(int affection) {
		this.affection = affection;
	}
	public int getCurrStage() {
		return currStage;
	}
	public void setCurrStage(int currStage) {
		this.currStage = currStage;
	}
	public int getFertilizer() {
		return fertilizer;
	}
	public void setFertilizer(int fertilizer) {
		this.fertilizer = fertilizer;
	}
	public int getWaterCount() {
		return waterCount;
	}
	public void setWaterCount(int waterCount) {
		this.waterCount = waterCount;
	}
	public LocalDateTime getLastWatered() {
		return lastWatered;
	}
	public void setLastWatered(LocalDateTime lastWatered) {
		this.lastWatered = lastWatered;
	}
	public LocalDateTime getLastFertilized() {
		return lastFertilized;
	}
	public void setLastFertilized(LocalDateTime lastFertilized) {
		this.lastFertilized = lastFertilized;
	}
	
}


