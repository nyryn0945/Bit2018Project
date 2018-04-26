package com.bitcamp.night.lastpath.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.night.lastpath.model.Subway;
import com.bitcamp.night.lastpath.service.FindLastPathService;
import com.bitcamp.night.lastpath.util.ApiFunc;

@Controller
public class FindLastPathController
{
	@Autowired
	private FindLastPathService findLastPathService;

	@RequestMapping(value = "/lastpath", method = RequestMethod.GET)
	public String form()
	{
		// List<Subway> list = findLastPathService.getSubwayList();
		// model.addAttribute("subwayList", list);
		return "pages/lastpath/lastPathForm";
	}

	@RequestMapping(value = "/lastpath", method = RequestMethod.POST)
	public String submit(HttpServletRequest request) throws Exception
	{
		// JSONObject jsonObj = new JSONObject(new
		// ApiFunc().urlToString("http://localhost:3000/apitest"));
		// System.out.println(jsonObj.toString());
		System.out.println(request.getParameter("statnFnm"));
		System.out.println(request.getParameter("statnTnm"));
		return "pages/lastpath/lastPathForm";
	}

	@ResponseBody
	@RequestMapping(value = "/api/subway/getSubwayList", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getSubwayList(HttpServletRequest request)
	{
		List<Subway> list = findLastPathService.getSubwayList();
		JSONArray arr = new JSONArray();
		for (Subway s : list) {
			JSONObject obj = new JSONObject();
			obj.put("id", s.getSubway_id());
			obj.put("text", s.getStation_nm());
			arr.put(obj);
		}
		return arr.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/api/bus/getBusRouteList", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getBusRouteList(HttpServletRequest request)
	{
		String strSrch = request.getParameter("term");
		// String str = new ApiFunc().urlToString("http://localhost:3000/api/bus/getBusRouteList/" + strSrch);
		String str = new ApiFunc().urlToString("http://localhost:3000/api/bus/test");
		return str;
	}

	@ResponseBody
	@RequestMapping(value = "/api/bus/getStaionByRoute", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getStaionByRoute(HttpServletRequest request)
	{
		String busRouteId = request.getParameter("busRouteId");
		// String str = new ApiFunc().urlToString("http://localhost:3000/api/bus/getStaionByRoute/" + busRouteId);
		String str = new ApiFunc().urlToString("http://localhost:3000/api/bus/test2");
		return str;
	}
}
