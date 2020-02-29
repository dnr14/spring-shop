package dev.mvc.payment;

public class PaymentCreateDTO {

	private String orderName;
	private String orderZipcode;
	private String orderAddress1;
	private String orderAddress2;
	private String orderPhone;
	private String kind;
	private String bank;
	
	private String memberid;
	private String stockName;
	private int stockPrice;
	private int stockCnt;
	private String status;
	private int totalPrice;
	private String deliveryStatus;
	private int staticNumber;// 송장번호
	
	public int getStaticNumber() {
		return staticNumber;
	}

	public void setStaticNumber(int staticNumber) {
		this.staticNumber = staticNumber;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public PaymentCreateDTO() {
		this.deliveryStatus = "배송 준비 중";
	}
	
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public String getOrderZipcode() {
		return orderZipcode;
	}
	public void setOrderZipcode(String orderZipcode) {
		this.orderZipcode = orderZipcode;
	}
	public String getOrderAddress1() {
		return orderAddress1;
	}
	public void setOrderAddress1(String orderAddress1) {
		this.orderAddress1 = orderAddress1;
	}
	public String getOrderAddress2() {
		return orderAddress2;
	}
	public void setOrderAddress2(String orderAddress2) {
		this.orderAddress2 = orderAddress2;
	}

	public String getOrderPhone() {
		return orderPhone;
	}

	public void setOrderPhone(String orderPhone) {
		this.orderPhone = orderPhone;
	}

	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int stockPrice, int stockCnt) {
		this.totalPrice = stockPrice * stockCnt;
	}
	public String getDeliveryStatus() {
		return deliveryStatus;
	}
	public void setDeliveryStatus(String deliveryStatus) {
		this.deliveryStatus = deliveryStatus;
	}

	@Override
	public String toString() {
		return "PaymentCreateDTO [orderName=" + orderName + ", orderZipcode=" + orderZipcode + ", orderAddress1="
				+ orderAddress1 + ", orderAddress2=" + orderAddress2 + ", orderPhone=" + orderPhone + ", kind=" + kind
				+ ", bank=" + bank + ", memberid=" + memberid + ", stockName=" + stockName + ", stockPrice="
				+ stockPrice + ", stockCnt=" + stockCnt + ", status=" + status + ", totalPrice=" + totalPrice
				+ ", deliveryStatus=" + deliveryStatus + ", staticNumber=" + staticNumber + "]";
	}

	
}
