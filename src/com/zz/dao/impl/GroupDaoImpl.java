package com.zz.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Set;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.zz.dao.IGroupDao;
import com.zz.dao.IUserDao;
import com.zz.po.Group;
import com.zz.po.User;

public class GroupDaoImpl implements IGroupDao {

	private HibernateTemplate hibernateTemplate;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
	}

	public void saveGroup(Group group) {
		hibernateTemplate.save(group);
	}

	@Override
	public List<Group> getAllGroup() {
		return hibernateTemplate.find("from Group");
	}

	@Override
	public long getGroupCount() {
		return (Long) hibernateTemplate.find("select count(*) from Group").get(
				0);
	}

	@Override
	public List<Group> getGroupBeginXEndY(final int currentPageIndex) {
		final String hql = "from Group";
		List<Group> list = hibernateTemplate
				.executeFind(new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = session.createQuery(hql);
						query.setFirstResult(currentPageIndex);
						query.setMaxResults(10);
						List list = query.list();
						return list;
					}
				});
		return list;
	}

	@Override
	public Set<User> getUsersByGroupId(String groupId) {
		// TODO Auto-generated method stub
		Group group = (Group) hibernateTemplate.get(Group.class, groupId);
		Set<User> set = group.getUsers();
		return set;
	}

	@Override
	public Group getGroupByID(String groupId) {
		// TODO Auto-generated method stub
		return (Group) hibernateTemplate.get(Group.class, groupId);
	}

}
