package com.bitcamp.night.store.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StoreMainController
{
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main()
	{			
		return "/pages/store/storeMain";
	}
}