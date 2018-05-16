package com.bitcamp.night.member.dao;

import com.bitcamp.night.member.model.Member;

public interface MemberDao
{
	public Member selectByUsername(String username);
	public void insertMember(final Member member);
}
