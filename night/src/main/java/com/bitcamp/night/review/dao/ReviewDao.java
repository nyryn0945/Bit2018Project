package com.bitcamp.night.review.dao;

import java.util.List;

import com.bitcamp.night.review.model.Review;

public interface ReviewDao {

	public int insertReview(Review review);

	public List<Review> selectList();

}
