package com.bitcamp.night.review.model;

import java.util.Date;

public class Review
{
	private int review_id;
	private int mb_id;
	private int store_id;
	private String review_content;
	private Date review_date;

	public Review()
	{

	}

	public Review(int review_id, int mb_id, int store_id, String review_content, Date review_date)
	{
		this.review_id = review_id;
		this.mb_id = mb_id;
		this.store_id = store_id;
		this.review_content = review_content;
		this.review_date = review_date;
	}

	public int getReview_id()
	{
		return review_id;
	}

	public void setReview_id(int review_id)
	{
		this.review_id = review_id;
	}

	public int getMb_id()
	{
		return mb_id;
	}

	public void setMb_id(int mb_id)
	{
		this.mb_id = mb_id;
	}

	public int getStore_id()
	{
		return store_id;
	}

	public void setStore_id(int store_id)
	{
		this.store_id = store_id;
	}

	public String getReview_content()
	{
		return review_content;
	}

	public void setReview_content(String review_content)
	{
		this.review_content = review_content;
	}

	public Date getReview_date()
	{
		return review_date;
	}

	public void setReview_date(Date review_date)
	{
		this.review_date = review_date;
	}

	@Override
	public String toString()
	{
		return "Review [review_id=" + review_id + ", mb_id=" + mb_id + ", store_id=" + store_id + ", review_content="
				+ review_content + ", review_date=" + review_date + "]";
	}
}
