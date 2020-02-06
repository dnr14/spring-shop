package dev.mvc.member;

public class memberVO {
	
	private String id;
	private String email;
	private String pwd;
	private String phone;
	private String rdata;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRdata() {
		return rdata;
	}
	public void setRdata(String rdata) {
		this.rdata = rdata;
	}
	@Override
	public String toString() {
		return "memberVO [id=" + id + ", email=" + email + ", pwd=" + pwd + ", phone=" + phone + ", rdata=" + rdata
				+ "]";
	}
	

}
