package dev.mvc.basket;

public class BasketVO {

/*	b.basketno, 
	b.title, 
	b.cnt, 
	b.memberid, 
	b.uri, 
	b.rdate, 
	cf.thumb */
	private int basketno;
	private String title;
	private int cnt;
	private String memberid;
	private String uri;
	private String rdate;
	private String thumb;
	public int getBasketno() {
		return basketno;
	}
	public void setBasketno(int basketno) {
		this.basketno = basketno;
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
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getThumb() {
		return thumb;
	}
	public void setThumb(String thumb) {
		this.thumb = thumb;
	}
	@Override
	public String toString() {
		return "BasketVO [basketno=" + basketno + ", title=" + title + ", cnt=" + cnt + ", memberid=" + memberid
				+ ", uri=" + uri + ", rdate=" + rdate + ", thumb=" + thumb + "]";
	}
	
}
