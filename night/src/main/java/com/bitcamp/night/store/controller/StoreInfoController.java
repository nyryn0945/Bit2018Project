package com.bitcamp.night.store.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bitcamp.night.store.model.Store;
import com.bitcamp.night.store.service.StoreListService;

@Controller
public class StoreInfoController
{
	@Autowired
	private StoreListService storeListService;

	@RequestMapping(value = "/store/storeInfo")
	public String viewMap(Store store, Model model)
	{
		Store result = new Store();
		result = storeListService.selectByIdView(store);
		result.setStore_content(result.getStore_content().replace("\n", "<br />"));
		model.addAttribute("store", result);
		return "/pages/store/storeInfo";
	}
}