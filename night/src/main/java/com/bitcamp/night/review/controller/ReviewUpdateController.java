package com.bitcamp.night.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitcamp.night.review.model.Review;
import com.bitcamp.night.review.service.ReviewUpdateService;

@Controller
@RequestMapping(value="/reviewUpdate")
public class ReviewUpdateController {
	
	@Autowired
	private ReviewUpdateService reviewUpdateService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String Update(@RequestParam(value="MB_ID") String id, Model model) {
		
		Review review = reviewUpdateService.selectById(id);
		
		model.addAttribute("review", review);
		
		return "pages/review/reviewUpdate";
		
	}
	@RequestMapping(method=RequestMethod.POST) 
	public String reviewUpdate(Review review, Model model) throws Exception{
		
		Review updateReview = reviewUpdateService.review(review);
		
		model.addAttribute(updateReview);
		
		return "redirect:/";
		
	}
	 @ExceptionHandler(Exception.class)
	   public String exHandler(Exception ex) {
		   ex.printStackTrace();
		   
		   return "redirect:/";
		   
	   }
	   

	

	
}
