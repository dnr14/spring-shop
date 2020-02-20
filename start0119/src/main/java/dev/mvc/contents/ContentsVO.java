package dev.mvc.contents;

public class ContentsVO {
	
	private int categrpNo;
	private int contentsNo;
	private int stockNo;
	private String title;
	private String keyword;
	private int likey;
	private int deliveryCharge;
	private int cnt;
	private String rdata;
	private String manager;
	private String contents;
	private int file_no;
	private String fname;
	private String fupname;
	private String thumb;
	private long fsize;
	private String fdata;
	private String categrpName;
	private String stockName;
	private int stockPrice;
	private int stockCnt;
	
	
	public String getCategrpName() {
		return categrpName;
	}
	public void setCategrpName(String categrpName) {
		this.categrpName = categrpName;
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
	public int getStockCnt() {
		return stockCnt;
	}
	public void setStockCnt(int stockCnt) {
		this.stockCnt = stockCnt;
	}
	public int getCategrpNo() {
		return categrpNo;
	}
	public void setCategrpNo(int categrpNo) {
		this.categrpNo = categrpNo;
	}
	public int getContentsNo() {
		return contentsNo;
	}
	public void setContentsNo(int contentsNo) {
		this.contentsNo = contentsNo;
	}
	public int getStockNo() {
		return stockNo;
	}
	public void setStockNo(int stockNo) {
		this.stockNo = stockNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getLikey() {
		return likey;
	}
	public void setLikey(int likey) {
		this.likey = likey;
	}
	public int getDeliveryCharge() {
		return deliveryCharge;
	}
	public void setDeliveryCharge(int deliveryCharge) {
		this.deliveryCharge = deliveryCharge;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getRdata() {
		return rdata;
	}
	public void setRdata(String rdata) {
		this.rdata = rdata;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getFupname() {
		return fupname;
	}
	public void setFupname(String fupname) {
		this.fupname = fupname;
	}
	public String getThumb() {
		return thumb;
	}
	public void setThumb(String thumb) {
		this.thumb = thumb;
	}
	public long getFsize() {
		return fsize;
	}
	public void setFsize(long fsize) {
		this.fsize = fsize;
	}
	public String getFdata() {
		return fdata;
	}
	public void setFdata(String fdata) {
		this.fdata = fdata;
	}
	@Override
	public String toString() {
		return "ContentsVO [title=" + title + ", keyword=" + keyword + ", likey=" + likey + ", cnt=" + cnt + ", thumb="
				+ thumb + "]";
	}
	
	

}
