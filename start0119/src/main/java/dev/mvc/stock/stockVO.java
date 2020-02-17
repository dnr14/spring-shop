package dev.mvc.stock;

import java.util.StringTokenizer;

public class stockVO {
	
	private int stockNo;
	private int stockCnt;
	private String stockName;
	private int stockPrice;
	private int categrpNo;
	private String manager;
	private String stockRdate;
	// 재고에서 join으로 가져오기 위한 프로퍼티
	private String categrpName;
	
	
	@Override
	public String toString() {
		return "stockVO [stockNo=" + stockNo + ", stockCnt=" + stockCnt + ", stockName=" + stockName + ", stockPrice="
				+ stockPrice + ", categrpNo=" + categrpNo + ", manager=" + manager + ", stockRdate=" + stockRdate
				+ ", categrpName=" + categrpName + "]";
	}

	public void setCategrpName(String categrpName) {
		this.categrpName = categrpName;
	}
	
	public String getCategrpName() {
		return categrpName;
	}
	
	public int getStockNo() {
		return stockNo;
	}
	public void setStockNo(int stockNo) {
		this.stockNo = stockNo;
	}
	public int getStockCnt() {
		return stockCnt;
	}
	public void setStockCnt(int stockCnt) {
		this.stockCnt = stockCnt;
	}
	public String getStockName() {
		return stockName;
	}
	public void setStockName(String stockName) {
		this.stockName = stockName;
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
	public String getStockRdate() {
		return stockRdate;
	}
	public void setStockRdate(String stockRdate) {
		this.stockRdate = stockRdate;
	}
	
	

}
