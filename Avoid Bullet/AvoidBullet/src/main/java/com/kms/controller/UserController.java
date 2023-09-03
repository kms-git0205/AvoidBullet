package com.kms.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.attribute.UserPrincipalLookupService;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.session.TransactionIsolationLevel;

import com.kms.dao.UserDao;
import com.kms.model.User;

/**
 * Servlet implementation class UserController
 */

@WebServlet("/UserController")	// 이게 매우 중요
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	UserDao userDao;
		
    public UserController() {
        this.userDao = new UserDao(); 
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 입력 데이터 얻어옴
		String useridStr = request.getParameter("userid");	
		String password = request.getParameter("password");	
		String state = request.getParameter("state");
		
		
		
		List<User> UL = userDao.showUsers();	// 랭크들 저장
		
		// 랭크 갱신을 위해 입력
		for(int i=0; i<UL.size(); i++){
			userDao.setRank(UL.get(i));
		}
		
		if(state.equals("start")){	// 게임 시작화면이면 1위만 뽑아서 전달
			
			if(UL.size()!=0){	// user가 존재할 때에만 1위를 뽑음
				request.setAttribute("userid", UL.get(0).getUserid());
				request.setAttribute("score", UL.get(0).getScore());
			}
			else{
				request.setAttribute("userid", "없음");
				request.setAttribute("score", 0);
		
			}
			// 해당 페이지로 이동
			RequestDispatcher view = request.getRequestDispatcher("start.jsp");
			view.forward(request, response);
		}
			
		// DB데이터 얻어옴 -> 여기서 select문 실행
		User newUser = userDao.getUserById(useridStr);

		if(state.equals("login"))
			Login(request, response, useridStr, password, state, newUser);	// 로그인
																			// 구현
		else if(state.equals("register"))
			Register(request, response, useridStr, password, state, newUser);	// 회원가입
																				// 구현
		else if(state.equals("admin"))	// 관리자 로그인
			Admin(request, response, useridStr, password, state, newUser);
		else if(state.equals("deletion"))
			Delete(request, response, useridStr, password, state, newUser);
		else if(state.equals("gameover"))
			gameOver(request, response, useridStr, password, state, newUser);
		else if(state.equals("gameplay"))
			gamePlay(request, response, useridStr, password, state, newUser);
		else if(state.equals("modifyuser")){
			modifyUser(request, response, useridStr, password, state, newUser);
		}
	}

	
	void modifyUser(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// 회원정보(비밀번호) 수정
		String received_pw = request.getParameter("rcvdPw");
		String new_pw = request.getParameter("newPw");
		
			
		if(password.equals(received_pw)){	// 비번 변경 가능한 경우
			newUser.setPassword(new_pw);
			userDao.modifyUser(newUser);
		
			// 해당 페이지로 이동
			RequestDispatcher view = request.getRequestDispatcher("loginPwModified.jsp");
			view.forward(request, response);
		}
		else{	// 패스워드가 틀린 경우
			request.setAttribute("user", newUser);
			
			// 해당 페이지로 이동
			RequestDispatcher view = request.getRequestDispatcher("mypageFailed.jsp");
			view.forward(request, response);
		}
		
	}
	void gamePlay(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// 로그인 이후 Game Start 클릭 -> 게임 시작
		
		request.setAttribute("user", newUser);
			
		// 해당 페이지로 이동
		RequestDispatcher view = request.getRequestDispatcher("gameplay.jsp");
		view.forward(request, response);
	}
	
	
	void gameOver(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// 게임 오버에 신기록 달성인 상황 -> 점수 및 랭크 설정
		
		int score = Integer.parseInt(request.getParameter("score"));
		
		newUser.setScore(score);
		userDao.setScore(newUser);
		
		request.setAttribute("user", newUser);
		// 해당 페이지로 이동
		RequestDispatcher view = request.getRequestDispatcher("authentication.jsp?id="+newUser.getUserid()+"&pw="+newUser.getPassword()+"&action=login");
		
		view.forward(request, response);

	}
	
	void Delete(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// 사용자 삭제
		userDao.delUser(useridStr);		
		
		// 랭크 갱신
		List<User> UL = userDao.showUsers();
		for(int i=0; i<UL.size(); i++)
			userDao.setRank(UL.get(i));
		
		// 관리자 페이지 조회
		Admin(request, response, "kms", "12171588", "admin", newUser);
	}
	
	void Admin(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// 관리자 페이지 조회
		
		String path="adminFailed.jsp";	// 이동할 페이지
		if(useridStr.equals("kms") && password.equals("12171588")) {
			// kms, 12171588이 관리자 정보
			path="adminpage.jsp";		
		}
		
		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(
				Resources.getResourceAsReader("mybatis-config.xml"));
		
		SqlSession ss = factory.openSession();	
		
		List<User> list = ss.selectList("UserMapper.showUsers");
		ss.close();

		String res = "";	// 전송할 문자열
		
		for(User u : list) {
			res+=u.getUserid() + " " + u.getPassword() + " " + u.getLastlogin() + " " + u.getRank_u() + " " + u.getScore() + "\n";
		}
	
		request.setAttribute("userlist", res);	// 사용자들 정보 전송

		// 해당 페이지로 이동
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
		
	}
	
	void Register(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		String path="registerFailed.jsp";	// 이동할 페이지
		
		if(newUser==null) {
			// 사용자 추가
			userDao.addUser(new User(useridStr, password));		
			path="registerSuccess.jsp";
		}
		
		
		// 해당 페이지로 이동
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
	}
	
	void Login(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// 이곳에서 로그인 구현
		String path="";	// 이동할 페이지
		
		if(newUser==null) // DB에 아이디 정보가 없는 경우 -> 아이디 입력 실패 페이지로 이동
			path="loginIdFailed.jsp";
		else if(!newUser.getPassword().equals(password)) // DB와 사용자의 비밀번호가 다른
															// 경우
			path="loginPwFailed.jsp";
		else {	
			userDao.setLastLogin(useridStr);
			path="mypage.jsp";
		}
		request.setAttribute("user", newUser);
		
		// 해당 페이지로 이동
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
