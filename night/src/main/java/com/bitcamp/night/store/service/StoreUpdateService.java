package com.bitcamp.night.store.service;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.store.dao.StoreDao;
import com.bitcamp.night.store.model.Store;

@Service
public class StoreUpdateService {

   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;
   
   private StoreDao dao;

   public Store selectById(int store_id) {
      
      dao = sqlSessionTemplate.getMapper(StoreDao.class);
      
      Store store = dao.selectById(store_id);
      
      System.out.println(store_id);
      
      //return dao.selectById(store_id);
      return store;
   }

   public int storeUpdate(Store store, HttpServletRequest request) {

      dao = sqlSessionTemplate.getMapper(StoreDao.class);
      
      // dao 요청 : 데이터 저장 요청
      int resultCnt = dao.storeUpdate(store);
      
      return resultCnt;
   }
}