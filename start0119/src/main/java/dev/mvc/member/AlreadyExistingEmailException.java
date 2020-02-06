package dev.mvc.member;

public class AlreadyExistingEmailException extends RuntimeException{
	public AlreadyExistingEmailException(String message) {
		super(message);
	}

}
