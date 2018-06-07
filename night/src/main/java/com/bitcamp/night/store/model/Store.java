package com.bitcamp.night.store.model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Store {

	private int store_id;
	private int cate_id;
	private String store_name;
	private String store_roadaddr;
	private String store_jibunaddr;
	private String store_starttime;
	private String store_loc;
	private String store_endtime;
	private String store_pnum1;
	private String store_pnum2;
	private String store_pnum3;
	private String store_hp;
	private Date store_date;
	private String cate_name;
	private int mb_id;
	private String store_content;
	private String store_photo;
	private MultipartFile photofile;

	public Store(int store_id, int cate_id, String store_name, String store_roadaddr, String store_jibunaddr,
			String store_starttime, String store_loc, String store_endtime, String store_pnum1, String store_pnum2,
			String store_pnum3, String store_hp, Date store_date, String cate_name, int mb_id, String store_content,
			String store_photo, MultipartFile photofile) {
		super();
		this.store_id = store_id;
		this.cate_id = cate_id;
		this.store_name = store_name;
		this.store_roadaddr = store_roadaddr;
		this.store_jibunaddr = store_jibunaddr;
		this.store_starttime = store_starttime;
		this.store_loc = store_loc;
		this.store_endtime = store_endtime;
		this.store_pnum1 = store_pnum1;
		this.store_pnum2 = store_pnum2;
		this.store_pnum3 = store_pnum3;
		this.store_hp = store_hp;
		this.store_date = store_date;
		this.cate_name = cate_name;
		this.mb_id = mb_id;
		this.store_content = store_content;
		this.store_photo = store_photo;
		this.photofile = photofile;
	}

	public Store() {

	}

	public MultipartFile getPhotofile() {
		return photofile;
	}

	public void setPhotofile(MultipartFile photofile) {
		this.photofile = photofile;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public int getCate_id() {
		return cate_id;
	}

	public void setCate_id(int cate_id) {
		this.cate_id = cate_id;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public String getStore_roadaddr() {
		return store_roadaddr;
	}

	public void setStore_roadaddr(String store_roadaddr) {
		this.store_roadaddr = store_roadaddr;
	}

	public String getStore_jibunaddr() {
		return store_jibunaddr;
	}

	public void setStore_jibunaddr(String store_jibunaddr) {
		this.store_jibunaddr = store_jibunaddr;
	}

	public String getStore_starttime() {
		return store_starttime;
	}

	public void setStore_starttime(String store_starttime) {
		this.store_starttime = store_starttime;
	}

	public String getStore_loc() {
		return store_loc;
	}

	public void setStore_loc(String store_loc) {
		this.store_loc = store_loc;
	}

	public String getStore_endtime() {
		return store_endtime;
	}

	public void setStore_endtime(String store_endtime) {
		this.store_endtime = store_endtime;
	}

	public String getStore_pnum1() {
		return store_pnum1;
	}

	public void setStore_pnum1(String store_pnum1) {
		this.store_pnum1 = store_pnum1;
	}

	public String getStore_pnum2() {
		return store_pnum2;
	}

	public void setStore_pnum2(String store_pnum2) {
		this.store_pnum2 = store_pnum2;
	}

	public String getStore_pnum3() {
		return store_pnum3;
	}

	public void setStore_pnum3(String store_pnum3) {
		this.store_pnum3 = store_pnum3;
	}

	public String getStore_hp() {
		return store_hp;
	}

	public void setStore_hp(String store_hp) {
		this.store_hp = store_hp;
	}

	public Date getStore_date() {
		return store_date;
	}

	public void setStore_date(Date store_date) {
		this.store_date = store_date;
	}

	public String getCate_name() {
		return cate_name;
	}

	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}

	public int getMb_id() {
		return mb_id;
	}

	public void setMb_id(int mb_id) {
		this.mb_id = mb_id;
	}

	public String getStore_content() {
		return store_content;
	}

	public void setStore_content(String store_content) {
		this.store_content = store_content;
	}

	public String getStore_photo() {
		return store_photo;
	}

	public void setStore_photo(String store_photo) {
		this.store_photo = store_photo;
	}

	@Override
	public String toString() {
		return "Store [store_id=" + store_id + ", cate_id=" + cate_id + ", store_name=" + store_name
				+ ", store_roadaddr=" + store_roadaddr + ", store_jibunaddr=" + store_jibunaddr + ", store_starttime="
				+ store_starttime + ", store_loc=" + store_loc + ", store_endtime=" + store_endtime + ", store_pnum1="
				+ store_pnum1 + ", store_pnum2=" + store_pnum2 + ", store_pnum3=" + store_pnum3 + ", store_hp="
				+ store_hp + ", store_date=" + store_date + ", cate_name=" + cate_name + ", mb_id=" + mb_id
				+ ", store_content=" + store_content + ", store_photo=" + store_photo + ", photofile=" + photofile
				+ "]";
	}

}
