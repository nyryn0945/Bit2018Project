package com.bitcamp.night.store.service;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.store.dao.StoreDao;
import com.bitcamp.night.store.model.Store;

@Service
public class StoreUpdateService
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

	public int storeUpdate(Store store, HttpServletRequest request) throws Exception
	{
		int resultCnt = 0;
		dao = sqlSessionTemplate.getMapper(StoreDao.class);
		
		String uploadURI = "/uploadfile/storephoto";
		String dir = request.getSession().getServletContext().getRealPath(uploadURI);
		if (!store.getPhotofile().isEmpty()) {
			String fileName = store.getStore_id() + "_" + store.getPhotofile().getOriginalFilename();
			store.getPhotofile().transferTo(new File(dir, fileName));
			store.setStore_photo(fileName);
			resultCnt = dao.storeUpdate(store);
		}
		else {
			resultCnt = dao.storeUpdateNoPhoto(store);	
		}

		return resultCnt;
	}
}
