package com.bitcamp.night.review.model;

import java.util.Date;

public class ReviewExtend extends Review
{
	private String mb_username;

	public ReviewExtend()
	{

	}

	public ReviewExtend(int review_id, int mb_id, int store_id, String review_content, Date review_date,
			String mb_username)
	{
		super(review_id, mb_id, store_id, review_content, review_date);
		this.mb_username = mb_username;
	}

	public String getMb_username()
	{
		return mb_username;
	}

	public void setMb_username(String mb_username)
	{
		this.mb_username = mb_username;
	}
}
