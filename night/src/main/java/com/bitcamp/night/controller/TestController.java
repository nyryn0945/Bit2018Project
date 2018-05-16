package com.bitcamp.night.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestController
{
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Model model, HttpServletRequest req)
	{
//		Enumeration<String> headerNames = req.getHeaderNames();
//		while (headerNames.hasMoreElements()) {
//			String headerName = headerNames.nextElement();
//			System.out.print(headerName + ": ");
//			String headerValue = req.getHeader(headerName);
//			System.out.println(headerValue);
//		}
		
		String login = "로그아웃 된 상태";
		HttpSession session = req.getSession();
		if (session != null && (String) session.getAttribute("USER") != null)
			login = "로그인 된 상태";
		
		model.addAttribute("SESSION", session.getId());
		model.addAttribute("USER", login);
		return "home";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpServletRequest req)
	{
		HttpSession session = req.getSession();
		session.setAttribute("USER", "fpdkfdldi");
		return "redirect:/test";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest req)
	{
		HttpSession session = req.getSession();
		if (session != null) {
			session.removeAttribute("USER");
		}
		return "redirect:/test";
	}
}
