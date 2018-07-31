package com.cdxt.face.servlet;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;

public class OutDataTemplateServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7981886894068261655L;


	public void outData(HttpServletResponse response, Object obj) {

		response.setCharacterEncoding("utf8");
		try {
			response.setHeader("Content-Type", "application/json;charset=UTF-8");
			response.setHeader("Access-Control-Allow-Origin", "*");
	        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
	        response.setHeader("Access-Control-Max-Age", "3600");
	        response.setHeader("Access-Control-Allow-Headers", "x-requested-with,Authorization");
	        response.setHeader("Access-Control-Allow-Credentials","true");
			response.getWriter().println(JSON.toJSONString(obj));
			response.getWriter().flush();
			response.getWriter().close();
		} catch (IOException e) {
			
			
		}
	}

}
