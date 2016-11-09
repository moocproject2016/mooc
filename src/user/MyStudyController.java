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
import _dto.UserDTO;
import _dto.pageAction;
import _dto.studyNoteDTO;

@Controller
public class MyStudyController {
	
	String main = "main.jsp";
	String content; 
	String myStudy_main = "user/myStudy/_user_myStudy_main.jsp"; 
	pageAction paging=null;
	
	@Autowired
	 SqlMapClientTemplate sqlMap;
	
	
	@RequestMapping("/user/myStudy.mooc")
		public String myStudy_main(HttpServletRequest request){

			HttpSession session=request.getSession();
			int second_count = (Integer)session.getAttribute("second_count");
			int first_count = second_count;
			String id = (String)session.getAttribute("memId");
			session.setAttribute("first_count", first_count);
			List lec_q_alram = (ArrayList)sqlMap.queryForList("lec_question11", null);
			request.setAttribute("lec_q_alram", lec_q_alram);
			List notice_alram = (ArrayList)sqlMap.queryForList("notice_alram", null);
			request.setAttribute("notice_alram", notice_alram);
			List lec_notice_alram = (ArrayList)sqlMap.queryForList("lec_notice_alram", null);
			request.setAttribute("lec_notice_alram", lec_notice_alram);
			List lec_review_alram = (ArrayList)sqlMap.queryForList("lec_review_alram", null);
			request.setAttribute("lec_revew_alram", lec_review_alram);
			List like_lec_list = (ArrayList)sqlMap.queryForList("like_lec_list111", id);
			request.setAttribute("like_lec_list", like_lec_list);
			String u_id=(String)session.getAttribute("memId");
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null){pageNum="1";}
			List Alllist=sqlMap.queryForList("user_noticeListAll",u_id);
			pageAction pageing=new pageAction();
			int all_count=Alllist.size();
			List list=pageing.pageList(pageNum,Alllist, 10);		
			request.setAttribute("count",pageing.count());
			request.setAttribute("currentPage", pageing.current());
			request.setAttribute("pageSize", pageing.size());
			request.setAttribute("list", list);
			request.setAttribute("pageNum",pageNum);
			request.setAttribute("all_count", all_count);
			request.setAttribute("check", request.getParameter("check"));
			
			List AllList=(ArrayList)sqlMap.queryForList("lec_question_recent", u_id); 
			_dto.QuestionDTO dto=new _dto.QuestionDTO();
			dto.setU_id(u_id);
			request.setAttribute("lecture_question", AllList);
			
			List AllList2=(ArrayList)sqlMap.queryForList("question", dto);
			request.setAttribute("question", AllList2);
		
			content = "_user_myStudy_container.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
		@RequestMapping("/user/lectureList.mooc")
		public String myLectureList_main(HttpServletRequest request){
			String pageNum=request.getParameter("pageNum");
			String sub_ctg_code=request.getParameter("sub_ctg_code");
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			List AllList=null;
			if(sub_ctg_code==null){
				AllList=sqlMap.queryForList("userlecture",id);
			}else{
				HashMap map=new HashMap();
				map.put("id", id);
				map.put("sub_ctg_code", sub_ctg_code);
				AllList=sqlMap.queryForList("userlectureTo",map);
			}
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
	@RequestMapping("/user/lectureList_sub.mooc")
		public String myLectureList_sub_main(HttpServletRequest request){
			int main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			LectureDTO main_lec_dto=(LectureDTO) sqlMap.queryForObject("selectOneMainLecture", main_lec_code);
			main_lec_dto.setU_id(id);
			List sub_lec_list=sqlMap.queryForList("selectAllSubLectureForMain", main_lec_dto);
			int sub_lec_count=sub_lec_list.size();
			
			request.setAttribute("t_id", main_lec_dto.getT_id());
			HashMap a=new HashMap();
			
			a.put("t_id",main_lec_dto.getT_id());
			a.put("u_id",id);
			a.put("main_lec_code",main_lec_code);
			int count=(Integer)sqlMap.queryForObject("checkT_id",a);
			int count1=(Integer)sqlMap.queryForObject("checkMain_lec_code",a);
			int count2=(Integer)sqlMap.queryForObject("checkLecture",a);
			
			request.setAttribute("count", count);
			request.setAttribute("count1", count1);
			request.setAttribute("count2", count2);
			request.setAttribute("sub_lec_list", sub_lec_list);
			request.setAttribute("main_lec_dto", main_lec_dto);
			request.setAttribute("sub_lec_count", sub_lec_count);
			if((String)session.getAttribute("memId") != null){
			UserDTO check = (UserDTO)sqlMap.queryForObject("selectUser", id);
			int u_type = check.getU_type();
			request.setAttribute("u_type", u_type);
			System.out.println(u_type);
			}
			content = "user_lectureList_sub.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
	}
	@RequestMapping("/user/lectureListCategory.mooc")
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
		public String studyGroupList(HttpServletRequest request){
			content = "user_studyGroupList.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/user/likeLectureList.mooc")
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
		public String likeTeacherList_Ajax(HttpServletRequest request){
		
			String t_id=request.getParameter("t_id");
			List AllList=sqlMap.queryForList("TeacherLecList",t_id);
			LectureDTO dto=(LectureDTO)AllList.get(0);
			
			request.setAttribute("list", AllList);
			return "/user/myStudy/user_likeTeacherListAjax.jsp";
		}
	
	
	
	
	
	
	@RequestMapping("/user/teacherSign.mooc")
		public String teacherSign_main(HttpServletRequest request){
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			int check=3;
			if((Integer)sqlMap.queryForObject("checkT_idflag", id)!=null){
				check=(Integer)sqlMap.queryForObject("checkT_idflag", id);
				if(check==0){
					return "redirect:/teacher/teacherProfile.mooc";
				}
			}

			request.setAttribute("check", check);
			String content = "/WEB-INF/view/teacher/teacher_sign.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	
	
	
	
	
	
	
	@RequestMapping("/user/myStudyWrite.mooc")
		public String studyWrite_main(HttpServletRequest request){
		List ctglist =sqlMap.queryForList("selectAllTopCtg",null);
		request.setAttribute("list",ctglist);
		
			content = "/WEB-INF/view/community/commu_studyWrite.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/user/userDelete.mooc")
		public String userDelete_main(HttpServletRequest request){
			content = "/WEB-INF/view/user/user_delete.jsp";
			request.setAttribute("main_content", myStudy_main);
			request.setAttribute("user_myStudy_content", content);
			return main;
		}

	
}

