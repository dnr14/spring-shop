package dev.mvc.contents;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ContentsCreateDto {

	private int categrpNo;
	private int stockNo;
	private String contents;
	private String title;
	private String keyword;
	private int deliveryCharge;
	private String manager;

   //파일 업로드	
	private MultipartFile fthum;
	private List<MultipartFile> fnamesMF;

	public MultipartFile getFthum() {
		return fthum;
	}

	public void setFthum(MultipartFile fthum) {
		this.fthum = fthum;
	}

	public List<MultipartFile> getFnamesMF() {
		return fnamesMF;
	}

	public void setFnamesMF(List<MultipartFile> fnamesMF) {
		this.fnamesMF = fnamesMF;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public int getDeliveryCharge() {
		return deliveryCharge;
	}

	public void setDeliveryCharge(int deliveryCharge) {
		this.deliveryCharge = deliveryCharge;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getStockNo() {
		return stockNo;
	}

	public void setStockNo(int stockNo) {
		this.stockNo = stockNo;
	}

	public int getCategrpNo() {
		return categrpNo;
	}

	public void setCategrpNo(int categrpNo) {
		this.categrpNo = categrpNo;
	}

	@Override
	public String toString() {
		return "ContentsCreateDto [categrpNo=" + categrpNo + ", stockNo=" + stockNo + ", contents=" + contents
				+ ", title=" + title + ", keyword=" + keyword + ", deliveryCharge=" + deliveryCharge + ", manager="
				+ manager + ", fthum=" + fthum + ", fnamesMF=" + fnamesMF + "]";
	}

	
}
