package com.bitcamp.night.ajax.dao;

import java.util.List;

import com.bitcamp.night.ajax.model.User;

public interface UserDao {

	public List<User> searchName(String userName);

}
