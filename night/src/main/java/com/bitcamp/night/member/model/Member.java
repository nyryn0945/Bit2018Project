package com.bitcamp.night.member.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

public class Member
{
	private int id;
	private String username;
	private String password;
	private String nickname;
	private String email;
	private String pnum;
	private String address;
	private int gender;
	private Date date;

	public Member()
	{
		
	}
	
	public Member(int id, String username, String password, String nickname, String email, String pnum, String address, int gender, Date date)
	{
		this.id = id;
		this.username = username;
		this.password = password;
		this.nickname = nickname;
		this.email = email;
		this.pnum = pnum;
		this.address = address;
		this.gender = gender;
		this.date = date;
	}

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	@JsonIgnore
	public String getPassword()
	{
		return password;
	}

	@JsonProperty
	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getNickname()
	{
		return nickname;
	}

	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getPnum()
	{
		return pnum;
	}

	public void setPnum(String pnum)
	{
		this.pnum = pnum;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public int getGender()
	{
		return gender;
	}

	public void setGender(int gender)
	{
		this.gender = gender;
	}

	@JsonIgnore
	public Date getDate()
	{
		return date;
	}

	@JsonProperty
	public void setDate(Date date)
	{
		this.date = date;
	}
	
	public boolean checkPassword(String reqPassword)
	{
		return password.equals(reqPassword);
	}

	@Override
	public String toString()
	{
		return "Member [id=" + id + ", username=" + username + ", password=" + password + ", nickname=" + nickname
				+ ", email=" + email + ", pnum=" + pnum + ", address=" + address + ", gender=" + gender + ", date="
				+ date + "]";
	}
}
