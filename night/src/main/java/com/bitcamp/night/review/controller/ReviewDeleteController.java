package com.bitcamp.night.review.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.night.member.model.Member;
import com.bitcamp.night.review.model.Review;
import com.bitcamp.night.review.service.ReviewDeleteService;

@Controller
@RequestMapping(value = "/store/reviewDelete/{review_id}")
public class ReviewDeleteController
{
	@Autowired
	private ReviewDeleteService reviewDeleteService;

	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String delete(@PathVariable("review_id") int review_id, HttpServletRequest request)
	{
		JSONObject obj = new JSONObject();
		
		// 회원만 삭제 가능
		HttpSession session = request.getSession();
		Member mem = (Member) session.getAttribute("MEMBER");
		if (mem == null) {
			obj.put("success", false);
			obj.put("msg", "회원만 삭제할 수 있습니다.");
			return obj.toString();
		}
		
		Review review = reviewDeleteService.selectById(review_id);
		if (review.getMb_id() != mem.getId()) { // 작성자가 아니면 삭제할 수 없음
			obj.put("success", false);
			obj.put("msg", "작성자만 삭제할 수 있습니다.");
			return obj.toString();
		}
		
		reviewDeleteService.deleteById(review_id);
		obj.put("success", true);
		return obj.toString();
	}
}
