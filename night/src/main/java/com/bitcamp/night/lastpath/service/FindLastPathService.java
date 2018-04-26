package com.bitcamp.night.lastpath.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitcamp.night.lastpath.dao.LastPathDao;
import com.bitcamp.night.lastpath.model.Subway;

@Service("MemberRegisterService")
public class FindLastPathService
{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private LastPathDao dao;

	@Transactional
	public List<Subway> getSubwayList()
	{
		dao = sqlSessionTemplate.getMapper(LastPathDao.class);
		List<Subway> list = dao.selectSubwayList();

		List<Subway> result = new ArrayList<Subway>();
		for (Subway sub : list) {
			sub.setStation_nm(sub.getStation_nm().replaceAll("\\((.*?)\\)", "") + convertLineNum(sub.getLine_num()));
			result.add(sub);
		}

		return result;
	}

	private String convertLineNum(String line_num)
	{
		String res = "";
		if (line_num.equals("SU")) { // SU, UI, KK, I2
			res = "수인선";
		}
		else if (line_num.equals("UI")) {
			res = "우이신설경전철";
		}
		else if (line_num.equals("KK")) {
			res = "경강선";
		}
		else if (line_num.equals("I2")) {
			res = "인천 2호선";
		}
		else {
			char num = line_num.charAt(0);
			switch (num) {
				case 'A':
					res = "공항철도";
					break;
				case 'B':
					res = "분당선";
					break;
				case 'E':
					res = "용인경전철";
					break;
				case 'G':
					res = "경춘선";
					break;
				case 'I':
					res = "인천1호선";
					break;
				case 'K':
					res = "경의중앙선";
					break;
				case 'S':
					res = "신분당선";
					break;
				case 'U':
					res = "의정부경전철";
					break;
				default:
					res = num + "호선";
					break;
			}
		}
		
		return " (" + res + ")";
	}
}
