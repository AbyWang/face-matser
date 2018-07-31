/**
 * 
 * @ClassName: FileUpServlet.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月30日
 */
package com.cdxt.face.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import com.cdxt.face.pojo.ResJson;
import com.cdxt.face.util.PropertyUtil;

/**
 * 
 * 
 * @ClassName: FileUpServlet.java
 * @Description: 文件上传
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月30日
 */
@WebServlet("/fileUpServlet")
public class FileUpServlet extends OutDataTemplateServlet {


	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(FileUpServlet.class);


	public FileUpServlet() {
		super();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取对应的请求参数
		String method = request.getParameter("method");
		//根据请求参数去调用对应的方法。
		if ("saveFiles".equals(method)) {
			saveFiles(request, response);
		}else  if("upload".equals(method)){
			upload(request, response);
		}
	}

	/**
	 * 
	 * @Title: saveFiles
	 * @author wangxiaolong
	 * @Description:图片上传
	 * @param
	 * @return
	 */
	public void  saveFiles(HttpServletRequest request, HttpServletResponse response) {

		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
		Map<String, String> map = new HashMap<String, String>();
		map = PropertyUtil.getPropertiesValues("sysConfig.properties");
		String picHome = map.get("picHome");
		String folderName=null;
		String pathf=null;
		try {
			List<FileItem> items = upload.parseRequest(request);
			Iterator<FileItem> itr = items.iterator();
			while (itr.hasNext()) {
				FileItem item = (FileItem) itr.next();
				if (item.isFormField()) {
					String name = item.getFieldName();  //参数域的名字
					String value = item.getString("UTF-8");  //参数域的值
					if(name.equals("folderName")){
						folderName=value;
					}

				} else {
					String filename = item.getName();
					if (filename != null && !filename.equals("")) {
						// 3. 保存文件
						pathf = picHome +File.separator +folderName;
						File file = new File(pathf);
						if (!file.exists() && !file.isDirectory()) {

							outData(response,new ResJson("0", "文件路径不存在"));
							continue;
						}
						// 2. 获取文件的实际内容
						InputStream is = item.getInputStream();
						FileUtils.copyInputStreamToFile(is, new File(pathf +File.separator + filename));

						//						logger.info("上传文件的大小:" + item.getSize());
						//						logger.info("上传文件的类型:" + item.getContentType());
						//						// item.getName()返回上传文件在客户端的完整路径名称
						//						logger.info("上传文件的名称:" + item.getName());
						//						filename = filename.substring(filename.lastIndexOf("\\") + 1);
						//						Map<String, String> map = new HashMap<String, String>();
						//						map = PropertyUtil.getPropertiesValues("sysConfig.properties");
						//						InputStream in = item.getInputStream();
						//						String picHome = map.get("picHome");
						//						String pathf = picHome +File.separator +folderName+File.separator ;
						//
						//						File file = new File(pathf);
						//						if (!file.exists() && !file.isDirectory()) {
						//							outData(response,new ResJson("0", "文件路径不存在"));
						//						}
						//						String realPath=pathf+File.separator+filename;
						//						FileOutputStream out = new FileOutputStream(realPath);
						//						byte buffer[] = new byte[1024];
						//						int len = 0;
						//						while ((len = in.read(buffer)) > 0) {
						//							out.write(buffer, 0, len);
						//						}
						//						in.close();
						//						out.close();
						//						item.delete();						

					}else{
						outData(response,new ResJson("0", "没有选择文件！"));
					}
				}
			}
			outData(response,new ResJson("1", "上传文件成功！"));
		}catch(FileUploadException e){
			outData(response,new ResJson("0", "上传失败！"));
			e.printStackTrace();
		} catch (Exception e) {
			outData(response,new ResJson("0", "上传失败！"));
			e.printStackTrace();
		}
	}


	public void upload(HttpServletRequest request, HttpServletResponse response){
		String folderName=request.getParameter("folderName");
		String uid=request.getParameter("uid");
		System.out.println(uid);
		System.out.println("进入后台...");
		// 1.创建DiskFileItemFactory对象，配置缓存用
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

		// 2. 创建 ServletFileUpload对象
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);

		// 3. 设置文件名称编码
		servletFileUpload.setHeaderEncoding("utf-8");

		// 4. 开始解析文件
		try {
			List<FileItem> items = servletFileUpload.parseRequest(request);
			for (FileItem fileItem : items) {

				if (fileItem.isFormField()) { // >> 普通数据
					String info = fileItem.getString("utf-8");
					System.out.println("info:" + info);
					outData(response,new ResJson("0", "没有选择文件！"));
				} else { // >> 文件
					// 1. 获取文件名称
					String name = fileItem.getName();
					// 2. 获取文件的实际内容
					InputStream is = fileItem.getInputStream();
					Map<String, String> map = new HashMap<String, String>();
					map = PropertyUtil.getPropertiesValues("sysConfig.properties");
					String picHome = map.get("picHome");
					// 3. 保存文件
					FileUtils.copyInputStreamToFile(is, new File(picHome+File.separator+folderName +File.separator + name));

				}

			}
			outData(response,new ResJson("1", "上传成功！"));
		} catch (Exception e) {
			outData(response,new ResJson("0", "上传失败！"));
			e.printStackTrace();
		}

	}

}


