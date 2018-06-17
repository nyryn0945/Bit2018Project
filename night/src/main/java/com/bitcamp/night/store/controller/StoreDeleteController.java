package com.bitcamp.night.store.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitcamp.night.member.model.Member;
import com.bitcamp.night.store.model.Store;
import com.bitcamp.night.store.service.StoreDeleteService;

@Controller
@RequestMapping("/store/storeDelete")
public class StoreDeleteController
{
	@Autowired
	private StoreDeleteService storeDeleteService;

	@RequestMapping(method = RequestMethod.GET)
	public String StoreDelete(@RequestParam(value = "store_id") int store_id, HttpServletRequest request)
	{
		// 회원만 삭제 가능
		HttpSession session = request.getSession();
		Member mem = (Member) session.getAttribute("MEMBER");
		if (mem == null)
			return "redirect:http://localhost/member/login";
		
		Store storeForCheck = storeDeleteService.selectById(store_id);
		if (storeForCheck.getMb_id() != mem.getId()) // 작성자가 아니면 삭제할 수 없음
			return "redirect:/store/storeInfo?store_id=" + store_id;
		
		int StoreRsCnt = storeDeleteService.deleteById(store_id);
		return StoreRsCnt > 0 ? "redirect:/" : "redirect:/store/storeInfo?store_id=" + store_id;
	}

}