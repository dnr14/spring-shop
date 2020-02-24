package dev.mvc.tool;

public class UserPageMaker {
	
	private int totalcount;
	private int pagenum;
	private int contentnum;
	
	private int startPageNum;
	private int endPageNum;
	
	private int startPage;
	private int endPage;
	
	private int currentBlock;
	private int lastBlock;
	
	private boolean prev;
	private boolean next;
	
	public UserPageMaker() {
		this.prev = false;
		this.next = false;
		this.contentnum = 10;
	}
	
	public int getTotalcount() {
		return totalcount;
	}
	
	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}
	
	public int getPagenum() {
		return pagenum;
	}
	
	public void setPagenum(int pagenum) {
		this.pagenum = pagenum;
	}
	
	public int getContentnum() {
		return contentnum;
	}
	
	public void setContentnum(int contentnum) {
		this.contentnum = contentnum;
	}
	
	
	public int getStartPageNum() {
		return startPageNum;
	}
	
	public void setStartPageNum() {
		this.startPageNum = (this.pagenum * 10)  - 9;
	}
	
	public int getEndPageNum() {
		return endPageNum;
	}
	
	public void setEndPageNum() {
		this.endPageNum = (this.pagenum * 10);
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public void setStartPage() {
		this.startPage = (this.currentBlock * 5) - 4;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public void setEndPage(int lastBlock, int currentBlock) {
		boolean pass = lastBlock == currentBlock;
		if(pass) {
			this.endPage = calcpage(getTotalcount(), getContentnum());
		}
		else
		{
			this.endPage = getStartPage() + 4;
		}
	}
	
	public int getCurrentBlock() {
		return currentBlock;
	}
	
	public void setCurrentBlock() {
		this.currentBlock = this.pagenum / 5;
		if(pagenum % 5 > 0) {
			this.currentBlock++;
		}
	}
	
	public int getLastBlock() {
		return lastBlock;
	}
	
	public void setLastBlock() {
		this.lastBlock = this.totalcount / this.contentnum;
		if(this.totalcount % this.contentnum > 0) {
			this.lastBlock++;
		}
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	
	public boolean isPrev() {
		return prev;
	}

	public void setNext(boolean next) {
		this.next = next;
	}
	
	public boolean isNext() {
		return next;
	}
	
	public void prevnext() {
		if(getCurrentBlock() == 1) {
			if(5 > getEndPage()) {
				setPrev(false);
				setNext(false);
			}
			else {
				setPrev(false);
				setNext(true);
			}
			
		} else if (getLastBlock() == getCurrentBlock()) {
			setPrev(true);
			setNext(false);
		}else {
			setPrev(true);
			setNext(true);
		}
	}
	
	public int calcpage(int totalcount, int contentnum) {
		int totalpage = totalcount / contentnum;
		if (totalcount % contentnum > 0) {
			totalpage++;
		}
		return totalpage;
	}

	@Override
	public String toString() {
		return "UserPageMaker [totalcount=" + totalcount + ", pagenum=" + pagenum + ", contentnum=" + contentnum
				+ ", startPageNum=" + startPageNum + ", endPageNum=" + endPageNum + ", startPage=" + startPage
				+ ", endPage=" + endPage + ", currentBlock=" + currentBlock + ", lastBlock=" + lastBlock + ", prev="
				+ prev + ", next=" + next + "]";
	}
	

}
