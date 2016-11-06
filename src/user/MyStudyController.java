package user;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import _dto.LectureDTO;
import _dto.pageAction;
import _dto.studyNoteDTO;

@Controller
public class MyStudyController {
	
	String main = "main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	String myStudy_main = "user/myStudy/_user_myStudy_main.jsp"; //myStudy의 main페이지
	pageAction paging=null;
	
	@Autowired
	 SqlMapClientTemplate sqlMap;
	
	//----------------------------myStudy 시작----------------------------//
	
	@RequestMapping("/user/myStudy.mooc")
	//myStudy 메인
		public String myStudy_main(HttpServletRequest request){
			content = "_user_myStudy_container.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/user/lectureList.mooc")
	//강의목록
		public String myLectureList_main(HttpServletRequest request){
			String pageNum=request.getParameter("pageNum");
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			System.out.println(id);
			List AllList=sqlMap.queryForList("userlecture",id);
			System.out.println(AllList.size());
			pageAction pageing=new pageAction();
			List list=pageing.pageList(pageNum,AllList, 12);
			int subCount=(int)sqlMap.queryForObject("userlectureCount", id);
			
			List topCtgListUser=sqlMap.queryForList("selectAllTopCtg",null);
			List subCtgListUser=sqlMap.queryForList("selectAllSubCtg",null);
			request.setAttribute("topCtgListUser", topCtgListUser);
			request.setAttribute("subCtgListUser", subCtgListUser);
			
	
			request.setAttribute("subCount", subCount);
			request.setAttribute("count",pageing.count());
			request.setAttribute("currentPage", pageing.current());
			request.setAttribute("pageSize", pageing.size());
			request.setAttribute("list", list);
			
			
		
			content = "user_lectureList.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
	}
	@RequestMapping("/user/lectureListCategory.mooc")
	//강의목록
		public String myLectureListCategory_main(HttpServletRequest request){
			int sub_ctg_code=Integer.parseInt(request.getParameter("sub_ctg_code"));
			String pageNum=request.getParameter("pageNum");
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			
			HashMap a=new HashMap();
			a.put("u_id",id);
			a.put("sub_ctg_code",sub_ctg_code);
			
			List AllList=(ArrayList)sqlMap.queryForList("userCtglecture",a);
			pageAction pageing=new pageAction();
			List list=pageing.pageList(pageNum,AllList, 12);
			int subCount=(int)sqlMap.queryForObject("userCtglectureCount", a);	
			List topCtgListUser=sqlMap.queryForList("selectAllTopCtg",null);
			List subCtgListUser=sqlMap.queryForList("selectAllSubCtg",null);
			request.setAttribute("topCtgListUser", topCtgListUser);
			request.setAttribute("subCtgListUser", subCtgListUser);
			
			request.setAttribute("subCount", subCount);
			request.setAttribute("count",pageing.count());
			request.setAttribute("currentPage", pageing.current());
			request.setAttribute("pageSize", pageing.size());
			request.setAttribute("list", list);
		
		
			content = "user_lectureList.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
	}
	
	@RequestMapping("/user/noteList.mooc")
	//필기목록
		public String noteList_main(HttpServletRequest request){
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			List AllList=(ArrayList)sqlMap.queryForList("NoteList",id);
			
			String pageNum=request.getParameter("pageNum");
			pageAction page=new pageAction();
			List list=page.pageList(pageNum,AllList,10);
			
			Iterator iter=list.iterator();
			while(iter.hasNext()){
				studyNoteDTO dto=(studyNoteDTO)iter.next();
				dto.setMain_lec_subject((String)sqlMap.queryForObject("NoteListSubject", dto.getMain_lec_code()));
			}
			
       		request.setAttribute("pageSize",page.size());
       		request.setAttribute("currentPage",page.current());
       		request.setAttribute("count", page.count());		
			request.setAttribute("list", list);
			content = "user_noteList.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/user/studyGroupList.mooc")
	//스터디그룹
		public String studyGroupList(HttpServletRequest request){
			content = "user_studyGroupList.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/user/likeLectureList.mooc")
	//관심강의
		public String likeLectureList_main(HttpServletRequest request){
			HttpSession session=request.getSession();
			String u_id=(String)session.getAttribute("memId");
			String pageNum=request.getParameter("pageNum");
			List AllList=sqlMap.queryForList("likeLectureList",u_id);
			paging=new pageAction();
			List list=paging.pageList(pageNum, AllList,10);
			request.setAttribute("pageSize",paging.size());
       		request.setAttribute("currentPage",paging.current());
       		request.setAttribute("count", paging.count());		
			request.setAttribute("list", list);
			
			content = "user_likeLectureList.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/user/likeTeacherList.mooc")
	//관심강사
		public String likeTeacherList_main(HttpServletRequest request){
			HttpSession session=request.getSession();
			String u_id=(String)session.getAttribute("memId");
			String pageNum=request.getParameter("pageNum");
			List AllList=sqlMap.queryForList("likeTeacherList",u_id);
			paging=new pageAction();
			List list=paging.pageList(pageNum, AllList,10);
			request.setAttribute("pageSize",paging.size());
			request.setAttribute("currentPage",paging.current());
			request.setAttribute("count", paging.count());		
			request.setAttribute("list", list);
			
			content = "user_likeTeacherList.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/user/likeTeacherList_Ajax.mooc")
	//관심강사
		public String likeTeacherList_Ajax(HttpServletRequest request){
		
			String t_id=request.getParameter("t_id");
			List AllList=sqlMap.queryForList("TeacherLecList",t_id);
			LectureDTO dto=(LectureDTO)AllList.get(0);
			
			request.setAttribute("list", AllList);
			return "/user/myStudy/user_likeTeacherListAjax.jsp";
		}
	
	
	
	
	
	
	@RequestMapping("/user/teacherSign.mooc")
	//강사되기 
		public String teacherSign_main(HttpServletRequest request){
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			int check=0;
			if((Integer)sqlMap.queryForObject("checkT_idflag", id)!=null)
				check=(Integer)sqlMap.queryForObject("checkT_idflag", id);

			request.setAttribute("check", check);
			String content = "/WEB-INF/view/teacher/teacher_sign.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	
	
	
	
	
	
	
	@RequestMapping("/user/myStudyWrite.mooc")
	//스터디 만들기
		public String studyWrite_main(HttpServletRequest request){
		List ctglist =sqlMap.queryForList("selectAllTopCtg",null);
		request.setAttribute("list",ctglist);
		
			content = "/WEB-INF/view/community/commu_studyWrite.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/user/userDelete.mooc")
	//회원탈퇴 
		public String userDelete_main(HttpServletRequest request){
			content = "/WEB-INF/view/user/user_delete.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}

	//----------------------------myStudy 끝----------------------------//
}

