package dev.mvc.tool;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service("GoogleMail")
public class GoogleMail implements MailService {

	@Autowired
	private JavaMailSender mailSender;

	/**
	 * 비밀번호 찾기 이메일 발송
	 */
	@Override
	public void sendMail(String Id, String Email, String Pwd) {

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			String html = "<h1>비밀번호 찾기 결과입니다.</h1>";
			html += "<ul style='list-style:none;'>";
			html += "<li> 아이디 : " + Id + "</li>";
			html += "<li> 이메일 : " + Email + "</li>";
			html += "<li> 비밀번호 : " + Pwd + "</li>";
			html += "</ul>";

			messageHelper.setFrom("dnr145@gmail.com"); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(Email); // 받는사람 이메일
			messageHelper.setSubject(Id + "님 비밀번호 찾기"); // 메일제목은 생략이 가능하다
			messageHelper.setText(html, true); // 메일 내용
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 회원가입 이메일 인증
	 */
	@Override
	public void sendMemberMail(String Id, String Email, String key, HttpServletRequest request) {

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			String html = "<h2>안녕하세요 전자제품 : ) 관리자~ 입니다!</h2><br><br>";
			html += "<h3>" + Id + "님</h3>" + "<p>인증하기 버튼을 누르시면 로그인을 하실 수 있습니다 : ";
			html += "<a href='http://localhost:9090" + request.getContextPath() + "/member/key_alter?user_id=" + Id
					+ "&user_key=" + key + "'>인증하기</a></p>";

			messageHelper.setFrom("dnr145@gmail.com"); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(Email); // 받는사람 이메일
			messageHelper.setSubject("[본인인증] 전자제품 : )"+Id+"님의 인증메일입니다");
			messageHelper.setText(html, true); // 메일 내용
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
