package com.bitcamp.night.lastpath.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;

public class ApiFunc
{
	public String urlToString(String apiUrl)
	{
		HttpURLConnection conn = null;
		BufferedReader rd = null;
		StringBuilder sb = null;
		String line = null;
		URL url = null;
		String result = null;

		try {
			url = new URL(apiUrl);

			conn = (HttpURLConnection) url.openConnection();
			conn.setConnectTimeout(10000);
			conn.setReadTimeout(10000);
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			conn.connect();

			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			sb = new StringBuilder();
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			result = sb.toString();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.disconnect();
			rd = null;
			sb = null;
			conn = null;
		}

		return result;
	}

	public Document urlToDocument(String apiUrl)
	{
		HttpURLConnection conn = null;
		URL url = null;
		Document doc = null;

		try {
			url = new URL(apiUrl);

			conn = (HttpURLConnection) url.openConnection();
			conn.setConnectTimeout(10000);
			conn.setReadTimeout(10000);
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			conn.connect();

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			DocumentBuilder db = dbf.newDocumentBuilder();
			doc = db.parse(conn.getInputStream());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.disconnect();
			conn = null;
		}

		return doc;
	}
}
