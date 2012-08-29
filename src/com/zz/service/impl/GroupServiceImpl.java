package com.zz.service.impl;

import java.util.List;
import java.util.Set;

import com.zz.dao.IGroupDao;
import com.zz.po.Group;
import com.zz.po.User;
import com.zz.service.IGroupService;

public class GroupServiceImpl implements IGroupService {
	private IGroupDao groupDao;

	@Override
	public List<Group> getAllGroup() {
		// TODO Auto-generated method stub
		return groupDao.getAllGroup();
	}

	@Override
	public List<Group> getGroupBeginXEndY(int currentPageIndex) {
		// TODO Auto-generated method stub
		return groupDao.getGroupBeginXEndY(currentPageIndex);
	}

	@Override
	public Group getGroupByID(String groupId) {
		// TODO Auto-generated method stub
		return groupDao.getGroupByID(groupId);
	}

	@Override
	public long getGroupCount() {
		// TODO Auto-generated method stub
		return groupDao.getGroupCount();
	}

	@Override
	public Set<User> getUsersByGroupId(String groupd) {
		// TODO Auto-generated method stub
		return groupDao.getUsersByGroupId(groupd);
	}

	@Override
	public void saveGroup(Group group) {
		// TODO Auto-generated method stub
		groupDao.saveGroup(group);
	}

	public IGroupDao getGroupDao() {
		return groupDao;
	}

	public void setGroupDao(IGroupDao groupDao) {
		this.groupDao = groupDao;
	}

}
