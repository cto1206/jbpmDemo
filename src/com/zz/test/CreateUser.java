package com.zz.test;

import java.util.HashSet;
import java.util.Set;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zz.po.Group;
import com.zz.po.User;
import com.zz.service.IUserService;

public class CreateUser {
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"applicationContext-*.xml");
		IUserService userService = (IUserService) context
				.getBean("userService");
		// Group group = new Group();
		// group.setName("开发部");
		// User user = new User();
		// user.setName("张三");
		// Set<Group> groups = new HashSet<Group>();
		// groups.add(group);
		// user.setGroups(groups);
		// userService.saveUser(user);

		// Group group2 = new Group();
		// group2.setName("领导");
		// Set<Group> groups2 = new HashSet<Group>();
		// groups2.add(group2);
		//
		// User user2 = new User();
		// user2.setName("项目经理");
		// user2.setGroups(groups2);
		// userService.saveUser(user2);
		//
		// User user3 = new User();
		// user3.setName("老板");
		// user3.setGroups(groups2);
		// userService.saveUser(user3);

		// Group group3 = new Group();
		// group3.setName("管理员");
		// Set<Group> groups3 = new HashSet<Group>();
		// groups3.add(group3);
		//
		// User user4 = new User();
		// user4.setName("系统管理员");
		// user4.setGroups(groups3);
		// userService.saveUser(user4);

	}
}
