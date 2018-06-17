package com.bitcamp.night.store.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.store.dao.StoreDao;
import com.bitcamp.night.store.model.Store;

@Service("StoreListService")
public class StoreListService
{

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private StoreDao dao;

	public List<Store> StoreListAll()
	{
		dao = sqlSessionTemplate.getMapper(StoreDao.class);
		return dao.selectList();
	}

	public int count()
	{
		dao = sqlSessionTemplate.getMapper(StoreDao.class);
		return dao.selectCount();
	}

	public Store selectByIdView(Store store)
	{
		dao = sqlSessionTemplate.getMapper(StoreDao.class);
		Store storeresult = new Store();
		if (store != null) {
			storeresult = dao.selectById(store);
		}
		else {
			storeresult = null;
		}
		return storeresult;
	}

	public String AddressList(String address)
	{
		dao = sqlSessionTemplate.getMapper(StoreDao.class);
		return dao.addressName(address);
	}

	/*
	 * public List<Store> search(String searchStore) { dao =
	 * sqlSessionTemplate.getMapper(StoreDao.class);
	 * 
	 * List<Store> storeSearchList = dao.searchList(searchStore);
	 * 
	 * return storeSearchList;
	 * 
	 * 
	 * }
	 */

	// name 검색으로 검색되게 나중에 메서드만들어서 작성하기..

}
