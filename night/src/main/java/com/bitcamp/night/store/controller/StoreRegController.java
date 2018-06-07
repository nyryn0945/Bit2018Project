package com.bitcamp.night.store.controller;

import java.io.IOException;

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
/*import com.mysql.fabric.xmlrpc.base.Array;*/

@Controller
@RequestMapping("/store/storeReg")
public class StoreRegController {

	@Autowired
	private StoreRegService storeRegService;

	@RequestMapping(method = RequestMethod.GET)
	public String storeRegForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member mem = (Member) session.getAttribute("MEMBER");
		if (mem == null)
			return "redirect:http://localhost/member/login";
		
		return "pages/store/storeRegForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String storeReg(Store store, Model model, HttpServletRequest request) throws IllegalStateException, IOException {

		String msg = "정상적으로 처리되었습니다.";
		System.out.println("입력창 확인 : "+store);
		System.out.println("입력창 확인 : "+store);
		System.out.println("입력창 확인 : "+store);
		
		
		/*store.setPulNumber(store.getStore_pnum1()+"-"+store.getStore_pnum2()+"-"+store.getStore_pnum3());
		String[] msgArr = msg.split(" ");*/
		
		
		HttpSession session = request.getSession();
		Member mem = (Member) session.getAttribute("MEMBER");
		if (mem == null)
			return "redirect:http://localhost/member/login";
		
		int mb_id = mem.getId();
		store.setMb_id(mb_id);
		int resultCnt = storeRegService.storeReg(store, request);

		if (resultCnt == 0)
			msg = "등록 처리가 되지 않았습니다.";

		model.addAttribute("msg", msg);

		return "pages/store/storeReg";
	}
}
