package dev.mvc.member;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class RegisterRequestValidator implements Validator {

	private static final String emailRegExp = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
			+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	private static final String phoneNumberExp = "^01[017]-\\d{3,4}-\\d{4}";

	private Matcher matcher;
	
	public RegisterRequestValidator() {
		System.out.println("회원 가입 검사 시작 ===>");
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return memberCreateRequest.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		memberCreateRequest mcr = (memberCreateRequest) target;

		if (mcr.getEmail() == null || mcr.getEmail().trim().isEmpty()) {
			errors.rejectValue("email", "required", "필수 정보 입니다.");
		} else {
			matcher = Pattern.compile(emailRegExp).matcher(mcr.getEmail());
			if (!matcher.matches()) {
				errors.rejectValue("email", "bad", "올바르지 않는 형식입니다.");
			}
				
			matcher = Pattern.compile(phoneNumberExp).matcher(mcr.getPhone());
			if (!matcher.matches()) {
				errors.rejectValue("phone", "bad", "올바르지 않는 형식입니다.");
			}
		}

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "id", "required", "필수 정보입니다.");
		ValidationUtils.rejectIfEmpty(errors, "pwd", "required", "필수 정보입니다.");
		ValidationUtils.rejectIfEmpty(errors, "phone", "required", "필수 정보입니다.");
		ValidationUtils.rejectIfEmpty(errors, "zipcode", "required", "필수 정보입니다.");
		ValidationUtils.rejectIfEmpty(errors, "address1", "required", "필수 정보입니다.");
		ValidationUtils.rejectIfEmpty(errors, "address2", "required", "필수 정보입니다.");

		if (!mcr.getPwd().isEmpty()) {
			if (mcr.getPwd_check().isEmpty()) {
				ValidationUtils.rejectIfEmpty(errors, "pwd_check", "required", "필수 정보입니다.");
			} else if (!mcr.isPwCheck()) {
				errors.rejectValue("pwd_check", "nomatch", "비밀번호가 일치하지 않습니다.");
			}
		} else {
			if (mcr.getPwd_check().isEmpty()) {
				ValidationUtils.rejectIfEmpty(errors, "pwd_check", "required", "필수 정보입니다.");
			}
		}
	}

}
