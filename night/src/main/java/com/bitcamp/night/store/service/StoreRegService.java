package com.bitcamp.night.store.service;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.store.dao.StoreDao;
import com.bitcamp.night.store.model.Store;

@Service
public class StoreRegService
{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	StoreDao dao;

	public int storeReg(Store store, HttpServletRequest request) throws Exception
	{
		String uploadURI = "/uploadfile/storephoto";
		String dir = request.getSession().getServletContext().getRealPath(uploadURI);
		if (!store.getPhotofile().isEmpty()) {
			// 새로운 파일 이름 생성 -> 파일 저장 -> DB에 저장할 파일이름 set
			String fileName = store.getStore_id() + "_" + store.getPhotofile().getOriginalFilename();
			store.getPhotofile().transferTo(new File(dir, fileName));
			store.setStore_photo(fileName);
		}
		
		dao = sqlSessionTemplate.getMapper(StoreDao.class);
		int resultCnt = dao.insertStore(store);
		return resultCnt;
	}
}