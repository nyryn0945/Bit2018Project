package com.bitcamp.night.ajax.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AjaxController {

	@RequestMapping(value = "/ajax", method = RequestMethod.GET)
	public String form() {
		return "pages/ajax/ajaxForm";
	}

}
