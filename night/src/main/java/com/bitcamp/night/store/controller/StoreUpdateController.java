package com.bitcamp.night.store.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitcamp.night.member.model.Member;
import com.bitcamp.night.store.model.Store;
import com.bitcamp.night.store.service.StoreUpdateService;

@Controller
@RequestMapping("/store/storeUpdate")
public class StoreUpdateController
{
	@Autowired
	private StoreUpdateService storeUpdateService;

	@RequestMapping(method = RequestMethod.GET)
	public String storeUpdate(@RequestParam(value = "store_id") int store_id, Model model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		Member mem = (Member) session.getAttribute("MEMBER");
		if (mem == null)
			return "redirect:http://localhost/member/login";
		
		Store storeForCheck = storeUpdateService.selectById(store_id);
		if (storeForCheck.getMb_id() != mem.getId()) // 작성자가 아니면 수정할 수 없음
			return "redirect:/store/storeInfo?store_id=" + store_id;
		
		Store store = storeUpdateService.selectById(store_id);
		model.addAttribute("store", store);
		return "pages/store/storeRegForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String storeUpdate(Store store, Model model, HttpServletRequest request) throws Exception
	{
		// 회원만 삭제 가능
		HttpSession session = request.getSession();
		Member mem = (Member) session.getAttribute("MEMBER");
		if (mem == null)
			return "redirect:http://localhost/member/login";
		
		Store storeForCheck = storeUpdateService.selectById(store.getStore_id());
		if (storeForCheck.getMb_id() != mem.getId()) // 작성자가 아니면 수정할 수 없음
			return "redirect:/store/storeInfo?store_id=" + store.getStore_id();

		storeUpdateService.storeUpdate(store, request);
		return "redirect:/store/storeInfo?store_id=" + store.getStore_id();
	}
	
	/*
	 * @ExceptionHandler(IOException.class) public String ex1(IOException e) {
	 * return "error/ex1"; }
	 * 
	 * @ExceptionHandler(IllegalStateException.class) public String
	 * ex2(IllegalStateException e) { return "error/ex2"; }
	 */
}