package dev.mvc.cateGroup;

public class cateGroupVO {
	
	private int categrpNo;
	private String categrpName;
	private int categrpCnt;
	private int categrpSeqno;
	private String categrpVisible;
	private String categrpRdate;
	
	
	public int getCategrpNo() {
		return categrpNo;
	}
	public void setCategrpNo(int categrpNo) {
		this.categrpNo = categrpNo;
	}
	public String getCategrpName() {
		return categrpName;
	}
	public void setCategrpName(String categrpName) {
		this.categrpName = categrpName;
	}
	public int getCategrpCnt() {
		return categrpCnt;
	}
	public void setCategrpCnt(int categrpCnt) {
		this.categrpCnt = categrpCnt;
	}
	public int getCategrpSeqno() {
		return categrpSeqno;
	}
	public void setCategrpSeqno(int categrpSeqno) {
		this.categrpSeqno = categrpSeqno;
	}
	public String getCategrpVisible() {
		return categrpVisible;
	}
	public void setCategrpVisible(String categrpVisible) {
		this.categrpVisible = categrpVisible;
	}
	public String getCategrpRdate() {
		return categrpRdate;
	}
	public void setCategrpRdate(String categrpRdate) {
		this.categrpRdate = categrpRdate;
	}
	@Override
	public String toString() {
		return "cateGroupVO [categrpNo=" + categrpNo + ", categrpName=" + categrpName + ", categrpCnt=" + categrpCnt
				+ ", categrpSeqno=" + categrpSeqno + ", categrpVisible=" + categrpVisible + ", categrpRdate="
				+ categrpRdate + "]";
	}

}
