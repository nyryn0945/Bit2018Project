package com.bitcamp.night.review.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.review.dao.ReviewDao;
import com.bitcamp.night.review.model.ReviewExtend;

@Service("ReviewListService")
public class ReviewListService
{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private ReviewDao dao;

	public List<ReviewExtend> selectListByStordId(int store_id)
	{
		dao = sqlSessionTemplate.getMapper(ReviewDao.class);
		List<ReviewExtend> list = dao.selectList(store_id);
		return list;
	}

}
