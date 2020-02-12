package dev.mvc.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component("AdminProc")
public class AdminProc implements AdminProcInter{
  
  @Value("${admin1}")
  private String admin1;
  @Value("${admin2}")
  private String admin2;
  @Value("${admin3}")
  private String admin3;
  
  
  /**
   * 관리자 인지 검사
   * @param info
   * @param id
   * @return
   */
  public boolean admin_check(String id_admin, String passwd_admin) {
    boolean sw = false;
    String[] admins = {admin1, admin2, admin3};
    
    for (String admin:admins) {
      String[] tokens = admin.split("/");     
      if (tokens[0].equals(id_admin) && tokens[1].equals(passwd_admin)) {
        sw = true;
      }
    }
    
    return sw;
  }


  @Override
  public boolean login(String id_admin, String passwd_admin){

    boolean sw = admin_check(id_admin, passwd_admin);
    
    return sw;
  }


  @Override
  public boolean isAdmin(HttpSession session){
    boolean sw = false;
    
    String id_admin = (String)session.getAttribute("id_admin");
    
    if (id_admin != null){
      sw = true;
    }
    return sw;
  }
  
  
  @Override
  public String list() {
    String admins = "";
    admins = admin1 + "\n" + admin2 + "\n" + admin3;  
    
    return admins;
  }

}
