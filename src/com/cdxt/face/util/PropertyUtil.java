/**
 * 
 * @ClassName: PropertyUtil.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年6月19日
 */
package com.cdxt.face.util;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * 
 * @ClassName: PropertyUtil.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年6月19日
 */
public class PropertyUtil {
	
	public static   Map<String,String> getPropertiesValues(String fileName)  {
		
		Properties properties;
		
		Map<String,String> propMap = new HashMap<String,String>();
		try {
			properties = PropertyUtil.getProperties(fileName);
			Enumeration<Object> enums =  properties.keys();
			while(enums.hasMoreElements()){
				String key = (String)enums.nextElement();
				String value = properties.getProperty(key);
				propMap.put(key, value);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return propMap;
	}
	
	public static Properties getProperties(String fileName) throws IOException {
		Map<Integer, Properties> propertiesMap = new HashMap<Integer, Properties>();
		Properties property = propertiesMap.get(fileName.hashCode());
		if(property==null){
			Properties properties = new Properties();
			properties.load(PropertyUtil.class.getClassLoader().getResourceAsStream(fileName));
			propertiesMap.put(fileName.hashCode(), properties);
			property = properties;
		}
		return property;
	}
	
}
