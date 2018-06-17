package com.bitcamp.night.review.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.review.dao.ReviewDao;
import com.bitcamp.night.review.model.Review;

@Service("ReviewDeleteService")
public class ReviewDeleteService
{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private ReviewDao dao;

	public Review selectById(int review_id)
	{
		dao = sqlSessionTemplate.getMapper(ReviewDao.class);
		Review review = dao.selectById(review_id);
		return review;
	}

	public void deleteById(int review_id)
	{
		dao = sqlSessionTemplate.getMapper(ReviewDao.class);
		dao.deleteReview(review_id);
	}
}
