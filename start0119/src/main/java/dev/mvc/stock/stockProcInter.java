package dev.mvc.stock;

public interface stockProcInter {

	/**
	 * 재고 등록
	 * @param request
	 * @return
	 */
	public int create(stockCreateRequest request);
}
