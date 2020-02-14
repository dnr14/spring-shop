package dev.mvc.member;

public class memberIdPwdFind {

	private String email;
	private String id;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "memberIdPwdFind [email=" + email + ", id=" + id + "]";
	}

}
