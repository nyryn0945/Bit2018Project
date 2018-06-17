package com.bitcamp.night.store.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.store.dao.StoreDao;
import com.bitcamp.night.store.model.Store;

@Service
public class StoreDeleteService
{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private StoreDao dao;

	public Store selectById(int store_id)
	{
		dao = sqlSessionTemplate.getMapper(StoreDao.class);
		Store store = dao.selectById(store_id);
		return store;
	}

	public int deleteById(int store_id)
	{
		dao = sqlSessionTemplate.getMapper(StoreDao.class);
		int StoreRsCnt = dao.storeDelete(store_id);
		if (StoreRsCnt < 0) {
			StoreRsCnt = -1;
		}
		return 1;
	}
}