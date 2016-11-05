package user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import _dto.ChoiceLectureDTO;
import _dto.mainlectureDTO;

@Controller
public class registrationController {
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	String main = "/community/_commu_main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	
	@RequestMapping("/user_lectureRegister.mooc")
	public String lectureRegistration(HttpSession session,ChoiceLectureDTO dto){

		dto.setU_id((String)session.getAttribute("memId"));
		if((String)session.getAttribute("memId")!=null){
			sqlMap.insert("LectureRegistration",dto);
		}
		return "redirect:/viewMainLec.mooc?main_lec_code="+dto.getMain_lec_code();
	}
	@RequestMapping("/user_interestTeacher.mooc")
	public String user_interestTeacher(HttpSession session,mainlectureDTO dto){
		dto.setU_id((String)session.getAttribute("memId"));
		if((String)session.getAttribute("memId")!=null){
		sqlMap.insert("interastTeacher",dto);
		}
		return "redirect:/viewMainLec.mooc?main_lec_code="+dto.getMain_lec_code();
	}
	@RequestMapping("/user_interestLecture.mooc")
	public String user_interestLecture(HttpSession session,mainlectureDTO dto){
		dto.setU_id((String)session.getAttribute("memId"));//session으로 가입 막기
		if((String)session.getAttribute("memId")!=null){
			sqlMap.insert("interastLecture",dto);
		}
		return "redirect:/viewMainLec.mooc?main_lec_code="+dto.getMain_lec_code();
	}
}
