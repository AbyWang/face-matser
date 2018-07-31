package com.cdxt.face.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cdxt.face.pojo.ResJson;
import com.cdxt.face.util.PropertyUtil;



/**
 * 
 * 
 * @ClassName: loginServlet.java
 * @Description: 登录
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月26日
 */
@WebServlet("/loginServlet")
public class LoginServlet extends OutDataTemplateServlet {

	private Logger logger = LoggerFactory.getLogger(this.getClass().getName());

	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取对应的请求参数
		String method = request.getParameter("method");
		//根据请求参数去调用对应的方法。
		if ("login".equals(method)) {
			login(request, response);
		}else  if("logout".equals(method)){
			logout(request, response);
		}
	}


	/**
	 * 
	 * @Title: login
	 * @author wangxiaolong
	 * @Description:登录
	 * @param
	 * @return
	 */
	protected void login(HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> map = new HashMap<String, String>();
		String uName=request.getParameter("userName");
		String pwd=request.getParameter("password");
		String userName;
		String password;
		ResJson resJson = new ResJson("0", "用户名或密码错误");
		map = PropertyUtil.getPropertiesValues("sysConfig.properties");
		userName = map.get("username");
		password = map.get("password");
		logger.info("userName:"+userName);
		logger.info("password"+password);
		if(userName.equals(uName)&&password.equals(pwd)){
			HttpSession session=request.getSession();
			session.setAttribute("admin", uName);
			resJson = new ResJson("1", "登录成功");
		}
		outData(response, resJson);
	}

	/**
	 * 
	 * @Title: logout
	 * @author wangxiaolong
	 * @Description:注销
	 * @param
	 * @return
	 */
	protected void logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		session.removeAttribute("admin");
		session.invalidate();
		outData(response, new ResJson("1","退出成功"));
	}

}