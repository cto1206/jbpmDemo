package com.zz.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ApplicationContextHelper {

	private static ApplicationContextHelper applicationContextHelper = new ApplicationContextHelper();
	private static ApplicationContext context = null;

	/**
	 * 私有构造方法,避免外部创建实例
	 */
	private ApplicationContextHelper() {
	}

	/**
	 * 静态工厂方法,返回此类的唯一实例. 当发现实例没有初始化的时候,才初始化.
	 * 
	 * @return LazySingleton
	 */
	public static ApplicationContextHelper getInstance() {
		return applicationContextHelper;
	}

	public static void setApplicationContext(
			ApplicationContext applicationContext) {
		context = applicationContext;
	}

	public static ApplicationContext getApplicationContext() {
		if (context == null) {
			context = new ClassPathXmlApplicationContext("application*.xml");
		}
		return context;
	}
}
