package _dto;

public class CalenderDTO {

	private int action =2;//up(1) down(0)
	private int currYear ;
	private int currMonth ;
	private int currDay;
	private String title;
	private int week;
	private int maxday;
	private String current;
	
	public void setAction(int action){this.action=action;}
	public void setCurrYear(int currYear){this.currYear =currYear;}
	public void setCurrMonth(int currMonth){this.currMonth=currMonth;}
	public void setCurrDay(int currDay){this.currDay=currDay;}
	public void setTitle(String title){this.title=title;}
	public void setWeek(int week){this.week=week;}
	public void setMaxday(int maxday){this.maxday=maxday;}
	public void setCurrent(String current){this.current=current;}
	public int getAction(){return action;}
	public int getCurrYear(){return currYear;}
	public int getCurrMonth(){return currMonth;}
	public int getCurrDay(){return currDay;}
	public String getTitle(){return title;}
	public int getWeek(){return week;}
	public int getMaxday(){return maxday;}
	public String getCurrent(){return current;}
}
