package com.kms.model;



public class User {
	private String userid;
	private String password;
	private String lastlogin;
	private int rank_u;
	private int score;
	
	public User(){
		
	}
	
	public User(String id, String pw) {
		userid=id; password=pw;
	}
	public User(String id, int sc) {
		userid=id; score=sc;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getLastlogin() {
		return lastlogin;
	}
	public void setLastlogin(String lastlogin) {
		this.lastlogin = lastlogin;
	}
	public int getRank_u() {
		return rank_u;
	}
	public void setRank_u(int rank_u) {
		this.rank_u = rank_u;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	@Override
	public String toString() {
		return "User [userid=" + userid + ", password=" + password + ", lastlogin=" + lastlogin + ", rank=" + rank_u
				+ ", score=" + score + "]";
	}
	
}
