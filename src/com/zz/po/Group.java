package com.zz.po;

import java.util.HashSet;
import java.util.Set;

/**
 * User entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Group implements java.io.Serializable, org.jbpm.api.identity.Group {
	private String id;
	private String name;
	private String type;
	private Set<User> users = new HashSet<User>();

	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String getId() {
		// TODO Auto-generated method stub
		return id;
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return name;
	}

	@Override
	public String getType() {
		// TODO Auto-generated method stub
		return type;
	}

}