package com.app.util;

import com.alibaba.druid.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


public class StringUtilsEx extends StringUtils {

	/**
	 * 判断是否是空(方法重载)
	 * @param o
	 * @return
	 */
	public static boolean isEmpty(Object o){
		if(o != null && !"".equals(o.toString()) ){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 判断是否不为空(方法重载)
	 * @param o
	 * @return
	 */
	public static boolean isNotEmpty(Object o){
		return !isEmpty(o);
	}
	
	
	/**
	 * 讲一个list转换成Object数组
	 * 方法名：listToArray
	 * 创建人：admin 
	 * 时间：2017年2月22日-下午5:39:20 
	 * @param list
	 * @return Object[][]
	 * @exception 
	 * @since  1.0.0
	 */
	public static Object[] listToArray(List<String> list){
		int size = list.size();
		Object[] arr = new Object[size];
		int index = 0;
		for(String s : list){
			arr[index++] = s;
		}
		
		return arr;
	}
	
	
	public static void main(String[] args) {
		
	}

	public static String now() {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	}
}
