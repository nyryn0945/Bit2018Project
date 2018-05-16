package com.bitcamp.night.member.service;

@SuppressWarnings("serial")
public class AlreadyExistingMemberException extends RuntimeException
{
	public AlreadyExistingMemberException(String message)
	{
		super(message);
	}
}