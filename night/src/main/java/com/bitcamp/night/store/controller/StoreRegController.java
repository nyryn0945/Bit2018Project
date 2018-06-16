package com.bitcamp.night.store.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bitcamp.night.member.model.Member;
import com.bitcamp.night.store.model.Store;
import com.bitcamp.night.store.service.StoreRegService;

@Controller
@RequestMapping("/store/storeReg")
public class StoreRegController
{
	@Autowired
	private StoreRegService storeRegService;

	@RequestMapping(method = RequestMethod.GET)
	public String storeRegForm(Model model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		Member mem = (Member) session.getAttribute("MEMBER");
		if (mem == null)
			return "redirect:http://localhost/member/login";

		model.addAttribute("store", null);
		return "pages/store/storeRegForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String storeReg(Store store, Model model, HttpServletRequest request) throws Exception
	{
		HttpSession session = request.getSession();
		Member mem = (Member) session.getAttribute("MEMBER");
		if (mem == null)
			return "redirect:http://localhost/member/login";

		store.setMb_id(mem.getId());
		storeRegService.storeReg(store, request);

		return "redirect:/store/storeInfo?store_id=" + store.getStore_id();
	}
}
