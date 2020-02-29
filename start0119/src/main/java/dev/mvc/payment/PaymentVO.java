package dev.mvc.payment;

import java.util.Date;

public class PaymentVO {
	private int basketno;
	private String uri;
	private String title;
	private int cnt;
	private String thumb;

	private int stockprice;
	private String stockname;
	private int staticNumber;
	private int stockCnt;

	private String paymentkind;
	private String paymentBank;
	private String paymentStatus;
	private String deliveryStatus;	
	private int paymentPrice;
	
	private Date rdate;
	private int orderNo;
	
	private String orderName;
	private String orderZipcode;
	private String orderAddress1;
	private String orderAddress2;
	private String orderPhone;
	
	
	public int getStockCnt() {
		return stockCnt;
	}
	public void setStockCnt(int stockCnt) {
		this.stockCnt = stockCnt;
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
	public int getPaymentPrice() {
		return paymentPrice;
	}
	public void setPaymentPrice(int paymentPrice) {
		this.paymentPrice = paymentPrice;
	}
	public int getStaticNumber() {
		return staticNumber;
	}
	public void setStaticNumber(int staticNumber) {
		this.staticNumber = staticNumber;
	}
	public String getPaymentkind() {
		return paymentkind;
	}
	public void setPaymentkind(String paymentkind) {
		this.paymentkind = paymentkind;
	}
	public String getPaymentBank() {
		return paymentBank;
	}
	public void setPaymentBank(String paymentBank) {
		this.paymentBank = paymentBank;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getDeliveryStatus() {
		return deliveryStatus;
	}
	public void setDeliveryStatus(String deliveryStatus) {
		this.deliveryStatus = deliveryStatus;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getStockname() {
		return stockname;
	}
	public void setStockname(String stockname) {
		this.stockname = stockname;
	}
	public int getBasketno() {
		return basketno;
	}
	public void setBasketno(int basketno) {
		this.basketno = basketno;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getThumb() {
		return thumb;
	}
	public void setThumb(String thumb) {
		this.thumb = thumb;
	}
	public int getStockprice() {
		return stockprice;
	}
	public void setStockprice(int stockprice) {
		this.stockprice = stockprice;
	}
	@Override
	public String toString() {
		return "PaymentVO [stockprice=" + stockprice + ", stockname=" + stockname + ", stockCnt=" + stockCnt
				+ ", orderNo=" + orderNo + ", orderName=" + orderName + ", orderZipcode=" + orderZipcode
				+ ", orderAddress1=" + orderAddress1 + ", orderAddress2=" + orderAddress2 + ", orderPhone=" + orderPhone
				+ "]";
	}
	
	
}
