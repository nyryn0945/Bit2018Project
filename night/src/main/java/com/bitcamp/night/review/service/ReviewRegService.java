package com.bitcamp.night.review.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.review.dao.ReviewDao;
import com.bitcamp.night.review.model.Review;

@Service("ReviewRegService")
public class ReviewRegService
{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private ReviewDao dao;

	public Review insertReview(Review review)
	{
		dao = sqlSessionTemplate.getMapper(ReviewDao.class);
		dao.insertReview(review);
		return review;
	}

}
