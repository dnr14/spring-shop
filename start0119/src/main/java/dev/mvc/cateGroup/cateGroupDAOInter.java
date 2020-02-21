package dev.mvc.cateGroup;

import java.util.List;

public interface cateGroupDAOInter {
	
	/**
	 * 카테고리 생성
	 * @param create
	 * @return
	 */
	public int create(cateGroupCreateRequest cgc);
	
	/**
	 * 카테고리 목록
	 * @return
	 */
	public List<cateGroupVO> list();
	
	/**
	 * 카테고리 목록 갯수
	 * @return
	 */
	public int cateGroupCount();
	
	/**
	 *  카테고리 삭제
	 * @return
	 */
	public int cateGroupDelete(int categrpno);
	
	/**
	 *  카테고리 사이드 목록
	 * @return
	 */
	public List<cateGroupVO> cateGroupSideList();
	
	/**
	 * 카테고리 업데이트
	 * @return
	 */
	public  cateGroupVO cateGroupUpdateForm(cateGroupVO vo);
	
	/**
	 * 카테고리 수정 Proc
	 * @param vo
	 * @return
	 */
	public int cateGroupUpdateProc(cateGroupVO vo);
	
	/**
	 * 카테고리 네브바 목록
	 * @return
	 */
	public List<cateGroupVO> cateGroupTopList();
	
	/**
	 * 재고 등록 카테고리 호출
	 * @return
	 */
	public List<cateGroupVO> stockCateGroup();
	
	/**
	 * 카테고리 cnt up
	 * @param categrpno
	 * @return
	 */
	public int cateGroupCntUp(int categrpno);
	
	/**
	 * 카테고리 이름 호출
	 * @param categrpNo
	 * @return
	 */
	public String select(String categrpNo);
	
	public int cateGroupCntDown(int contentsno);
}
