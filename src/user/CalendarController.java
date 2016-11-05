package user;

import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import _dto.CalenderDTO;
import _dto.ChoiceLectureDTO;

@Controller
public class CalendarController {
	
	
	@Autowired
	SqlMapClientTemplate sqlMap;

	String main = "main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	String myStudy_main = "user/myStudy/_user_myStudy_main.jsp"; //myStudy의 main페이지
	
	
	@RequestMapping("user/planList.mooc")
	public String user_note_list_main(HttpServletRequest request,CalenderDTO dto){
		Calendar c =Calendar.getInstance();
		Calendar cal =Calendar.getInstance();
		Calender calendar=new Calender();
		CalenderDTO calend=new CalenderDTO();
		calend.setCurrMonth(c.get(Calendar.MONTH));
		calend.setCurrYear(c.get(Calendar.YEAR));
		if(dto.getAction()==2){
			dto.setCurrMonth(c.get(Calendar.MONTH));
			dto.setCurrYear(c.get(Calendar.YEAR));
			dto.setCurrDay(c.get(Calendar.DATE));
			dto.setCurrent(dto.getCurrYear()+"년 "+(new Integer(dto.getCurrMonth())+1)+"월");
			cal.set(dto.getCurrYear(),dto.getCurrMonth(),1);
			dto.setWeek(cal.get(Calendar.DAY_OF_WEEK));
			dto.setMaxday(calendar.isDate(dto.getCurrYear(),dto.getCurrMonth()+1));
			dto.setTitle(calendar.getTitle(cal));
		}else if(dto.getAction()==1){
				dto.setCurrDay(c.get(Calendar.DATE));
				dto.setCurrent(calend.getCurrYear()+"년 "+(new Integer(calend.getCurrMonth())+1)+"월");
				cal.set(dto.getCurrYear(),dto.getCurrMonth(),1);
				cal.add(Calendar.MONTH,1);
				dto.setCurrMonth(cal.get(Calendar.MONTH));
				dto.setCurrYear(cal.get(Calendar.YEAR));
				dto.setWeek(cal.get(Calendar.DAY_OF_WEEK));
				dto.setMaxday(calendar.isDate(dto.getCurrYear(),dto.getCurrMonth()+1));
				dto.setTitle(calendar.getTitle(cal));
		}else if(dto.getAction()==0){
				dto.setCurrDay(c.get(Calendar.DATE));
				dto.setCurrent(calend.getCurrYear()+"년 "+(new Integer(calend.getCurrMonth())+1)+"월");
				cal.set(dto.getCurrYear(),dto.getCurrMonth(),1);
				cal.add(Calendar.MONTH,-1);
				dto.setCurrMonth(cal.get(Calendar.MONTH));
				dto.setCurrYear(cal.get(Calendar.YEAR));
				dto.setWeek(cal.get(Calendar.DAY_OF_WEEK));
				dto.setMaxday(calendar.isDate(dto.getCurrYear(),dto.getCurrMonth()+1));
				dto.setTitle(calendar.getTitle(cal));
		}		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("memId");
		if(id!=null){
			List list=sqlMap.queryForList("choiceMain", id);
			request.setAttribute("list", list);
			List cal_list=sqlMap.queryForList("cal_list", id);
			Iterator iter=cal_list.iterator();
			while(iter.hasNext()){
				ChoiceLectureDTO choice=(ChoiceLectureDTO)iter.next();
				String date=choice.getSsd_date();
				String datelist[]=date.split("월");
				choice.setMonth(datelist[0]+"월");
				choice.setDay(datelist[1]);			
				ChoiceLectureDTO choiceA=(ChoiceLectureDTO)sqlMap.queryForObject("sub_lec",choice.getSub_lec_code());
				choice.setMain_lec_code(choiceA.getMain_lec_code());
				choice.setSub_lec_chapter(choiceA.getSub_lec_chapter());
				choice.setSub_lec_subject(choiceA.getSub_lec_subject());
				String subject=(String)sqlMap.queryForObject("main_lec",choiceA.getMain_lec_code());
				choice.setMain_lec_subject(subject);			
			}
			request.setAttribute("cal", cal_list);
			request.setAttribute("list", list);
			
		}
		request.setAttribute("dto", dto);
		content = "user_planList.jsp";
		request.setAttribute("main_content", myStudy_main);
		request.setAttribute("user_myStudy_content", content);
		return main;
	}
	
	@RequestMapping("user/mystudy/user_sub_lecture.mooc")
	public String user_sub_lecture_main(HttpServletRequest request,ChoiceLectureDTO dto){
		int code=dto.getMain_lec_code();
		List list=sqlMap.queryForList("subcode",code);
		request.setAttribute("List", list);
		return "/user/user_signAjax.jsp";
	}
	@RequestMapping("user/mystudy/user_listPro.mooc")
	public String user_sub_lecture(ChoiceLectureDTO dto,HttpSession session){
		dto.setU_id((String)session.getAttribute("memId"));
		sqlMap.insert("calandarinsert", dto);
		return "redirect:/user/planList.mooc";
	}
	@RequestMapping("user/mystudy/user_plan_delete.mooc")
	public String user_plan_delete(int ssd_num){
		sqlMap.delete("planDelete", ssd_num);
		
		return "redirect:/user/planList.mooc";
	}
	@RequestMapping("user/mystudy/user_plan_check.mooc")
	public String user_plan_check(ChoiceLectureDTO dto){
		sqlMap.update("planDone",dto);
		return "redirect:/user/planList.mooc";
	}
}
