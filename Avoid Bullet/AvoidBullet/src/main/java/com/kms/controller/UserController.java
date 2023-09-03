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

@WebServlet("/UserController")	// �̰� �ſ� �߿�
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	UserDao userDao;
		
    public UserController() {
        this.userDao = new UserDao(); 
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// �Է� ������ ����
		String useridStr = request.getParameter("userid");	
		String password = request.getParameter("password");	
		String state = request.getParameter("state");
		
		
		
		List<User> UL = userDao.showUsers();	// ��ũ�� ����
		
		// ��ũ ������ ���� �Է�
		for(int i=0; i<UL.size(); i++){
			userDao.setRank(UL.get(i));
		}
		
		if(state.equals("start")){	// ���� ����ȭ���̸� 1���� �̾Ƽ� ����
			
			if(UL.size()!=0){	// user�� ������ ������ 1���� ����
				request.setAttribute("userid", UL.get(0).getUserid());
				request.setAttribute("score", UL.get(0).getScore());
			}
			else{
				request.setAttribute("userid", "����");
				request.setAttribute("score", 0);
		
			}
			// �ش� �������� �̵�
			RequestDispatcher view = request.getRequestDispatcher("start.jsp");
			view.forward(request, response);
		}
			
		// DB������ ���� -> ���⼭ select�� ����
		User newUser = userDao.getUserById(useridStr);

		if(state.equals("login"))
			Login(request, response, useridStr, password, state, newUser);	// �α���
																			// ����
		else if(state.equals("register"))
			Register(request, response, useridStr, password, state, newUser);	// ȸ������
																				// ����
		else if(state.equals("admin"))	// ������ �α���
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
		// ȸ������(��й�ȣ) ����
		String received_pw = request.getParameter("rcvdPw");
		String new_pw = request.getParameter("newPw");
		
			
		if(password.equals(received_pw)){	// ��� ���� ������ ���
			newUser.setPassword(new_pw);
			userDao.modifyUser(newUser);
		
			// �ش� �������� �̵�
			RequestDispatcher view = request.getRequestDispatcher("loginPwModified.jsp");
			view.forward(request, response);
		}
		else{	// �н����尡 Ʋ�� ���
			request.setAttribute("user", newUser);
			
			// �ش� �������� �̵�
			RequestDispatcher view = request.getRequestDispatcher("mypageFailed.jsp");
			view.forward(request, response);
		}
		
	}
	void gamePlay(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// �α��� ���� Game Start Ŭ�� -> ���� ����
		
		request.setAttribute("user", newUser);
			
		// �ش� �������� �̵�
		RequestDispatcher view = request.getRequestDispatcher("gameplay.jsp");
		view.forward(request, response);
	}
	
	
	void gameOver(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// ���� ������ �ű�� �޼��� ��Ȳ -> ���� �� ��ũ ����
		
		int score = Integer.parseInt(request.getParameter("score"));
		
		newUser.setScore(score);
		userDao.setScore(newUser);
		
		request.setAttribute("user", newUser);
		// �ش� �������� �̵�
		RequestDispatcher view = request.getRequestDispatcher("authentication.jsp?id="+newUser.getUserid()+"&pw="+newUser.getPassword()+"&action=login");
		
		view.forward(request, response);

	}
	
	void Delete(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// ����� ����
		userDao.delUser(useridStr);		
		
		// ��ũ ����
		List<User> UL = userDao.showUsers();
		for(int i=0; i<UL.size(); i++)
			userDao.setRank(UL.get(i));
		
		// ������ ������ ��ȸ
		Admin(request, response, "kms", "12171588", "admin", newUser);
	}
	
	void Admin(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// ������ ������ ��ȸ
		
		String path="adminFailed.jsp";	// �̵��� ������
		if(useridStr.equals("kms") && password.equals("12171588")) {
			// kms, 12171588�� ������ ����
			path="adminpage.jsp";		
		}
		
		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(
				Resources.getResourceAsReader("mybatis-config.xml"));
		
		SqlSession ss = factory.openSession();	
		
		List<User> list = ss.selectList("UserMapper.showUsers");
		ss.close();

		String res = "";	// ������ ���ڿ�
		
		for(User u : list) {
			res+=u.getUserid() + " " + u.getPassword() + " " + u.getLastlogin() + " " + u.getRank_u() + " " + u.getScore() + "\n";
		}
	
		request.setAttribute("userlist", res);	// ����ڵ� ���� ����

		// �ش� �������� �̵�
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
		
	}
	
	void Register(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		String path="registerFailed.jsp";	// �̵��� ������
		
		if(newUser==null) {
			// ����� �߰�
			userDao.addUser(new User(useridStr, password));		
			path="registerSuccess.jsp";
		}
		
		
		// �ش� �������� �̵�
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
	}
	
	void Login(HttpServletRequest request, HttpServletResponse response, String useridStr, String password, String state, User newUser) throws ServletException, IOException {
		// �̰����� �α��� ����
		String path="";	// �̵��� ������
		
		if(newUser==null) // DB�� ���̵� ������ ���� ��� -> ���̵� �Է� ���� �������� �̵�
			path="loginIdFailed.jsp";
		else if(!newUser.getPassword().equals(password)) // DB�� ������� ��й�ȣ�� �ٸ�
															// ���
			path="loginPwFailed.jsp";
		else {	
			userDao.setLastLogin(useridStr);
			path="mypage.jsp";
		}
		request.setAttribute("user", newUser);
		
		// �ش� �������� �̵�
		RequestDispatcher view = request.getRequestDispatcher(path);
		view.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
