package com.cdxt.face.servlet;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cdxt.face.pojo.ResJson;
import com.cdxt.face.util.PropertyUtil;



/**
 * 
 * 
 * @ClassName: FolderServlet.java
 * @Description: 文件夹操作
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月27日
 */
@WebServlet("/folderServlet")
public class FolderServlet extends OutDataTemplateServlet {

	private Logger logger = LoggerFactory.getLogger(this.getClass().getName());

	private static final long serialVersionUID = 1L;

	public FolderServlet() {
		super();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取对应的请求参数
		String method = request.getParameter("method");
		//根据请求参数去调用对应的方法。
		if ("addFolder".equals(method)) {
			addFolder(request, response);

		} else if ("getFolderList".equals(method)) {
			getFolderList(request, response);
		}else if ("delete".equals(method)) {
			delete(request, response);
		}else if ("getPicsByFolderName".equals(method)) {
			getPicsByFolderName(request, response);
		}else if ("delPic".equals(method)) {
			delPic(request, response);
		}
	}

	private void getFolderList(HttpServletRequest request, HttpServletResponse response){

		Map<String, String> map = new HashMap<String, String>();
		map = PropertyUtil.getPropertiesValues("sysConfig.properties");
		String picHome = map.get("picHome");
		String folderName=request.getParameter("folderName");
		List<String>list=new ArrayList<String>();
		logger.info("picHome:"+picHome);
		if(StringUtils.isBlank(folderName)){
			File dir = new File(picHome);
			if(!dir.exists()){
				outData(response, new ResJson("0", "目录:"+dir+"不存在.",""));
			}
			// 获得该文件夹内的所有文件   
			//只有一级，不做递归
			File[] files  = dir.listFiles();   
			for(File file:files){
				if (file.isDirectory()) {
					list.add(file.getName());
				}
			}
		}else{
			File dir = new File(picHome+File.separator+folderName);
			if(!dir.exists()){
				outData(response, new ResJson("0", "类型:"+dir+"不存在.",""));
			}
			list.add(dir.getName());
		}
		outData(response, new ResJson("1","查询成功", list));
	}


	/**
	 * 
	 * @Title: getPicsByFolderName
	 * @author wangxiaolong
	 * @Description:获取文件夹下所有图片
	 * @param
	 * @return
	 */
	private void getPicsByFolderName(HttpServletRequest request, HttpServletResponse response){ 
		Map<String, String> map = new HashMap<String, String>();
		String folderName=request.getParameter("folderName");
		map = PropertyUtil.getPropertiesValues("sysConfig.properties");
		String picHome = map.get("picHome");
		String picPath=map.get("picPath");


		List<String>list=new ArrayList<String>();
		String picFolder=picHome+File.separator+folderName;
		//图片虚拟路径，浏览器不能直接访问本地绝对地址
		String realPath=picPath+File.separator+folderName;
		try{
			if(StringUtils.isNotBlank(picFolder)){
				File dir = new File(picFolder);
				if(!dir.exists()){
					outData(response, new ResJson("0", "目录:"+dir+"不存在.",""));
				}
				// 获得该文件夹内的所有文件   
				File[] files  = dir.listFiles(); 
				//最多只有十张，不做分页
				for(File file:files){
					if (file.isFile()) {
						String fileName=file.getName();
						String fileSuffix = fileName.substring(fileName.lastIndexOf("."));
						//只遍历jpg,png 格式文件
						if(fileSuffix.toUpperCase().equals(".PNG")||fileSuffix.toUpperCase().equals(".JPG")){
							list.add(realPath+File.separator+fileName);
						}
					}
				}
				outData(response, new ResJson("1","查询成功", list));
			}
		}catch(Exception e ){
			outData(response, new ResJson("0","查询失败", ""));
		}
	}

	/**
	 * 
	 * @Title: addFolder
	 * @author wangxiaolong
	 * @Description:穿件类型
	 * @param
	 * @return
	 */
	private void addFolder(HttpServletRequest request, HttpServletResponse response){ 
		Map<String, String> map = new HashMap<String, String>();
		String folderName=request.getParameter("folderName");
		map = PropertyUtil.getPropertiesValues("sysConfig.properties");
		String picHome = map.get("picHome");

		String picFolder=picHome+File.separator+folderName;

		if(StringUtils.isNotBlank(picHome)){
			File dir = new File(picFolder);

			if(dir.exists()){
				outData(response, new ResJson("0", "目录:"+folderName+"已存在."));
			}
			//创建文件夹
			dir.mkdir();
			outData(response, new ResJson("1","创建成功"));
		}
	}


	/**
	 * 
	 * @Title: delete
	 * @author wangxiaolong
	 * @Description:删除文件夹
	 * @param
	 * @return
	 */
	private void delete(HttpServletRequest request, HttpServletResponse response){ 
		Map<String, String> map = new HashMap<String, String>();
		String folderName=request.getParameter("folderName");
		map = PropertyUtil.getPropertiesValues("sysConfig.properties");
		String picHome = map.get("picHome");
		String picFolder=picHome+File.separator+folderName;
		try{
			if(StringUtils.isNotBlank(picFolder)){
				File dir = new File(picFolder);
				File[] files=dir.listFiles();
				if(!dir.exists()){
					outData(response, new ResJson("0", "目录:"+dir+"不存在."));
				}
				// 为了谨慎起见先判断文件夹下是否有图片
				//				for(File file:files){
				//					String fileName=file.getName();
				//					String fileSuffix = fileName.substring(fileName.lastIndexOf("."));
				//					//只遍历jpg,png 格式文件
				//					if(fileSuffix.toUpperCase().equals(".PNG")||fileSuffix.toUpperCase().equals(".JPG")){
				//						outData(response, new ResJson("0", "请先删除图片"));
				//						break;
				//					}
				//				}
				if(files!=null&&files.length>0){
					//非空文件夹，递归删除
					deleteAllFilesOfDir(dir);
				}else{
					dir.delete();
				}
			}
			outData(response,new ResJson("1", "删除成功"));
		}catch(Exception  e){
			outData(response,new ResJson("0", "删除失败"));
		}
	}
	/**
	 * 
	 * @Title: deleteAllFilesOfDir
	 * @author wangxiaolong
	 * @Description:非空文件夹，递归删除
	 * @param
	 * @return
	 */
	public static void deleteAllFilesOfDir(File path) {  
		if (!path.exists())  
			return;  
		if (path.isFile()) {  
			path.delete();  
			return;  
		}  
		File[] files = path.listFiles();  
		for (int i = 0; i < files.length; i++) {  
			deleteAllFilesOfDir(files[i]);  
		}  
		path.delete();  
	}  

	/**
	 * 
	 * @Title: delPic
	 * @author wangxiaolong
	 * @Description:批量删除图片
	 * @param
	 * @return
	 */
	private void delPic(HttpServletRequest request, HttpServletResponse response){ 
		Map<String, String> map = new HashMap<String, String>();
		String folderName=request.getParameter("folderName");
		String picName=request.getParameter("picName");
		map = PropertyUtil.getPropertiesValues("sysConfig.properties");
		String picHome = map.get("picHome");
		String[] pics=picName.split(",");
		for(String pic:pics){
			String realPath=picHome+File.separator+folderName+File.separator+pic;
			if(StringUtils.isNotBlank(realPath)){
				File file = new File(realPath);
				//			if(!file.exists()){
				//				outData(response, new ResJson("0", "文件:"+file+"不存在."));
				//			}
				//删除
				file.delete();
			}
		}
		outData(response,new ResJson("1", "删除成功"));
	}

}