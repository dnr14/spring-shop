package dev.mvc.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import dev.mvc.member.memberCreateRequest;
import dev.mvc.member.memberProcInter;
import dev.mvc.member.memberVO;
import dev.mvc.payment.PaymentProcInter;
import dev.mvc.payment.PaymentVO;
import dev.mvc.tool.DeliveryPageMaker;
import dev.mvc.tool.PageMaker;
import dev.mvc.tool.StockPageMaker;
import dev.mvc.tool.UserPageMaker;

@Controller
@RequestMapping("/admin")
public class AdminCont {

	@Autowired
	@Qualifier("AdminProc")
	private AdminProcInter adminProc;

	@Autowired
	@Qualifier("memberProc")
	private memberProcInter memberProc;

	@Autowired
	private PaymentProcInter paymentProc;

	public AdminCont() {
		System.out.println("AdminCont ==>  AdminCont 의존성 생성");
	}

	/**
	 * admin 로그인 화면
	 * 
	 * @param adminLoginCheck
	 * @return
	 */
	@GetMapping("/login")
	public ModelAndView AdminForm() {
		return new ModelAndView("admin/login").addObject("adminLoginCheck", new AdminLoginCheck());
	}

	/**
	 * admin 로그인 처리
	 * 
	 * @param adminLoginCheck
	 * @return
	 */
	@PostMapping("/login")
	public String AdminLoginProc(AdminLoginCheck adminLoginCheck, Errors errors, HttpSession session) {

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "id", "requierd", "관리자 아이디를 필수 입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pwd", "requierd", "패스워드는  필수 입니다.");

		if (errors.hasErrors()) {
			return "admin/login";
		} else {
			String admin_id = adminLoginCheck.getId();
			String admin_pwd = adminLoginCheck.getPwd();

			boolean sw = adminProc.login(admin_id, admin_pwd);

			if (sw == true) {
				session.setAttribute("admin_id", admin_id);
				session.setAttribute("admin_pwd", admin_pwd);
				session.setMaxInactiveInterval(60 * 30);
			} else {
				return "admin/login_fail";
			}

			return "redirect:/";
		}
	}

	/**
	 * admin 로그아웃
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/logOut")
	public String AdminLogOut(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	/**
	 * 유저 관라페이지
	 * 
	 * @return
	 */
	@GetMapping("/user")
	public String UserForm() {
		return "admin/user";
	}

	@GetMapping("/userUpdate")
	public ModelAndView UserUpdateForm(@RequestParam(value = "pagenum", defaultValue = "1") int pagenum) {
		ModelAndView mav = new ModelAndView("admin/userUpdate");
		UserPageMaker upm = new UserPageMaker();
		int totalcount = memberProc.userTotal();

		if (totalcount != 0) {

			upm.setTotalcount(totalcount);
			upm.setPagenum(pagenum);
			upm.setStartPageNum();
			upm.setEndPageNum();

			upm.setCurrentBlock();
			upm.setLastBlock();

			upm.setStartPage();
			upm.setEndPage(upm.getLastBlock(), upm.getCurrentBlock());

			upm.prevnext();

			List<memberVO> list = memberProc.userAll(upm);

			// 유저 모든 정보
			// 유저 페이징처리
			//
			mav.addObject("page", upm);
			mav.addObject("list", list);
		}
		return mav;
	}

	@PostMapping(value = "/userUpdate", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String UserUpdateAjax(String id) {
		JSONObject json = new JSONObject();
		memberVO vo = memberProc.memberSelect(id);
		try {
			String value = new ObjectMapper().writeValueAsString(vo);
			json.put("result", value);
		} catch (JsonProcessingException e) {
			json.put("error", "fail");
		}
		return json.toString();
	}

	/**
	 * 관리자 유저 수정
	 * 
	 * @param vo
	 * @return
	 */
	@PostMapping(value = "/update", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String update(memberCreateRequest vo) {
		JSONObject json = new JSONObject();
		int count = memberProc.memberUpdate(vo);
		if (count == 1) {
			System.out.println("성공");
			json.put("result", 0);
		}
		return json.toString();
	}

	/**
	 * 관리자 유저 삭제
	 * 
	 * @return
	 */
	@GetMapping("/userDelete")
	public ModelAndView UserDeleteForm(@RequestParam(value = "pagenum", defaultValue = "1") int pagenum) {
		ModelAndView mav = new ModelAndView("admin/userDelete");

		UserPageMaker upm = new UserPageMaker();
		int totalcount = memberProc.userTotal();

		if (totalcount != 0) {

			upm.setTotalcount(totalcount);
			upm.setPagenum(pagenum);
			upm.setStartPageNum();
			upm.setEndPageNum();

			upm.setCurrentBlock();
			upm.setLastBlock();

			upm.setStartPage();
			upm.setEndPage(upm.getLastBlock(), upm.getCurrentBlock());

			upm.prevnext();

			List<memberVO> list = memberProc.userAll(upm);
			mav.addObject("page", upm);
			mav.addObject("list", list);
		}

		return mav;
	}

	/**
	 * 유저 아이디 삭제
	 * 
	 * @param map
	 * @return
	 */
	@PostMapping("/delete")
	public @ResponseBody String DeleteAjax(@RequestBody Map<String, ArrayList<String>> map) {
		JSONObject json = new JSONObject();
		map.get("list").stream().forEach(c -> {
			int count = memberProc.memberDelete(c);
			if (count > 0) {
				System.out.println(c + " 아이디 삭제 ");
			}
		});
		return json.toString();
	}

	/**
	 * 배송관리
	 * 
	 * @return
	 */
	@GetMapping("/delivery")
	public ModelAndView deliveryForm(@RequestParam(value = "pagenum", defaultValue = "1") int pagenum,
			@RequestParam(value = "seach", defaultValue = "") String seach) {
		ModelAndView mav = new ModelAndView("admin/delivery");
		DeliveryPageMaker dpm = new DeliveryPageMaker();

		Map<String, Object> map = new HashMap<String , Object>();
		map.put("seach", seach);
		int totalcount = paymentProc.count(map);
		
		if (totalcount > 0) {
			dpm.setTotalcount(totalcount);
			dpm.setPagenum(pagenum);
			dpm.setStartPageNum();
			dpm.setEndPageNum();

			dpm.setCurrentBlock();
			dpm.setLastBlock();

			dpm.setStartPage();
			dpm.setEndPage(dpm.getLastBlock(), dpm.getCurrentBlock());

			dpm.prevnext();

			mav.addObject("delivery", paymentProc.delivery(dpm));
			mav.addObject("pm", dpm);
		}
		return mav;
	}

	@PostMapping("/updateAjax")
	public @ResponseBody String updateAjax(@RequestBody String array) {
		System.out.println(array);
		JSONArray json_array = new JSONArray(array);
		json_array.forEach(json -> {
			Map<String, Object> map = new JSONObject(json.toString()).toMap();
			paymentProc.update(map);
		});
		return new JSONObject().toString();
	}
	

	@RequestMapping(value = "/detaliAjax", produces = "text/plain;charset=UTF-8", method= {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String detaliAjax(int orderNo) {
		JSONObject json = null;
		
		try {
			json = new JSONObject();
			PaymentVO vo = paymentProc.detail(orderNo);
			String value = new ObjectMapper().writeValueAsString(vo);
			json.put("vo", value);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json.toString();
	}

}
