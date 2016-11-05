package teacher;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import _dto.TeacherDTO;

@Controller
public class TeacherController {
	
	String main = "main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	@RequestMapping("/teacher/teacherProfile.mooc")
	//강사 프로필 
		public String teacherProfile_main(HttpServletRequest request){
			String id="";
			String check=request.getParameter("check");
			if(request.getParameter("t_id")==null){
				HttpSession session=request.getSession();
				id=(String)session.getAttribute("memId");
			}else{
				id=request.getParameter("t_id");
			}
			_dto.TeacherDTO  dto=(_dto.TeacherDTO)sqlMap.queryForObject("t_idfrofile",id);
			
			request.setAttribute("check", check);
			request.setAttribute("cr", "\r"); //Space
			request.setAttribute("cn", "\n"); //Enter
			request.setAttribute("crcn", "\r\n"); //Space, Enter
			request.setAttribute("br", "<br/>"); //br 태그야
			request.setAttribute("dto", dto);
			String content = "teacher/teacher_profile.jsp";
			request.setAttribute("main_content", content);
			return main;
		}
	@RequestMapping("/teacher/teacherProfilePro.mooc")
		public String teacherProfileProfilePro(HttpServletRequest request,TeacherDTO dto){
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			if(request.getParameter("check")!=null){
				if(request.getParameter("check").equals("1"))
					sqlMap.update("teacherchange", id);
			}
			if(request.getParameter("check")==null){
				dto.setT_id(id);
				sqlMap.update("teacherfrofileUpdate", dto);
			}
			return "redirect:/teacher/teacherProfile.mooc";
		}
	@RequestMapping("/teacher/teacherDeletePro.mooc")
	//강사 탈퇴하기Pro
		public String teacherDeletePro(HttpServletRequest request){
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			sqlMap.update("teacherOut",id);
			return "redirect:/main.mooc";
	}
	@RequestMapping("/teacher/teacherDelete.mooc")
	//강사 탈퇴하기
		public String teacherDelete(HttpServletRequest request){
			String myClass_main = "teacher/myClass/_teacher_myClass_main.jsp"; //myStudy의 main페이지
			content = "/WEB-INF/view/teacher/teacher_delete.jsp";
			request.setAttribute("main_content", myClass_main);
			request.setAttribute("teacher_myClass_content", content);
			return main;
	}

	
	@RequestMapping("/teacher/teacherModify.mooc")
	//강사 정보 수정 
		public String teacherModify(HttpServletRequest request){
			String content = "teacher/teacher_modify.jsp";
			request.setAttribute("main_content", content);
			return main;
		}
	
	//추가
	@RequestMapping("/teacher/studentList.mooc")
	//수강생 관리
		public String studenList_main(HttpServletRequest request){
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			List list=sqlMap.queryForList("main_lecT_id",id);
			request.setAttribute("list", list);
			String myClass_main = "teacher/myClass/_teacher_myClass_main.jsp"; //myStudy의 main페이지
			content = "teacher_studentList.jsp";
			request.setAttribute("main_content", myClass_main);
			request.setAttribute("teacher_myClass_content", content);
			return main;
		}
	
	//수강생 관리
	@RequestMapping("/teacher/myStudentListAjax.mooc")
	//수강생 관리
		public String studenListAjax(HttpServletRequest request){
		int main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));
			List list=sqlMap.queryForList("main_lecStudentList",main_lec_code);
			request.setAttribute("list", list);
			return "/teacher/myClass/teacher_myStudentListAjax.jsp";
		}
}