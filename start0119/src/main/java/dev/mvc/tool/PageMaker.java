package dev.mvc.tool;

public class PageMaker {
	private int totalcount;// 전체 게시물 개수
	// 1 ~ 9 (1 * 9) - 8
	// 10 ~ 18 (2 * 9) - 8
	// 19 ~ 27 (3 * 9) - 8
	// 28 ~ 36 (4 * 9) - 8
	private int pagenum;// 현재 페이지 번호
	//private int contentnum = 3;// 현재 페이지에 몇개 표시
	private int contentnum = 9;// 현재 페이지에 몇개 표시
	private int startPageNum;
	private int endPageNum;

	private int startPage = 1;// 현재 페이지 블록의 시작페이지
	private int endPage = 5;// 현재 페이지 블록의 끝페이지

	private int currentblock;// 현재 페이지 블록
	private int lastblock;// 마지막 페이지 블록
	private boolean prev = false; // 이전
	private boolean next =false;// 다음

	public int getStartPageNum() {
		return startPageNum;
	}

	public void setStartPageNum(int pagenum) {
		// 1 ~ 2 1 * 2
		// 3 ~ 4 
		// 5 ~ 6
		this.startPageNum = (pagenum * this.contentnum) - 8;
		//this.startPageNum = (pagenum * this.contentnum) - 1;
	}

	public int getEndPageNum() {
		return endPageNum;
	}

	public void setEndPageNum(int pagenum) {
		this.endPageNum = (this.pagenum * this.contentnum);
	}

	public void prevnext(int pagenum) {
			
		if(getCurrentblock() == 1) {
			if(5 > getEndPage()) {
				setPrev(false);
				setNext(false);
			}
			else {
				setPrev(false);
				setNext(true);
			}
			
		} else if (getLastblock() == getCurrentblock()) {
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

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int currentblock) {
		// 1 ~ 5
		// 6 ~ 10
		this.startPage = (currentblock * 5) - 4;
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

	public int getCurrentblock() {
		return currentblock;
	}

	public void setCurrentblock(int pagenum) {

		// 페이지 번호를 통해서 구한다.
		// 1p 1 / 5 = 1
		// 6 6 / 5 = 1.2 + 1
		this.currentblock = pagenum / 5;
		if (pagenum % 5 > 0) {
			this.currentblock++;
		}
	}

	public int getLastblock() {
		return lastblock;
	}

	public void setLastblock(int totalcount) {

		this.lastblock = totalcount / (5 * this.contentnum);
		if (totalcount % (5 * this.contentnum) > 0) {
			this.lastblock++;
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

}
