package com.zz.service;

import java.util.List;
import java.util.Set;

import com.zz.po.Group;
import com.zz.po.User;

public interface IUserService {
	public void saveUser(User user);


	public List<User> getAllUsers();

	public long getUserCount();

	public List<User> getUsersBeginXEndY(int currentPageIndex);

	public User getUserByID(String userId);

	public User getUserByName(String userName);

	public Set<Group> getGroupsByUserId(String userId);
}
