package dev.mvc.stock;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("stockProc")
public class stockProc implements stockProcInter{
	
	@Autowired
	stockDAOInter stockDAO;// stockDAOInter => stockDAOImpl

	@Override
	public int create(stockCreateRequest request) {
		return stockDAO.create(request);
	}

	@Override
	public List<stockVO> selectStock() {
		return stockDAO.selectStock();
	}
	

}
