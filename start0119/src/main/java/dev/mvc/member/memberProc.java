package dev.mvc.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("memberProc")
public class memberProc implements memberProcInter{
	
	@Autowired
	private memberDAOInter memberDAO;

	@Override
	public void register(memberCreateRequest mcr) throws Exception {
		int IdCount = selectById(mcr.getId());
		if(IdCount == 1) {
			throw new AlreadyExistingIdException(mcr.getId() + " 중복된 아이디 입니다.");
		}
		int EmailCount = selectByEamil(mcr.getEmail());
		if(EmailCount == 1) {
			throw new AlreadyExistingEmailException(mcr.getEmail() + " 중복된 이메일 입니다.");
		}
		create(mcr);
	}

	@Override
	public int selectByEamil(String email) {
		return memberDAO.selectByEamil(email);
	}

	@Override
	public int selectById(String id) {
		return memberDAO.selectById(id);
	}

	@Override
	public int create(memberCreateRequest mcr) {
		return memberDAO.create(mcr);
	}

	@Override
	public memberVO loginCheck(memberLoginCheck mlc) {
		return memberDAO.loginCheck(mlc);
	}

	
	
}
