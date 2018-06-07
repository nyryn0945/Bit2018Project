package com.bitcamp.night.store.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.store.dao.StoreDao;

@Service
public class StoreDeleteService {

	@Autowired
	private SqlSessionTemplate sqlsessionTemplate;
	
	private StoreDao dao;
	
	public int StoreDelete(int store_id) {
		
		dao = sqlsessionTemplate.getMapper(StoreDao.class);
		
		int StoreRsCnt = dao.storeDelete(store_id);
		
		if(StoreRsCnt < 0) {
			StoreRsCnt = -1;
		}
		
		return 1;
	}
}