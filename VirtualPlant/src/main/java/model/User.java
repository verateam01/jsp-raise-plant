package model;

public class User {
	private String name;
	private String nick;
	private String id;
	private String pw;
	private String userType;
	
	
	public User() {}
	public User(String name, String nick, String id, String pw, String userType) {
		this.name = name;
		this.nick = nick;
		this.id = id;
		this.pw = pw;
		this.userType=userType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}
	
	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	
	
	
	
	
	
	
}
