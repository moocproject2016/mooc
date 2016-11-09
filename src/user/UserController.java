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
import _dto.LectureDTO;
import _dto.LectureNote;
import _dto.LectureQuestionDTO;
import _dto.memberDTO;
import _dto.pageAction;

@Controller
public class UserController {
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	String main = "main.jsp";
	String content; 
	String myStudy_main = "user/myStudy/_user_myStudy_main.jsp"; 
	
	
	@RequestMapping("user/userProfile.mooc")

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
			
			return "redirect:/main.mooc"; 
		}
	
	@RequestMapping("user/user_delete.mooc")
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
	public String user_finePw_main(HttpServletRequest request)
	{	
		content="user/user_finePw.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	@RequestMapping("user/user_lectureList.mooc")
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
	public String lectureListSerch_main(HttpServletRequest request,LectureDTO dto){
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
		dto.setT_id(id);
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
	
	@RequestMapping("user/loginError.mooc")
	public String user_loginError(){
		return "/user/user_loginError.jsp";
	}
	@RequestMapping("user/user_image.mooc")
	public String user_image(HttpServletRequest request){
		String realpath=request.getRealPath("files");
		String sub_lec_code=request.getParameter("sub_lec_code");
		String pageNum=request.getParameter("pageNum");
		String notepath=null;
		String canvasString=null;
		LectureNote ppt_note=null;
		int pageSize=0;
		if(pageNum==null){
			pageNum="1";
		}
		
		if(sub_lec_code!=null){
			LectureNote note=(LectureNote)sqlMap.queryForObject("notePath",Integer.parseInt(sub_lec_code));
			ppt_note=(LectureNote)sqlMap.queryForObject("noteImageData",Integer.parseInt(sub_lec_code));
			if(note!=null&&ppt_note==null){
				String real[]=realpath.split("mooc");
				notepath=real[0]+"mooc\\files"+note.getLec_data_path();
				System.out.println(notepath);
				PPTChange ppt=new PPTChange(notepath,realpath+"\\user\\");
				try {
					pageSize=ppt.convter(""+note.getSub_lec_code());
					note.setPage_size(pageSize);
					sqlMap.insert("Image_insert", note);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		if(ppt_note!=null){
			HttpSession session=request.getSession();
			String id=(String)session.getAttribute("memId");
			HashMap map=new HashMap();
			map.put("sub_lec_code", sub_lec_code);
			map.put("pageNum", pageNum);
			map.put("id",id);
			pageSize=ppt_note.getPage_size();
			canvasString=(String)sqlMap.queryForObject("selectNote",map);
		}
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("canvasString", canvasString);
		request.setAttribute("sub_lec_code",sub_lec_code);
		request.setAttribute("fileS","/mooc/files/user/Lecture"+sub_lec_code+"_"+pageNum+".png");
		return "user/user_image.jsp";
	}
	
	
	@RequestMapping("user/user_imageSave.mooc")
	public String user_imageSave(HttpServletRequest request){
		String canvas=request.getParameter("canvas");
		String type=request.getParameter("type");
		String sub_lec_code=request.getParameter("sub_lec_code");
		String pageNum=request.getParameter("pageNum");
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("memId");
		HashMap map=new HashMap();
		map.put("canvas", canvas);
		map.put("type", type);
		map.put("sub_lec_code", sub_lec_code);
		map.put("pageNum", pageNum);
		map.put("id",id);
		String canvasData=(String)sqlMap.queryForObject("selectNote",map);
		if(canvasData==null){
			sqlMap.insert("noteinsert",map);
		}else{
			sqlMap.update("noteUpdate",map);
		}
	return "user/user_image.jsp";
	}
	@RequestMapping("user/new_alram.mooc")
	public String test_main(HttpServletRequest request, HttpSession session){
		String id = (String)session.getAttribute("memId");
		int first_count = (Integer)session.getAttribute("first_count");
		int c_notice = (Integer)sqlMap.queryForObject("count_notice1", null);
		int c_lec_notice = (Integer)sqlMap.queryForObject("count_lec_notice2", null);
		int like_lec_list = (Integer)sqlMap.queryForObject("like_lec_list3", id);
		int c_lec_review = (Integer)sqlMap.queryForObject("count_lec_review4", null);
		int c_lec_question = (Integer)sqlMap.queryForObject("count_lec_question5", null);
		int second_count = c_notice + c_lec_notice + like_lec_list + c_lec_review + c_lec_question;
		session.setAttribute("second_count", second_count);
		session.setAttribute("second_notice", c_notice);
		session.setAttribute("second_c_lec_notice", c_lec_notice);
		session.setAttribute("second_c_lec_review", c_lec_review);
		session.setAttribute("second_c_lec_question", c_lec_question);
		session.setAttribute("second_like_lec_list", like_lec_list);
		if(second_count > first_count){
			int new_alram = 1;
			//session.setAttribute("alram", new_alram);
			request.setAttribute("alram1", new_alram );
			session.setAttribute("alram", new_alram);
		}else{
			int new_alram = 0;
			//session.setAttribute("alram", new_alram);
			request.setAttribute("alram1", new_alram );
			session.setAttribute("alram", new_alram);
		}
		return "headAjax.jsp";
	}
	@RequestMapping("user/AlramPage.mooc")
	public String AlramPage_main(HttpServletRequest request, HttpSession session, LectureQuestionDTO dto){
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


		
					
		content = "user/myStudy/user_alramPage.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
}


