package com.bitcamp.night.review.model;

import java.util.Date;

public class Review
{
	private int REVIEW_ID;
	private int MB_ID;
	private int STORE_ID;
	private String REVIEW_CONTENT;
	private Date REVIEW_DATE;

	public int getREVIEW_ID()
	{
		return REVIEW_ID;
	}

	public void setREVIEW_ID(int REVIEW_ID)
	{
		this.REVIEW_ID = REVIEW_ID;
	}

	public int getMB_ID()
	{
		return MB_ID;
	}

	public void setMB_ID(int MB_ID)
	{
		this.MB_ID = MB_ID;
	}

	public int getSTORE_ID()
	{
		return STORE_ID;
	}

	public void setSTORE_ID(int STORE_ID)
	{
		this.STORE_ID = STORE_ID;
	}

	public String getREVIEW_CONTENT()
	{
		return REVIEW_CONTENT;
	}

	public void setREVIEW_CONTENT(String REVIEW_CONTENT)
	{
		this.REVIEW_CONTENT = REVIEW_CONTENT;
	}

	public Date getREVIEW_DATE()
	{
		return REVIEW_DATE;
	}

	public void setREVIEW_DATE(Date REVIEW_DATE)
	{
		this.REVIEW_DATE = REVIEW_DATE;
	}

	@Override
	public String toString()
	{
		// TODO Auto-generated method stub
		return "리뷰 데이터 정보 [ID = " + REVIEW_ID + ", MB_ID = " + MB_ID + ", STORE_ID = " + STORE_ID
				+ ", REVIEW_CONTENT = " + REVIEW_CONTENT + ", REVIEW_DATE = " + REVIEW_DATE + "]";
	}

}
