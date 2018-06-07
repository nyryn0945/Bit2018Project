package com.bitcamp.night.store.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitcamp.night.store.model.Store;
import com.bitcamp.night.store.service.StoreListService;

@Controller
public class StoreInfoController {

	@Autowired
	private StoreListService storeListService;
	
	@RequestMapping(value="/store/storeInfo")
	public String viewMap(Store store,	Model model, @RequestParam(value="addressName") String addressName) {
		Store resultstore = new Store();
		resultstore = storeListService.selectByIdView(store);		
		model.addAttribute("resultstore", resultstore);
		
		model.addAttribute("addressName", addressName);
		
		System.out.println(addressName +',' + store);
		System.out.println("rararara : "+store);
		return "/pages/store/storeInfo";
	}
	
	


	

}