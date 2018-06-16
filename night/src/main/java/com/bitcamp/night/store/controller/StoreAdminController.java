package com.bitcamp.night.store.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/store/admin")
public class StoreAdminController
{
	@RequestMapping(method = RequestMethod.GET)
	public String admin()
	{
		return "/pages/store/storeAdmin";
	}
}
