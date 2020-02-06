package dev.mvc.member;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping(value="/member")
public class memberCnt {

	@Autowired
	@Qualifier("memberProc")
	memberProcInter memberProc; // 다형성 memberProcInter memberProc = new memberProc

	public memberCnt() {
		System.out.println("memberCnt ==>  memberCnt 의존성 생성");
	}

	/**
	 * 회원가입 페이지
	 * 
	 * @return
	 */
	@GetMapping("/create")
	public ModelAndView createView(
			HttpServletRequest request,
			@CookieValue(value = "create_agree", required = false) Cookie cookie) throws Exception {

		String agree = "N";
		
		if(cookie !=null) {
			agree = cookie.getValue();
		}

		if (agree.equals("Y")) {
			return new ModelAndView("member/create").
					addObject("memberCreateRequest", new memberCreateRequest());
		} else {
			return new ModelAndView("/member/agreement");
		}
	}
	
	/**
	 * 회원가입 agreement
	 * @return
	 */
	@GetMapping("/agreement")
	public ModelAndView agreement() {
		return new ModelAndView("/member/agreement");
	}

	/**
	 * 회원가입 및 유효성 검사
	 * 
	 * @param mcr
	 * @param errors
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/create")
	public ModelAndView create(memberCreateRequest mcr, Errors errors) throws Exception {
		new RegisterRequestValidator().validate(mcr, errors);
		if (errors.hasErrors()) {
			return new ModelAndView("member/create");
		}

		try {
			memberProc.register(mcr);
		} catch (AlreadyExistingEmailException e) {
			errors.rejectValue("email", "duplicate", "이미 가입된 이메일입니다.");
		} catch (AlreadyExistingIdException e) {
			errors.rejectValue("id", "duplicate", "이미 가입된 아이디입니다.");
		} finally {
			if (errors.hasErrors()) {
				return new ModelAndView("member/create");
			}
		}
		// 회원가입 성공
		return new ModelAndView("member/createResult");
	}

	/**
	 * 로그인 페이지
	 * 
	 * @return
	 */
	@GetMapping("/login")
	public ModelAndView loginView(@CookieValue(value = "REMEMBER", required = false) Cookie cookie) {
		memberLoginCheck mlc = new memberLoginCheck();

		if (cookie != null) {
			JSONObject jsonObject = new JSONObject(cookie.getValue());
			mlc.setId(jsonObject.get("id").toString());
			mlc.setPwd(jsonObject.get("pwd").toString());
			mlc.setCookieCheck(true);
		}

		return new ModelAndView("member/login").addObject("memberLoginCheck", mlc);
	}

	/**
	 * 로그인 및 유효성 체크
	 * 
	 * @param mlc
	 * @param errors
	 * @return
	 */
	@PostMapping("/login")
	public ModelAndView loginProc(memberLoginCheck mlc, Errors errors, HttpSession session,
			HttpServletResponse response) {

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "id", "required", "아이디를 입력하세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pwd", "required", "비밀번호를 입력하세요.");

		if (errors.hasErrors()) {
			return new ModelAndView("member/login");
		}

		memberVO vo = memberProc.loginCheck(mlc);

		if (vo != null) {
			if (!mlc.isPwdCheck(vo.getPwd())) {
				errors.rejectValue("pwd", "bad", "패스워드가 틀립니다.");
			} else {
				// 로그인 성공
				session.setAttribute("id", vo.getId());

				String value = "";
				try {
					value = new ObjectMapper().writeValueAsString(mlc);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				Cookie cookie = new Cookie("REMEMBER", value);
				cookie.setPath("/");
				if (mlc.getCookieCheck()) {
					cookie.setMaxAge(60 * 60 * 24);
				} else {
					cookie.setMaxAge(0);
				}

				response.addCookie(cookie);
				return new ModelAndView("redirect:/");
			}
		} else {
			errors.rejectValue("id", "bad", "없는 회원 입니다.");
		}
		return new ModelAndView("member/login");
	}
	
	@GetMapping("/logOut")
	public ModelAndView logOut(HttpSession session) {
		System.out.println(session.getAttribute("id"));
		session.invalidate();
		return new ModelAndView("redirect:/");
	}
	
	
}
