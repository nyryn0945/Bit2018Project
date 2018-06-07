package com.bitcamp.night.store.service;

@SuppressWarnings("serial")
public class StoreNotFoundException extends RuntimeException
{
	public StoreNotFoundException(String message)
	{
		super(message);
	}
}