package dev.mvc.tool;

public class DeliveryPageMaker {
	private int totalcount;// 전체 페이지 수
	private int pagenum;// 보여줄 페이지 번호
	private int contentnum;// 몇개씩 가져올껀지

	private int startPageNum;// 시작 페이지 번호
	private int endPageNum;// 끝페이지 번호

	private int startPage;
	private int endPage;

	private int currentBlock;
	private int lastBlock;

	private boolean prev;
	private boolean next;

	public DeliveryPageMaker() {
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
		this.startPageNum = (this.pagenum * 10) - 9;
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

	public void setEndPage(int getlastblock, int getcurrentblock) {
		if (getlastblock == getcurrentblock) {
			this.endPage = calcpage(getTotalcount(), getContentnum());
		} else {
			this.endPage = getStartPage() + 4;
		}
	}

	public int getCurrentBlock() {
		return currentBlock;
	}

	public void setCurrentBlock() {
		this.currentBlock = this.pagenum / 5;
		if (pagenum % 5 > 0) {
			this.currentBlock++;
		}
	}

	public int getLastBlock() {
		return lastBlock;
	}

	public void setLastBlock() {
		this.lastBlock = this.totalcount / (5 * this.contentnum);
		if (totalcount % (5 * this.contentnum) > 0) {
			this.lastBlock++;
		}
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public void prevnext() {
		if (getCurrentBlock() == 1) {
			if (5 > getEndPage()) {
				setPrev(false);
				setNext(false);
			} else {
				setPrev(false);
				setNext(true);
			}

		} else if (getLastBlock() == getCurrentBlock()) {
			setPrev(true);
			setNext(false);
		} else {
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
		return "StockPageMaker [totalcount=" + totalcount + ", pagenum=" + pagenum + ", contentnum=" + contentnum
				+ ", startPageNum=" + startPageNum + ", endPageNum=" + endPageNum + ", startPage=" + startPage
				+ ", endPage=" + endPage + ", currentBlock=" + currentBlock + ", lastBlock=" + lastBlock + ", prev="
				+ prev + ", next=" + next + "]";
	}
}
