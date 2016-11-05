package _dto;

public class memberDTO 
{
	private String u_id;
	private String u_pw;
	private String u_name;
	private int u_type;
	private int u_flag;
	
	public void setU_id(String u_id){this.u_id=u_id;}
	public void setU_pw(String u_pw){this.u_pw=u_pw;}
	public void setU_name(String u_name){this.u_name=u_name;}
	public void setU_type(int u_type){this.u_type=u_type;}
	public void setU_flag(int u_flag){this.u_flag=u_flag;}
	
	public String getU_id(){return u_id;}
	public String getU_pw(){return u_pw;}
	public String getU_name(){return u_name;}
	public int getU_type(){return u_type;}
	public int getU_flag(){return u_flag;}
}
