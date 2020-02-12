package dev.mvc.admin;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
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

  @Autowired
  private JavaMailSender mailSender;

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

      return "index";
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
    return "index";
  }

  @GetMapping("/mail")
  public ModelAndView sendMail() {
    System.out.println(mailSender.toString());

    final MimeMessagePreparator message = new MimeMessagePreparator() {
      @Override
      public void prepare(MimeMessage mimeMessage) throws Exception {
        final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
        
        helper.setFrom("dnr0145@gmail.com"); // 보내는사람 생략하면 정상작동을 안함
        helper.setTo("dnr14@naver.com"); // 받는사람 이메일
        helper.setSubject("테스트"); // 메일제목은 생략이 가능하다
        helper.setText("<h1>안녕</h1>",true); // 메일 내용
      }

    };
    
    mailSender.send(message);

    return new ModelAndView("redirect:/");
  }

}
