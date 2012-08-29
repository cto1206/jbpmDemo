package com.zz.service.impl;

import java.util.List;
import java.util.Set;

import com.zz.dao.IUserDao;
import com.zz.po.Group;
import com.zz.po.User;
import com.zz.service.IUserService;

public class UserServiceImpl implements IUserService {

	private IUserDao userDao;

	public IUserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}

	public void saveUser(User user) {
		userDao.saveUser(user);
	}


	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return userDao.getAllUsers();
	}

	@Override
	public Set<Group> getGroupsByUserId(String userId) {
		// TODO Auto-generated method stub
		return userDao.getGroupsByUserId(userId);
	}

	@Override
	public User getUserByID(String userId) {
		// TODO Auto-generated method stub
		return userDao.getUserByID(userId);
	}

	@Override
	public User getUserByName(String userName) {
		// TODO Auto-generated method stub
		return userDao.getUserByName(userName);
	}

	@Override
	public long getUserCount() {
		// TODO Auto-generated method stub
		return userDao.getUserCount();
	}

	@Override
	public List<User> getUsersBeginXEndY(int currentPageIndex) {
		// TODO Auto-generated method stub
		return userDao.getUsersBeginXEndY(currentPageIndex);
	}

}
