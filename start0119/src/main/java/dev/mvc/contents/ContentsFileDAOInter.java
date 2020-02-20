package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

public interface ContentsFileDAOInter {

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
	
	
	public List<ContentsVO> contentsImageLoad(int contentsNo);
}
