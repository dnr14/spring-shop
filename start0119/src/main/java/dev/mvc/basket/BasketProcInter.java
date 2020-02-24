package dev.mvc.basket;

import java.util.List;
import java.util.Map;

public interface BasketProcInter {
	public int create(Map<String, Object> map);

	public int count(Map<String, Object> map);

	public int fivecount(String memberid);

	public List<BasketVO> getbasket(String memberid);
	public int delete(Map<String, Object> map);

}
