package dev.mvc.member;

public class AlreadyExistingIdException extends RuntimeException{
	public AlreadyExistingIdException(String message) {
		super(message);
	}

}
