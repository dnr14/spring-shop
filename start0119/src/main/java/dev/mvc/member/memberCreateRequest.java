package dev.mvc.member;

public class  memberCreateRequest{

	private String id;
	private String email;
	private String pwd;
	private String pwd_check;
	private String phone;
	private String zipcode;
	private String address1;
	private String address2;
	
	public boolean isPwCheck() {
		return pwd.equals(pwd_check);
	}

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

	public String getPwd_check() {
		return pwd_check;
	}

	public void setPwd_check(String pwd_check) {
		this.pwd_check = pwd_check;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	@Override
	public String toString() {
		return "memberCreateRequest [id=" + id + ", email=" + email + ", pwd=" + pwd + ", pwd_check=" + pwd_check
				+ ", phone=" + phone + ", zipcode=" + zipcode + ", address1=" + address1 + ", address2=" + address2
				+ "]";
	}

	
	
	
}
