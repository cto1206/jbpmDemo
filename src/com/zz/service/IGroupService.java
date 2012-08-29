package com.zz.service;

import java.util.List;
import java.util.Set;

import com.zz.po.Group;
import com.zz.po.User;

public interface IGroupService {
	public void saveGroup(Group group);

	public List<Group> getAllGroup();

	public long getGroupCount();

	public List<Group> getGroupBeginXEndY(int currentPageIndex);

	public Group getGroupByID(String groupId);

	public Set<User> getUsersByGroupId(String groupd);
}
