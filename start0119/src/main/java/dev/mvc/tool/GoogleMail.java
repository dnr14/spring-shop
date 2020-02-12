package dev.mvc.tool;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

@Service("GoogleMail")
public class GoogleMail implements MailService{

  @Autowired
  private JavaMailSender mailSender;
  
  @Override
  public void sendMail() {
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
  }

}
