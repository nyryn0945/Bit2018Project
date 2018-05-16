package com.bitcamp.night.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import com.bitcamp.night.member.model.Member;
import com.bitcamp.night.member.service.MemberRegisterService;
import com.bitcamp.night.member.service.SimpleRegistrationNotifier;

@Controller
@RequestMapping(value = "/member/register")
public class MemberRegisterController
{
	@Autowired
	private MemberRegisterService memberRegisterService;

	@Autowired
	private SimpleRegistrationNotifier mailer;

	@RequestMapping(method = RequestMethod.GET)
	public String form(HttpServletRequest request)
	{
		return "pages/member/memberRegForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String submit(Member member) throws Exception
	{
		// 회원가입 서비스
		Member newMember = memberRegisterService.register(member);

		// 가입 축하 메일 전송
		mailer.sendMail(newMember);

		// 홈으로 이동
		return "redirect:/member/login";
	}

	@ExceptionHandler(Exception.class)
	public RedirectView exhandler(Exception ex, HttpServletRequest request)
	{
		RedirectView redirectView = new RedirectView(request.getHeader("referer"));
		FlashMap outputFlashMap = RequestContextUtils.getOutputFlashMap(request);
		if (outputFlashMap != null){
	        outputFlashMap.put("ERROR_MSG", ex.getMessage());
	    }
	    return redirectView;
	}
}
