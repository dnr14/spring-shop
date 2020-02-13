package dev.mvc.member;

public interface memberProcInter {

	/**
	 * 아이디 생성
	 * @param mVO
	 * @return 생성 1 실패 0
	 */
	public int create(memberCreateRequest mcr);
	
	/**
	 * 유효성 검사
	 * @param mcr
	 * @throws Exception
	 */
	void register(memberCreateRequest mcr) throws Exception;
	
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
	 * Id 찾기
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
	

}
