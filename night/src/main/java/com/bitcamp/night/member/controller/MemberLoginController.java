package com.bitcamp.night.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import com.bitcamp.night.member.model.Member;
import com.bitcamp.night.member.service.MemberLoginService;

@Controller
@RequestMapping(value = "/member/login")
public class MemberLoginController
{
	@Autowired
	private MemberLoginService memberLoginService;

	@RequestMapping(method = RequestMethod.GET)
	public String form()
	{
		return "pages/member/loginForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String login(Member reqMember, HttpServletRequest request) throws Exception
	{
		Member member = memberLoginService.login(reqMember);
		HttpSession session = request.getSession();
		session.setAttribute("MEMBER", member);
		return "redirect:http://localhost/lastpath";
	}

	@ExceptionHandler(Exception.class)
	public RedirectView exhandler(Exception ex, HttpServletRequest request)
	{
		RedirectView redirectView = new RedirectView(request.getHeader("referer"));
		FlashMap outputFlashMap = RequestContextUtils.getOutputFlashMap(request);
		if (outputFlashMap != null) {
			outputFlashMap.put("ERROR_MSG", ex.getMessage());
		}
		return redirectView;
	}
}
