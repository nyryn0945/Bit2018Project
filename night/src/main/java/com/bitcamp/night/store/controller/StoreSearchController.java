package com.bitcamp.night.store.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.night.store.model.Store;
import com.bitcamp.night.store.service.StoreSearchService;

@Controller
public class StoreSearchController
{
	@Autowired
	private StoreSearchService storeSearchService;

	@RequestMapping(value = "/store/storeSearchList", method = RequestMethod.GET)
	public String storeSearchList()
	{
		return "/pages/store/storeSearchList";
	}

	@ResponseBody
	@RequestMapping(value = "/store/searchStore", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String post(Model model, HttpServletRequest request, @RequestParam(value="searchStore") String searchStore, 
			@RequestParam(value="startNum") String startNum)
	{	
		model.addAttribute("startNum",startNum);
		
		return getJSON(searchStore, startNum);
	}

	private String getJSON(String searchStore, String startNum)
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy년 MM월 dd일"); 


		if (searchStore == null) {
			return "";
		}
		
		List<Store> storeList = storeSearchService.search(searchStore, startNum);
		JSONArray arr = new JSONArray();
		
		for (Store store : storeList) {
			JSONObject obj = new JSONObject();
			
			String stdate =	df.format(store.getStore_date());

			obj.put("store_id", store.getStore_id());
			obj.put("cate_name", store.getCate_name());
			obj.put("store_name", store.getStore_name());
			obj.put("store_roadaddr", store.getStore_roadaddr());
			obj.put("store_jibunaddr", store.getStore_jibunaddr());
			obj.put("store_loc", store.getStore_loc());
			obj.put("store_starttime", store.getStore_starttime());
			obj.put("store_endtime", store.getStore_endtime());
			obj.put("store_pnum1", store.getStore_pnum1());
			obj.put("store_pnum2", store.getStore_pnum2());
			obj.put("store_pnum3", store.getStore_pnum3());
			obj.put("store_hp", store.getStore_hp());
			obj.put("store_content", store.getStore_content());
			obj.put("store_date", stdate);
			arr.put(obj);
		}	
		
		return arr.toString();
	}
}