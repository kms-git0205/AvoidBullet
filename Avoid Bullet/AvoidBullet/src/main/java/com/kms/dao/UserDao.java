package com.kms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;

import com.kms.model.User;
import com.kms.util.DBUtil;

public class UserDao {

	private SqlSession sqlSession;
	
	public UserDao() {
		sqlSession = DBUtil.getSqlSession();
	}
	
	//Mybatis�� ����ϱ� ������ �̷��� « - �ش� userID���� ����� User ������ ��ȯ
	public User getUserById(@Param("userId") String userId) {
		User user = sqlSession.selectOne("UserMapper.getUserById", userId);
		return user;
	}

	public void modifyUser(@Param("user") User user){
		//������ ��й�ȣ ��������� ��� ����
		sqlSession.update("UserMapper.modifyUser", user);
		sqlSession.commit();
	}
	
	
	//�����ϴ� ���� ����
	public void delUser(@Param("userId") String userId) {
		sqlSession.delete("UserMapper.delUser", userId);
		sqlSession.commit();
	}
	
	
	//���ο� ���� ����
	public void addUser(@Param("user") User user) {
		sqlSession.insert("UserMapper.addUser", user);
		sqlSession.commit();
	}
	
	
	public List<User> showUsers() {
		return sqlSession.selectList("UserMapper.showUsers");
	}

	//������� ��ũ ���� - �α��� �� ���ŵ�
	public void setRank(@Param("user") User user) {
		sqlSession.update("UserMapper.setRank", user);
		sqlSession.commit();
	}
	
	
	//�ش� ������ �α��� �� ��� -> �ֱ� �α��� �ð��� ����� ����
	public void setLastLogin(@Param("userId") String userId) {
		sqlSession.update("UserMapper.setLastLogin", userId);
		sqlSession.commit();
	}
	
	public void setScore(@Param("user") User user) {
		sqlSession.update("UserMapper.setScore", user);
		sqlSession.commit();
	}
	
}
