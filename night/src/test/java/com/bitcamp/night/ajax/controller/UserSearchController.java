package com.bitcamp.night.ajax.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.night.ajax.model.User;
import com.bitcamp.night.ajax.service.UserSearchService;

@Controller
public class UserSearchController {

	@Autowired
	private UserSearchService userSearchService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		// /WEB-INF/views/index.jsp를 포워드합니다.
		model.addAttribute("serverTime", "123123");
		return "home";
	}

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() {
		return "index";
	}

	@ResponseBody
	@RequestMapping(value = "/UserSearchServlet", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String post(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		String userName = request.getParameter("userName");
		return getJSON(userName);
	}

	private String getJSON(String userName) {
		if (userName == null)
			userName = "";

		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");

		List<User> userList = userSearchService.search(userName);
		for (int i = 0; i < userList.size(); i++) {
			result.append("[{\"value\": \"" + userList.get(i).getUserName() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserAge() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserGender() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserEmail() + "\"}],");
		}

		result.append("]}");
		return result.toString();

	}

}
