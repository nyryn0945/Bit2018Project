package com.bitcamp.night.store.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/store/main")
public class StoreMainPageController {

	@RequestMapping(method = RequestMethod.GET)
	public String form() {
		
		return "/pages/store/storeForm";
	}
}
