package com.bitcamp.night.ajax.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.night.ajax.dao.UserDao;
import com.bitcamp.night.ajax.model.User;

@Service("UserSearchService")
public class UserSearchService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private UserDao dao;
	
	public List<User> search(String userName) {
		
		// UserDao 클래스를 매핑하여 SQL문 사용이 가능해짐
		dao = sqlSessionTemplate.getMapper(UserDao.class);
		
		// 회원을 검색할 거임 아마도
		List<User> userList = dao.searchName(userName);
		
		// selectUser로 인해 userName까지 들어간 user가 반환됨 아마도
		return userList;
	}
	
}
