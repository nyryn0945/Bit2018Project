package com.bitcamp.night.store.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.store.dao.StoreDao;
import com.bitcamp.night.store.model.Store;



@Service("StoreSearchService")
public class StoreSearchService {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private StoreDao dao;
	
	public List<Store> search(String searchStore, String startNum)
	{
		
		dao = sqlSessionTemplate.getMapper(StoreDao.class);
		List<Store> storeList = dao.searchList(searchStore, Integer.parseInt(startNum));
		
		return storeList;
	}
}
