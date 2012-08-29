package com.zz.po;

import java.util.HashSet;
import java.util.Set;

/**
 * User entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class User implements java.io.Serializable, org.jbpm.api.identity.User {
	private String id;
	private String name;
	private Set<Group> groups = new HashSet<Group>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<Group> getGroups() {
		return groups;
	}

	public void setGroups(Set<Group> groups) {
		this.groups = groups;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String getBusinessEmail() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getFamilyName() {
		// TODO Auto-generated method stub
		return name;
	}

	@Override
	public String getGivenName() {
		// TODO Auto-generated method stub
		return name;
	}

	@Override
	public String getId() {
		// TODO Auto-generated method stub
		return id;
	}

}