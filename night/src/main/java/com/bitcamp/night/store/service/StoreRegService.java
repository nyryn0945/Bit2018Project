package com.bitcamp.night.store.service;


import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.store.dao.StoreDao;
import com.bitcamp.night.store.model.Store;

@Service
public class StoreRegService {

	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	StoreDao dao;
	
	public int storeReg(Store store, HttpServletRequest request) {
		int resultCnt = 0;
		if (store != null) {

			dao = sqlSessionTemplate.getMapper(StoreDao.class);
			resultCnt = dao.insertStore(store);

		}

		return resultCnt;
	}
	
}
