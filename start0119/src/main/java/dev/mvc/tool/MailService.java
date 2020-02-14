package dev.mvc.tool;

import javax.servlet.http.HttpServletRequest;

public interface MailService {
    public void sendMail(String Id, String Email, String Pwd);
    public void sendMemberMail(String Id, String Email, String key, HttpServletRequest request);
}
