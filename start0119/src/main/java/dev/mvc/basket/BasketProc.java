package dev.mvc.basket;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BasketProc implements BasketProcInter {

	@Autowired
	BasketDAOInter basketDAO;

	@Override
	public int create(Map<String, Object> map) {
		return basketDAO.create(map);
	}

	@Override
	public int count(Map<String, Object> map) {
		return basketDAO.count(map);
	}

	@Override
	public int fivecount(String memberid) {
		return basketDAO.fivecount(memberid);
	}

	@Override
	public List<BasketVO> getbasket(String memberid) {
		return basketDAO.getbasket(memberid);
	}

	@Override
	public int delete(Map<String, Object> map) {
		return basketDAO.delete(map);
	}

}
