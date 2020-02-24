package dev.mvc.member;

import java.util.HashMap;
import java.util.List;

import dev.mvc.tool.UserPageMaker;

public interface memberDAOInter {

	/**
	 * 아이디 생성
	 * @param mVO
	 * @return 생성 1 실패 0
	 */
	public int create(memberCreateRequest mcr);
	/**
	 * 이메일 중복 확인
	 * @param email
	 * @return 중복 1 미중복 0
	 */
	public int selectByEamil(String email);
	
	/**
	 * 아이디 중복 확인
	 * @param id
	 * @return 중복 1 미중복 0
	 */
	public int selectById(String id);

	/**
	 * 로그인 
	 * @param mlc
	 * @return 실패 null
	 */
	public memberVO loginCheck(memberLoginCheck mlc);
	
	/**
	 * Id 갯수
	 * @param email
	 * @return
	 */
	public int IdFindCount(String email);
	
	/**
	 * id 찾기
	 * @param email
	 * @return
	 */
	public String IdFind(String email);
	
	/**
	 * 비밀번호 갯수
	 * @param memberIdPwdFind
	 * @return
	 */
	public int PwdFindCount(memberIdPwdFind memberIdPwdFind);
	
	/**
	 * 비밀번호 찾기
	 * @param memberIdPwdFind
	 * @return
	 */
	public String PwdFind(memberIdPwdFind memberIdPwdFind);
	
	/**
	 * key 가져오기
	 * @return
	 */
	public String selectByKey(String id); 
	
	/**
	 * key update
	 * @param id
	 * @return
	 */
	public int updateKey(String id);
	
	/**
	 * 회원정보 조회
	 * @param id
	 * @return
	 */
	public memberVO memberSelect(String id);
	
	/**
	 * 회원정보 수정
	 * @param memberCreateRequest
	 * @return
	 */
	public int memberUpdate(memberCreateRequest memberCreateRequest);
	
	
	/**
	 *  비밀번호 변경
	 * @return
	 */
	public int memberPwdUpdate(HashMap<String,Object> map);
	
	
	/**
	 * 회원 삭제
	 * @param id
	 * @return
	 */
	public int memberDelete(String id);
	
	public List<memberVO> userAll(UserPageMaker userPageMaker);
	public int userTotal();
	
}
