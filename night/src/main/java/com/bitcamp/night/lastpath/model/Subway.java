package com.bitcamp.night.lastpath.model;

public class Subway
{
	private int subway_id;
	private String station_cd;
	private String station_nm;
	private String line_num;
	private String fr_code;
	private double lat;
	private double lng;

	public Subway()
	{

	}

	public Subway(int subway_id, String station_cd, String station_nm, String line_num, String fr_code, double lat,
			double lng)
	{
		this.subway_id = subway_id;
		this.station_cd = station_cd;
		this.station_nm = station_nm;
		this.line_num = line_num;
		this.fr_code = fr_code;
		this.lat = lat;
		this.lng = lng;
	}

	public int getSubway_id()
	{
		return subway_id;
	}

	public void setSubway_id(int subway_id)
	{
		this.subway_id = subway_id;
	}

	public String getStation_cd()
	{
		return station_cd;
	}

	public void setStation_cd(String station_cd)
	{
		this.station_cd = station_cd;
	}

	public String getStation_nm()
	{
		return station_nm;
	}

	public void setStation_nm(String station_nm)
	{
		this.station_nm = station_nm;
	}

	public String getLine_num()
	{
		return line_num;
	}

	public void setLine_num(String line_num)
	{
		this.line_num = line_num;
	}

	public String getFr_code()
	{
		return fr_code;
	}

	public void setFr_code(String fr_code)
	{
		this.fr_code = fr_code;
	}

	public double getLat()
	{
		return lat;
	}

	public void setLat(double lat)
	{
		this.lat = lat;
	}

	public double getLng()
	{
		return lng;
	}

	public void setLng(double lng)
	{
		this.lng = lng;
	}

}
