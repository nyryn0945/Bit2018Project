package com.bitcamp.night.review.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.night.member.model.Member;
import com.bitcamp.night.review.model.Review;
import com.bitcamp.night.review.service.ReviewRegService;

@Controller
@RequestMapping(value = "/store/review")
public class ReviewRegController
{
	@Autowired
	private ReviewRegService reviewRegService;

	// 리뷰 데이터 등록
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String Save(Review review, Model model, HttpServletRequest request) throws Exception
	{
		// 회원만 등록 가능
		HttpSession session = request.getSession();
		Member mem = (Member) session.getAttribute("MEMBER");
		if (mem == null)
			return "";

		review.setMb_id(mem.getId());
		Review newReview = reviewRegService.insertReview(review);
		
		return getJSON(newReview, mem.getUsername());
	}

	private String getJSON(Review review, String mb_username)
	{
		if (review == null) {
			return "";
		}

		JSONObject obj = new JSONObject();
		obj.put("review_id", review.getReview_id());
		obj.put("mb_id", review.getMb_id());
		obj.put("mb_username", mb_username);
		obj.put("store_id", review.getStore_id());
		obj.put("review_content", review.getReview_content());
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm");
		Date date = new Date();
		obj.put("review_date", dateFormat.format(date));
		
		return obj.toString();
	}

	// @ExceptionHandler(Exception.class)
	// public String exHandler(Exception ex)
	// {
	// ex.printStackTrace();
	// return "redirect:/";
	// }
}
