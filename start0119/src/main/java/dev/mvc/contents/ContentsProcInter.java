package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

import dev.mvc.stock.stockVO;

public interface ContentsProcInter {

	/**
	 * 카테고리 ajax
	 * @return
	 */
	public List<stockVO> CateGroupAjax(int categrpNo);
	
	/**
	 * 내용 생성
	 * @param ContentsCreateDto
	 * @return
	 */
	public int create(ContentsCreateDto ContentsCreateDto);
	
	/**
	 * 생성된 내용 번호 가져오기
	 * @return
	 */
	public int cotentsNoSelect();
	
	/**
	 * 파일 업로드
	 * @param map
	 * @return
	 */
	public int create(HashMap<String,Object> map);
	
	/**
	 * 게시글 가져오기
	 * @return
	 */
	public List<ContentsVO> list(HashMap<String,Object> map );
	/**
	 * 페이징 총 페이지
	 * @return
	 */
	public int pagingCount(HashMap<String, Object> map);
	
	/**
	 * 게시판 상세불러오기
	 * @param contentsNo
	 * @return
	 */
	public ContentsVO read(int contentsNo);
	
	public List<ContentsVO> contentsImageLoad(int contentsNo);
	
}
