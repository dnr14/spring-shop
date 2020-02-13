package dev.mvc.tool;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

import dev.mvc.member.memberIdPwdFind;

@Service("GoogleMail")
public class GoogleMail implements MailService {

	@Autowired
	private JavaMailSender mailSender;

	@Override
	public void sendMail(String Id, String Email, String Pwd) {

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			String html = "<h1>비밀번호 찾기 결과입니다.</h1>";
			html += "<ul><li>" + Id + "</li></ul>";
			html += "<ul><li>" + Email + "</li></ul>";
			html += "<ul><li>" + Pwd + "</li></ul>";

			messageHelper.setFrom("dnr145@gmail.com"); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(Email); // 받는사람 이메일
			messageHelper.setSubject(Id + "님 비밀번호 찾기"); // 메일제목은 생략이 가능하다
			messageHelper.setText(html, true); // 메일 내용
			mailSender.send(message);

		} catch (Exception e) {
			System.out.println(e);
		}
	}

}
