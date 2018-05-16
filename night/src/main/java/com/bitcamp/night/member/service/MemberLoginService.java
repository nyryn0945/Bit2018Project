package com.bitcamp.night.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitcamp.night.member.dao.MemberDao;
import com.bitcamp.night.member.model.Member;

@Service("MemberLoginService")
public class MemberLoginService
{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private MemberDao dao;
	
	@Transactional
	public Member login(Member req)
	{
		dao = sqlSessionTemplate.getMapper(MemberDao.class);
		Member member = dao.selectByUsername(req.getUsername());
		
		if (member == null)
			throw new MemberNotFoundException("아이디가 존재하지 않습니다.");
		
		if (!member.checkPassword(req.getPassword()))
			throw new IdPasswordNotMatchingException("비밀번호가 틀립니다.");
		
		return member;
	}
}
