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
import _dto.memberDTO;
import _dto.pageAction;

@Controller
public class MainController {
	
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
			List main_popularLecture_List = null;
			
			main_liveLecture_List = sqlMap.queryForList("main_liveLecture_List", null); //�� �����ϴ� �ǽð� ����
			main_bestLecture_List = sqlMap.queryForList("main_bestLecture_List", null); //����Ʈ ���� ��� - ���� ���� ���� ����
			main_popularLecture_List = sqlMap.queryForList("main_popularLecture_List", null); // �α� ���� ��� - ������û ���� 
			
			request.setAttribute("main_popularLecture_List", main_popularLecture_List);
			request.setAttribute("main_bestLecture_List", main_bestLecture_List);
			request.setAttribute("main_liveLecture_List", main_liveLecture_List);
			
			content="container.jsp";
			request.setAttribute("main_content", content);
			return main;
		}
	
	@RequestMapping("user/user_mainMoreList.mooc")
	//����  ������ ����Ʈ
	public String user_mainMoreList_main(HttpServletRequest request, String mainSearchValue){
		
		List liveLecture_List = null;
		List bestLecture_List = null;
		List popularLecture_List = null;
		
		liveLecture_List = sqlMap.queryForList("liveLecture_List", null); //�� �����ϴ� �ǽð� ����
		bestLecture_List = sqlMap.queryForList("bestLecture_List", null); //����Ʈ ���� ��� - ���� ���� ���� ����
		popularLecture_List = sqlMap.queryForList("popularLecture_List", null); // �α� ���� ��� - ������û ���� 
		
		request.setAttribute("popularLecture_List", popularLecture_List);
		request.setAttribute("bestLecture_List", bestLecture_List);
		request.setAttribute("liveLecture_List", liveLecture_List);
		
		content="user/user_mainMoreList.jsp";
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
			String name=(String) sqlMap.queryForObject("getU_name", dto.getU_id());
			session.setAttribute("memName", name);
			
		}else{
			content ="/user/userSign.mooc";
			request.setAttribute("checked1", check);
			request.setAttribute("main_content", content);
			return main;
		}
		String id = (String)session.getAttribute("memId");
		session.setAttribute("memId", id);
		int c_notice = (Integer)sqlMap.queryForObject("count_notice", null);
		int c_lec_notice = (Integer)sqlMap.queryForObject("count_lec_notice", null);
		int like_lec_list = (Integer)sqlMap.queryForObject("like_lec_list", id);
		int c_lec_review = (Integer)sqlMap.queryForObject("count_lec_review", null);
		int c_lec_question = (Integer)sqlMap.queryForObject("count_lec_question", null);
		int first_count = c_notice + c_lec_notice + like_lec_list + c_lec_review + c_lec_question;
		session.setAttribute("first_count", first_count);
		session.setAttribute("first_notice", c_notice);
		session.setAttribute("first_c_lec_notice", c_lec_notice);
		session.setAttribute("first_like_lec_list", like_lec_list);
		session.setAttribute("first_c_lec_review", c_lec_review);
		session.setAttribute("first_c_lec_question", c_lec_question);
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
	

	
		
	@RequestMapping("/siteMap.mooc")
	//����Ʈ��
	public String siteMap_main(HttpServletRequest request){
		content="siteMap.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
}
