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

import com.zz.dao.IUserDao;
import com.zz.po.Group;
import com.zz.po.User;

public class UserDaoImpl implements IUserDao {

	private HibernateTemplate hibernateTemplate;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
	}

	public void saveUser(User user) {
		hibernateTemplate.save(user);
	}

	@Override
	public List<User> getAllUsers() {
		return hibernateTemplate.find("from User");
	}

	@Override
	public long getUserCount() {
		return (Long) hibernateTemplate.find("select count(*) from User")
				.get(0);
	}

	@Override
	public List<User> getUsersBeginXEndY(final int currentPageIndex) {
		final String hql = "from User";
		List<User> list = hibernateTemplate
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
	public Set<Group> getGroupsByUserId(String userId) {
		// TODO Auto-generated method stub
		User user = (User) hibernateTemplate.get(User.class, userId);
		Set<Group> set = user.getGroups();
		return set;
	}

	@Override
	public User getUserByID(String userId) {
		// TODO Auto-generated method stub
		return (User) hibernateTemplate.get(User.class, userId);
	}

	@Override
	public User getUserByName(final String userName) {
		// TODO Auto-generated method stub
		return (User) hibernateTemplate.execute(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				// TODO Auto-generated method stub
				return session.createQuery(
						"from com.zz.po.User user where user.name='" + userName
								+ "'").uniqueResult();
			}
		});
	}
}
