package com.bitcamp.night.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitcamp.night.member.dao.MemberDao;
import com.bitcamp.night.member.model.Member;

@Service("MemberRegisterService")
public class MemberRegisterService
{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private MemberDao dao;

	@Transactional
	public Member register(Member member)
	{
		dao = sqlSessionTemplate.getMapper(MemberDao.class);
		if (dao.selectByUsername(member.getUsername()) != null) {
			throw new AlreadyExistingMemberException("아이디 중복 : " + member.getUsername());
		}
		
		dao.insertMember(member);
		return member;
	}
}
