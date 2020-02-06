package dev.mvc.member;

public class memberLoginCheck {
	
	private String id;
	private String pwd;
	private boolean cookieCheck;
	
	public boolean isPwdCheck(String pwdCheck) {
		return this.pwd.equals(pwdCheck);
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public boolean getCookieCheck() {
		return cookieCheck;
	}

	public void setCookieCheck(boolean cookieCheck) {
		this.cookieCheck = cookieCheck;
	}

	

}
