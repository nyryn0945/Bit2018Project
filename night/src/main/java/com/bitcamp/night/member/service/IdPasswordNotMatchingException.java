package com.bitcamp.night.member.service;

@SuppressWarnings("serial")
public class IdPasswordNotMatchingException extends RuntimeException
{
	public IdPasswordNotMatchingException(String message)
	{
		super(message);
	}
}