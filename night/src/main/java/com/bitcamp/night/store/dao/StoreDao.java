package com.bitcamp.night.store.dao;

import java.util.List;

import com.bitcamp.night.store.model.Store;

public interface StoreDao
{
	public Store selectById(Store resultstore);
	public int insertStore(final Store Store);
	public List<Store> selectList();
	public int selectCount();
	public List<Store> searchList(String searchStore, int startNum);
	public String addressName(String address);
	public Store selectById(int store_id);
	public int storeUpdate(Store store);
	public int storeUpdateNoPhoto(Store store);
	public int storeDelete(int store_id);
}