package com.bitcamp.night.review.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bitcamp.night.review.model.Review;
import com.bitcamp.night.review.service.ReviewListService;
import com.bitcamp.night.review.service.ReviewService;

@Controller
@RequestMapping(value="/review")
public class ReviewController
{
   @Autowired
	private ReviewService reviewService;
   
   @Autowired
	private ReviewListService service;
 
   @RequestMapping(method = RequestMethod.GET)
     public String form(Model model)
     {
	   List<Review> review = service.getReviewList();
		
		model.addAttribute("review",review);
		
		return "pages/review/reviewForm";
  
     }
   
   //리뷰 데이터 등록
   @RequestMapping(method = RequestMethod.POST)
   public String Save(Review review, Model model) throws Exception{
	   
	  //서비스에 review Data 등록
	  Review newReview = reviewService.review(review); 
	   
	  model.addAttribute(newReview);
	  
	  return "redirect:/";
	  
	  
   }
  
   @ExceptionHandler(Exception.class)
   public String exHandler(Exception ex) {
	   ex.printStackTrace();
	   
	   return "redirect:/";
	   
   }
   
   
   
   
}
