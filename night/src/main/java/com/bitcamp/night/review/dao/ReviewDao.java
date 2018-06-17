package com.bitcamp.night.review.dao;

import java.util.List;

import com.bitcamp.night.review.model.Review;
import com.bitcamp.night.review.model.ReviewExtend;

public interface ReviewDao
{
	public void insertReview(final Review review);
	public List<ReviewExtend> selectList(int store_id);
	public Review selectById(int review_id);
	public void deleteReview(int review_id);
}
