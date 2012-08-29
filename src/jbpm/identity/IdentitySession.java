package jbpm.identity;

import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zz.po.Group;
import com.zz.po.User;
import com.zz.service.IGroupService;
import com.zz.service.IUserService;

public class IdentitySession implements
		org.jbpm.pvm.internal.identity.spi.IdentitySession {
	private static ApplicationContext context = new ClassPathXmlApplicationContext(
			"applicationContext*.xml");
	private static IUserService userService = (IUserService) context
			.getBean("userService");
	private static IGroupService groupService = (IGroupService) context
			.getBean("groupService");

	public String createUser(String userName, String givenName,
			String familyName, String businessEmail) {
		return null;
	}

	public User findUserById(String userId) {
		return userService.getUserByID(userId);
	}

	public List findUsersById(String userIds[]) {
		List<User> list = new LinkedList<User>();
		for (String id : userIds) {
			list.add(userService.getUserByID(id));
		}
		return list;
	}

	public List findUsers() {
		return userService.getAllUsers();
	}

	public void deleteUser(String userId) {

	}

	public String createGroup(String groupName, String groupType,
			String parentGroupId) {
		return null;
	}

	public List findUsersByGroup(String groupId) {
		Set<User> set = groupService.getUsersByGroupId(groupId);
		List<User> list = new LinkedList<User>();
		for (User user : set) {
			list.add(user);
		}
		return list;
	}

	public Group findGroupById(String groupId) {
		return groupService.getGroupByID(groupId);
	}

	public List findGroupsByUserAndGroupType(String userId, String groupType) {
		return null;
	}

	public List findGroupsByUser(String userId) {
		Set<Group> set = userService.getGroupsByUserId(userId);
		List<Group> list = new LinkedList<Group>();
		for (Group group : set) {
			list.add(group);
		}
		return list;
	}

	public List findGroups() {
		return groupService.getAllGroup();
	}

	public void deleteGroup(String groupId) {
	}

	public void createMembership(String userId, String groupId, String role) {
	}

	public void deleteMembership(String userId, String groupId, String role) {
	}
}
