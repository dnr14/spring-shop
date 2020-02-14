package dev.mvc.stock;

public class stockCreateRequest {
	
	private String stockName;
	private int stockCnt;
	private int stockPrice;
	private int categrpNo;
	private String manager;
	
	public stockCreateRequest() {
		System.out.println("stockCreateRequest VO(Value Obejct) »ý¼º");
	}
	
	public String getStockName() {
		return stockName;
	}
	public void setStockName(String stockName) {
		this.stockName = stockName;
	}
	public int getStockCnt() {
		return stockCnt;
	}
	public void setStockCnt(int stockCnt) {
		this.stockCnt = stockCnt;
	}
	public int getStockPrice() {
		return stockPrice;
	}
	public void setStockPrice(int stockPrice) {
		this.stockPrice = stockPrice;
	}
	public int getCategrpNo() {
		return categrpNo;
	}
	public void setCategrpNo(int categrpNo) {
		this.categrpNo = categrpNo;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	
}
