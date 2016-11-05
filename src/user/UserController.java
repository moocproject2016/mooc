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
	String content; // �� main �������� container �κп� �� content ����
	String myStudy_main = "user/myStudy/_user_myStudy_main.jsp"; //myStudy�� main������
	
	@RequestMapping("/main.mooc")
	//user ���� ������ 
		public String _main(HttpServletRequest request){
		
		List main_liveLecture_List = null;
		List main_bestLecture_List = null;
		List main_popularLectureList = null;
		
		main_liveLecture_List = sqlMap.queryForList("main_liveLecture_List", null); //�� �����ϴ� �ǽð� ����
		main_bestLecture_List = sqlMap.queryForList("main_bestLecture_List", null); //����Ʈ ���� ��� - ���� ���� ���� ����
		main_popularLectureList = sqlMap.queryForList("main_popularLectureList", null); // �α� ���� ��� - ������û ���� 
		
		request.setAttribute("main_popularLectureList", main_popularLectureList);
		request.setAttribute("main_bestLecture_List", main_bestLecture_List);
		request.setAttribute("main_liveLecture_List", main_liveLecture_List);
		
			content="container.jsp";
			request.setAttribute("main_content", content);
			return main;
		}
	
	@RequestMapping("user/userSign.mooc") 
	//�α��� ������
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
	//���� �α���
	public String loginGoogle_main(HttpServletRequest request,memberDTO dto)
	{	
		HttpSession session=request.getSession();
		int check=(Integer)sqlMap.queryForObject("checkid1",dto.getU_id()); //�ش���̵� ������ 1 ������ 0
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
	//�α��� ����
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
	//�α׾ƿ�
	public String logout_main(HttpServletRequest request,HttpSession session)
	{	
		session.invalidate();
		return "redirect:/main.mooc";

		
	}
	
	@RequestMapping("user/user_categorySearchList.mooc")
	//���� ���հ˻� ����Ʈ
	public String user_categorySearchList_main(HttpServletRequest request, String mainSearchValue){
		List Allsearch_mainList=null;
		List Allsearch_subList=null;
		List Allsearch_liveList=null;
		Map MSL = new HashMap();
		
		MSL.put("mainSearchValue", mainSearchValue);		
		Allsearch_mainList=(ArrayList)sqlMap.queryForList("main_search_List", MSL); // ���ΰ��� ���
		Allsearch_subList=(ArrayList)sqlMap.queryForList("sub_search_List", MSL); // ���갭�� ���
		Allsearch_liveList=(ArrayList)sqlMap.queryForList("live_search_List", MSL); // �ǽð� ���� ���
		
		if(request.getParameter("popularLikeList")!=null){ //�α� ���� ���� �� ����
			MSL.put("popularLikeList", request.getParameter("popularLikeList"));
			Allsearch_mainList=(ArrayList)sqlMap.queryForList("main_search_List", MSL);
			Allsearch_subList=(ArrayList)sqlMap.queryForList("sub_search_List", MSL);
			Allsearch_liveList=(ArrayList)sqlMap.queryForList("live_search_List", MSL);
		}
		if(request.getParameter("popularTeacherList")!=null){ //�α� ���� ���� �� ����
			MSL.put("popularTeacherList", request.getParameter("popularTeacherList"));
			Allsearch_mainList=(ArrayList)sqlMap.queryForList("main_search_List", MSL);
			Allsearch_subList=(ArrayList)sqlMap.queryForList("sub_search_List", MSL);
			Allsearch_liveList=(ArrayList)sqlMap.queryForList("live_search_List", MSL);
		}
		if(request.getParameter("sizeReviewList")!=null){ //������ ���� �� ����
			MSL.put("sizeReviewList", request.getParameter("sizeReviewList"));
			Allsearch_mainList=(ArrayList)sqlMap.queryForList("main_search_List", MSL);
			Allsearch_subList=(ArrayList)sqlMap.queryForList("sub_search_List", MSL);
			Allsearch_liveList=(ArrayList)sqlMap.queryForList("live_search_List", MSL);
		}
		if(request.getParameter("recentlyList")!=null){ //�ֽ� �� ����
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
	//���� ���� ����
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
		
		return "redirect:/main.mooc"; //��κ���
	}
	
	@RequestMapping("user/user_delete.mooc")
	//���� Ż��
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
	//���� ��й�ȣ ã��
	public String user_finePw_main(HttpServletRequest request)
	{	
		content="user/user_finePw.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	@RequestMapping("user/user_lectureList.mooc")
	//���� ���� ����Ʈ
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
	//���Ǹ���Ʈ �˻�
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
	
	//�α��� ����
	@RequestMapping("user/loginError.mooc")
	public String user_loginError(){
		return "/user/user_loginError.jsp";
	}
	
	@RequestMapping("/siteMap.mooc")
	//����Ʈ��
	public String siteMap_main(HttpServletRequest request){
		content="siteMap.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
}
