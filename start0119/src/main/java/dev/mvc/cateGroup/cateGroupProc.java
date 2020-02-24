package dev.mvc.cateGroup;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class cateGroupProc implements cateGroupProcInter{
	
	@Autowired
	cateGroupDAOInter cateGroupDAO;

	@Override
	public int create(cateGroupCreateRequest cgc) {
		return cateGroupDAO.create(cgc);
	}

	@Override
	public List<cateGroupVO> list() {
		return cateGroupDAO.list();
	}

	@Override
	public int cateGroupCount() {
		return cateGroupDAO.cateGroupCount();
	}

	@Override
	public int cateGroupDelete(int categrpno) {
		return cateGroupDAO.cateGroupDelete(categrpno);
	}

	@Override
	public List<cateGroupVO> cateGroupSideList() {
		return cateGroupDAO.cateGroupSideList();
	}

	@Override
	public cateGroupVO cateGroupUpdateForm(cateGroupVO vo) {
		return cateGroupDAO.cateGroupUpdateForm(vo);
	}

	@Override
	public int cateGroupUpdateProc(cateGroupVO vo) {
		return cateGroupDAO.cateGroupUpdateProc(vo);
	}


	@Override
	public List<cateGroupVO> stockCateGroup() {
		return cateGroupDAO.stockCateGroup();
	}

	@Override
	public int cateGroupCntUp(int categrpno) {
		return cateGroupDAO.cateGroupCntUp(categrpno);
	}

	@Override
	public List<cateGroupVO> cateGroupTopList() {
		// TODO Auto-generated method stub
		return cateGroupDAO.cateGroupTopList();
	}

	@Override
	public String select(String categrpNo) {
		return cateGroupDAO.select(categrpNo);
	}

	@Override
	public int cateGroupCntDown(int categrpNo) {
		return cateGroupDAO.cateGroupCntDown(categrpNo);
	}

	
}
