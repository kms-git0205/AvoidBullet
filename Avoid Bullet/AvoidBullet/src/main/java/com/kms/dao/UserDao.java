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
	
	//Mybatis를 사용하기 때문에 이렇게 짬 - 해당 userID가진 사람의 User 데이터 반환
	public User getUserById(@Param("userId") String userId) {
		User user = sqlSession.selectOne("UserMapper.getUserById", userId);
		return user;
	}

	public void modifyUser(@Param("user") User user){
		//유저의 비밀번호 변경사항을 디비에 저장
		sqlSession.update("UserMapper.modifyUser", user);
		sqlSession.commit();
	}
	
	
	//존재하는 유저 삭제
	public void delUser(@Param("userId") String userId) {
		sqlSession.delete("UserMapper.delUser", userId);
		sqlSession.commit();
	}
	
	
	//새로운 유저 삽입
	public void addUser(@Param("user") User user) {
		sqlSession.insert("UserMapper.addUser", user);
		sqlSession.commit();
	}
	
	
	public List<User> showUsers() {
		return sqlSession.selectList("UserMapper.showUsers");
	}

	//사용자의 랭크 갱신 - 로그인 시 갱신됨
	public void setRank(@Param("user") User user) {
		sqlSession.update("UserMapper.setRank", user);
		sqlSession.commit();
	}
	
	
	//해당 유저가 로그인 한 경우 -> 최근 로그인 시간을 현재로 변경
	public void setLastLogin(@Param("userId") String userId) {
		sqlSession.update("UserMapper.setLastLogin", userId);
		sqlSession.commit();
	}
	
	public void setScore(@Param("user") User user) {
		sqlSession.update("UserMapper.setScore", user);
		sqlSession.commit();
	}
	
}
