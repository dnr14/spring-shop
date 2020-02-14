package dev.mvc.stock;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("stockProc")
public class stockProc implements stockProcInter{
	
	@Autowired
	stockDAOInter stockDAO;

	@Override
	public int create(stockCreateRequest request) {
		return stockDAO.create(request);
	}
	

}
