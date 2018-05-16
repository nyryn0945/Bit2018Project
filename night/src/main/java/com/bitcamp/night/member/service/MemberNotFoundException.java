package com.bitcamp.night.member.service;

@SuppressWarnings("serial")
public class MemberNotFoundException extends RuntimeException
{
	public MemberNotFoundException(String message)
	{
		super(message);
	}
}