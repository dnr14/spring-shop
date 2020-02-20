package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.stock.stockVO;

@Component("ContentsProc")
public class CotentsProc implements ContentsProcInter{
	
	@Autowired
	ContentsDAOInter ContentsDAO;
	
	@Autowired
	ContentsFileDAOInter ContentsFileDAO;

	@Override
	public List<stockVO> CateGroupAjax(int categrpNo) {
		return ContentsDAO.CateGroupAjax(categrpNo);
	}

	@Override
	public int create(ContentsCreateDto ContentsCreateDto) {
		return ContentsDAO.create(ContentsCreateDto);
	}

	@Override
	public int cotentsNoSelect() {
		return ContentsDAO.cotentsNoSelect();
	}

	@Override
	public int create(HashMap<String, Object> map) {
		return ContentsFileDAO.create(map);
	}



	@Override
	public List<ContentsVO> list(HashMap<String, Object> map) {
		return ContentsFileDAO.list(map);
	}

	@Override
	public int pagingCount(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return ContentsDAO.pagingCount(map);
	}

	@Override
	public ContentsVO read(int contentsNo) {
		return ContentsDAO.read(contentsNo);
	}

	@Override
	public List<ContentsVO> contentsImageLoad(int contentsNo) {
		return ContentsFileDAO.contentsImageLoad(contentsNo);
	}

	
	




}
