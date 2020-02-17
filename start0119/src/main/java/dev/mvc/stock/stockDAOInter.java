package dev.mvc.stock;

import java.util.List;

public interface stockDAOInter {
	
	/**
	 * 재고 등록
	 * @param request
	 * @return
	 */
	public int create(stockCreateRequest request);

	/**
	 * 재고 가져오기
	 * @return
	 */
	public List<stockVO> selectStock();
	
}
