package dev.mvc.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AdminCont {

  @Autowired
  @Qualifier("AdminProc")
  private AdminProcInter adminProc;
  
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


}
