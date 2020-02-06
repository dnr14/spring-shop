package dev.mvc.stock;

public interface stockDAOInter {
	
	/**
	 * 재고 등록
	 * @param request
	 * @return
	 */
	public int create(stockCreateRequest request);

}
