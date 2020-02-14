
package dev.mvc.tool;

import java.security.MessageDigest;
import java.util.Random;

public class Sha256 {

	private int size = 20;
	private boolean lowerCheck = false;

	/**
	 * 회원가입 비밀번호 암호화
	 * 
	 * @param encodingText
	 * @return
	 */
	public static String encoding(String encodingText) {

		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(encodingText.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

			StringBuffer hexString = new StringBuffer();

			for (int i = 0; i < byteData.length; i++) {
				String hex = Integer.toHexString(0xff & byteData[i]);

				if (hex.length() == 1) {
					hexString.append('0');
				}
				hexString.append(hex);
			}
			return hexString.toString();

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}

	/**
	 * 이메일 난수 생성
	 * @return
	 */
	private String init() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;

		do {
			num = ran.nextInt(75) + 48;
			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}

		} while (sb.length() < size);

		if (lowerCheck) {
			return sb.toString().toLowerCase();
		}

		return sb.toString();
	}

	/**
	 * 난수 생성 => sha 256 암호화 => 디비 저장 => 이메일 보내기
	 *  난수를 이용한 키 생성
	 * @param lowerCheck
	 * @param size
	 * @return
	 */
	public  String getKey(boolean lowerCheck, int size) {
		this.lowerCheck = lowerCheck;
		this.size = size;
		return init();
	}

}
