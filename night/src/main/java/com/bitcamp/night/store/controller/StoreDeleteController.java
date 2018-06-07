package com.bitcamp.night.store.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitcamp.night.store.service.StoreDeleteService;

@Controller
public class StoreDeleteController {

	@Autowired
	private StoreDeleteService storeDeleteService;

	@RequestMapping("/store/storeDelete")
	public String StoreDelete(@RequestParam(value = "store_id") int store_id) {

		int StoreRsCnt = storeDeleteService.StoreDelete(store_id);
		System.out.println(StoreRsCnt);
		String page = "redirect:/store/storeInfo?store_id="+store_id;

		if (StoreRsCnt > 0) {
			page = "redirect:/store/storeSearchList";
		}
		return page;
	}

}