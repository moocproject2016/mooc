package user;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import _dto.TeacherDTO;
import _dto.mainlectureDTO;
import _dto.memberDTO;
import _dto.pageAction;

@Controller
public class UserController {
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	String main = "main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	String myStudy_main = "user/myStudy/_user_myStudy_main.jsp"; //myStudy의 main페이지
	
	@RequestMapping("/main.mooc")
	//user 메인 페이지 
		public String _main(HttpServletRequest request){
		
		List main_liveLecture_List = null;
		List main_bestLecture_List = null;
		List main_popularLectureList = null;
		
		main_liveLecture_List = sqlMap.queryForList("main_liveLecture_List", null); //곧 시작하는 실시간 강의
		main_bestLecture_List = sqlMap.queryForList("main_bestLecture_List", null); //베스트 강의 목록 - 강의 평점 총점 기준
		main_popularLectureList = sqlMap.queryForList("main_popularLectureList", null); // 인기 강의 목록 - 수강신청 기준 
		
		request.setAttribute("main_popularLectureList", main_popularLectureList);
		request.setAttribute("main_bestLecture_List", main_bestLecture_List);
		request.setAttribute("main_liveLecture_List", main_liveLecture_List);
		
			content="container.jsp";
			request.setAttribute("main_content", content);
			return main;
		}
	
	@RequestMapping("user/userSign.mooc") 
	//로그인 페이지
	public String user_sign_main(HttpServletRequest request)
	{	
		content = "user/user_sign.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	@RequestMapping("user/loginid.mooc")
	public String loginid(HttpServletRequest request,String id)
	{	
		int check=0;
		check=(Integer)sqlMap.queryForObject("checkid1",id);
		request.setAttribute("check",check);
		return "/user/user_signAjax.jsp";
	}
	
	@RequestMapping("user/loginGoogle.mooc") 
	//구글 로그인
	public String loginGoogle_main(HttpServletRequest request,memberDTO dto)
	{	
		HttpSession session=request.getSession();
		int check=(Integer)sqlMap.queryForObject("checkid1",dto.getU_id()); //해당아이디가 있으면 1 없으면 0
		if(check==1){
			check=(Integer)sqlMap.queryForObject("checkidGoogle",dto.getU_id());
			if(check==0)
			{
				session.setAttribute("memId",dto.getU_id());
				sqlMap.update("access", dto.getU_id());
			}else{
				request.setAttribute("check",check);
				return "/user/user_signAjax.jsp";
			}
		}else{
			sqlMap.insert("memberinsert", dto);
			session.setAttribute("memId",dto.getU_id());
			sqlMap.update("access", dto.getU_id());
		}
		return "redirect:/main.mooc";

	}
	
	
	
	@RequestMapping("user/loginPro.mooc") 
	//로그인 프로
	public String loginPro_main(HttpServletRequest request,memberDTO dto,HttpSession session)
	{
		int check=(Integer)sqlMap.queryForObject("checkid",dto);
		if(check==1)
		{
			session.setAttribute("memId", dto.getU_id());
			sqlMap.update("access", dto.getU_id());
		}else{
			content ="/user/userSign.mooc";
			request.setAttribute("checked1", check);
			request.setAttribute("main_content", content);
			return main;
		}
		return "redirect:/main.mooc";
	}

	@RequestMapping("user/membershipPro.mooc")
	public String membershipPro(memberDTO dto)
	{
		sqlMap.insert("memberinsert", dto);
		return "redirect:/user/userSign.mooc";
	}
	
	@RequestMapping("/logout.mooc")
	//로그아웃
	public String logout_main(HttpServletRequest request,HttpSession session)
	{	
		session.invalidate();
		return "redirect:/main.mooc";

		
	}
	
	@RequestMapping("user/user_categorySearchList.mooc")
	//메인 통합검색 리스트
	public String user_categorySearchList_main(HttpServletRequest request, String mainSearchValue){
		List Allsearch_mainList=null;
		List Allsearch_subList=null;
		List Allsearch_liveList=null;
		Map MSL = new HashMap();
		
		MSL.put("mainSearchValue", mainSearchValue);		
		Allsearch_mainList=(ArrayList)sqlMap.queryForList("main_search_List", MSL); // 메인강의 목록
		Allsearch_subList=(ArrayList)sqlMap.queryForList("sub_search_List", MSL); // 서브강의 목록
		Allsearch_liveList=(ArrayList)sqlMap.queryForList("live_search_List", MSL); // 실시간 가의 목록
		
		if(request.getParameter("popularLikeList")!=null){ //인기 관심 강의 순 정렬
			MSL.put("popularLikeList", request.getParameter("popularLikeList"));
			Allsearch_mainList=(ArrayList)sqlMap.queryForList("main_search_List", MSL);
			Allsearch_subList=(ArrayList)sqlMap.queryForList("sub_search_List", MSL);
			Allsearch_liveList=(ArrayList)sqlMap.queryForList("live_search_List", MSL);
		}
		if(request.getParameter("popularTeacherList")!=null){ //인기 관심 강사 순 정렬
			MSL.put("popularTeacherList", request.getParameter("popularTeacherList"));
			Allsearch_mainList=(ArrayList)sqlMap.queryForList("main_search_List", MSL);
			Allsearch_subList=(ArrayList)sqlMap.queryForList("sub_search_List", MSL);
			Allsearch_liveList=(ArrayList)sqlMap.queryForList("live_search_List", MSL);
		}
		if(request.getParameter("sizeReviewList")!=null){ //강의평 많은 순 정렬
			MSL.put("sizeReviewList", request.getParameter("sizeReviewList"));
			Allsearch_mainList=(ArrayList)sqlMap.queryForList("main_search_List", MSL);
			Allsearch_subList=(ArrayList)sqlMap.queryForList("sub_search_List", MSL);
			Allsearch_liveList=(ArrayList)sqlMap.queryForList("live_search_List", MSL);
		}
		if(request.getParameter("recentlyList")!=null){ //최신 순 정렬
			MSL.put("recentlyList", request.getParameter("recentlyList"));
			Allsearch_mainList=(ArrayList)sqlMap.queryForList("main_search_List", MSL);
			Allsearch_subList=(ArrayList)sqlMap.queryForList("sub_search_List", MSL);
			Allsearch_liveList=(ArrayList)sqlMap.queryForList("live_search_List", MSL);
		}
		
		int mainCount= Allsearch_mainList.size();		
		int subCount= Allsearch_subList.size();	
		int liveCount= Allsearch_liveList.size();
				
		request.setAttribute("mainSearchValue", mainSearchValue);
		
		request.setAttribute("mainSearchList", Allsearch_mainList);
		request.setAttribute("subSearchList", Allsearch_subList);
		request.setAttribute("liveSearchList", Allsearch_liveList);
		
		request.setAttribute("mainCount", mainCount);
		request.setAttribute("subCount", subCount);
		request.setAttribute("liveCount", liveCount);
		
		content="user/user_categorySearchList.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	
	@RequestMapping("user/userProfile.mooc")
	//유저 정보 수정
	public String user_modifyForm_main(HttpServletRequest request)
	{	
		HttpSession session=request.getSession();
		String u_id=(String)session.getAttribute("memId");
		memberDTO dto=(memberDTO)sqlMap.queryForObject("modify",u_id);
		
		request.setAttribute("dto",dto);
		request.setAttribute("u_id",u_id);
		content ="user/user_modify.jsp";
		request.setAttribute("main_content", content);
		return main;
		
	}
	
	@RequestMapping("user/user_modifyPro.mooc")
	public String user_modifyPro_main(HttpServletRequest request,memberDTO dto)
	{	
		HttpSession session=request.getSession();
		String u_id=(String)session.getAttribute("memId");
		dto.setU_id(u_id);
		sqlMap.update("modifyPro",dto);
		
		return "redirect:/main.mooc"; //경로변경
	}
	
	@RequestMapping("user/user_delete.mooc")
	//유저 탈퇴
	public String user_delete(HttpServletRequest request){
		return "/user/user_delete.jsp";
	}
	
	@RequestMapping("user/user_deletePro.mooc")
	public String user_deletePro(HttpServletRequest request,HttpSession session)
	{
		String id=(String)session.getAttribute("memId");
		sqlMap.update("deletePro",id);
		session.invalidate();
		return "redirect:/main.mooc";
	}
	
	@RequestMapping("user/sendEmail.mooc")
	public String sendEmail(HttpServletRequest request,String u_id)
	{	
		int confirm=EmailAuthentication.sendPwdMail(u_id);
		System.out.println(confirm+"...");
		
		Map newPw = new HashMap();
		newPw.put("U_ID", u_id);
		newPw.put("U_PW", confirm);
		
		sqlMap.update("pwdModifyPro", newPw);
		
		request.setAttribute("confirm",new Integer(confirm));
		return "/user/user_signEmailAjax.jsp";
	}
	
	@RequestMapping("user/user_finePw.mooc")
	//유저 비밀번호 찾기
	public String user_finePw_main(HttpServletRequest request)
	{	
		content="user/user_finePw.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	@RequestMapping("user/user_lectureList.mooc")
	//수강 강의 리스트
	public String lectureList_main(HttpServletRequest request){
		String pageNum=request.getParameter("pageNum");
		int sub_ctg_code=Integer.parseInt(request.getParameter("sub_ctg_code"));
		List AllList=(ArrayList)sqlMap.queryForList("sub_ctgList",sub_ctg_code);
		pageAction pageing=new pageAction();
		List list=pageing.pageList(pageNum,AllList, 12);
		String subName=(String)sqlMap.queryForObject("ctg_subject", sub_ctg_code);
		
		request.setAttribute("subName", subName);
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("list", list);
		
		request.setAttribute("sub_ctg_code",sub_ctg_code);
		content="user/user_categoryLectureList.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	@RequestMapping("user/user_lectureListSerch.mooc")
	//강의리스트 검색
	public String lectureListSerch_main(HttpServletRequest request,mainlectureDTO dto){
		String pageNum=request.getParameter("pageNum");
		List AllList=null;
		if(dto.getMain_lec_subject()!=null){
			 AllList=(ArrayList)sqlMap.queryForList("sub_ctgSubjectList",dto);
		}else if(dto.getT_id()!=null){;
			 AllList=(ArrayList)sqlMap.queryForList("sub_ctgIdList",dto);
		}		
		String subName=(String)sqlMap.queryForObject("ctg_subject", dto.getSub_ctg_code());
		
		
		pageAction pageing=new pageAction();
		List list=pageing.pageList(pageNum,AllList, 12);
		
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("list", list);
		request.setAttribute("subName", subName);
		request.setAttribute("sub_ctg_code",dto.getSub_ctg_code());
		content="user/user_categoryLectureList.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	
	@RequestMapping("user/teacherinfoPro.mooc")
	public String teacherinfoPro(HttpServletRequest request,TeacherDTO dto){
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("memId");

		sqlMap.insert("teacher",dto);
		sqlMap.update("teacherType", id);
		return "redirect:/teacher/myClass.mooc";
	}
	
	@RequestMapping("user/user_writeEditer.mooc")
	public String user_writeEditer_main(HttpServletRequest request,TeacherDTO dto){
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("memId");

		content="user/user_writeEditer.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	//로그인 에러
	@RequestMapping("user/loginError.mooc")
	public String user_loginError(){
		return "/user/user_loginError.jsp";
	}
	
	@RequestMapping("/siteMap.mooc")
	//사이트맵
	public String siteMap_main(HttpServletRequest request){
		content="siteMap.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
}
