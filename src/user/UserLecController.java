package user;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import _dto.LecNoticeDTO;
import _dto.LectureDTO;
import _dto.LectureQuestionDTO;
import _dto.LectureReviewDTO;
import _dto.TeacherDTO;
import _dto.UserDTO;
import _dto.pageAction;

@Controller
public class UserLecController {
	String main = "main.jsp";
	String content; // 占쏙옙 main 占쏙옙占쏙옙占쏙옙占쏙옙 container 占싸분울옙 占쏙옙載� content 占쏙옙占쏙옙
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	@RequestMapping("/viewMainLec.mooc")
	public String viewMainLec_main(HttpServletRequest request, LectureReviewDTO dto){
		int main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));
		LectureDTO main_lec_dto=(LectureDTO) sqlMap.queryForObject("selectOneMainLecture", main_lec_code);
		List sub_lec_list=sqlMap.queryForList("selectAllSubLectureForMain", main_lec_dto);
		
		String id = main_lec_dto.getT_id();
		TeacherDTO main_lec_code_tInfo=(TeacherDTO) sqlMap.queryForObject("t_idfrofile", id);
		
		int sub_lec_count=sub_lec_list.size();
		
		String t_id = request.getParameter("t_id");
		request.setAttribute("t_id", t_id);
		HashMap a=new HashMap();
		HttpSession session=request.getSession();
		String u_id=(String)session.getAttribute("memId");
		a.put("t_id",main_lec_dto.getT_id());
		a.put("u_id",u_id);
		a.put("main_lec_code",main_lec_code);
		int count=(Integer)sqlMap.queryForObject("checkT_id",a);
		int count1=(Integer)sqlMap.queryForObject("checkMain_lec_code",a);
		int count2=(Integer)sqlMap.queryForObject("checkLecture",a);

		request.setAttribute("count", count);
		request.setAttribute("count1", count1);
		request.setAttribute("count2", count2);
		request.setAttribute("main_lec_code_tInfo", main_lec_code_tInfo);
		request.setAttribute("sub_lec_list", sub_lec_list);
		request.setAttribute("main_lec_dto", main_lec_dto);
		request.setAttribute("sub_lec_count", sub_lec_count);
		if((String)session.getAttribute("memId") != null){
		UserDTO check = (UserDTO)sqlMap.queryForObject("selectUser", u_id);
		int u_type = check.getU_type();
		request.setAttribute("u_type", u_type);
		}
		
		List mainLecReviewList = (ArrayList)sqlMap.queryForList("view_review", main_lec_code);
		String pageNum=request.getParameter("pageNum");
		pageAction pageing=new pageAction();
		List view_review = pageing.pageList(pageNum,mainLecReviewList, 7);
		
		List All=sqlMap.queryForList("user_noticeListImportant",Integer.parseInt(request.getParameter("main_lec_code")));
		pageAction noticePageing=new pageAction();
		List lecNoticeList=noticePageing.pageList("1",All, 5);
		
		request.setAttribute("lecNoticeList",lecNoticeList);
		request.setAttribute("lecNoticeListCount",lecNoticeList.size());
		request.setAttribute("reviewCheck",mainLecReviewList.size());
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("view_review", view_review);
		
		content="user/lecture/user_viewMainLecture.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	@RequestMapping("/watchLec.mooc")
	public String watchLec_main(HttpServletRequest request,int sub_lec_code,String currentPage){
		LectureDTO sub_lec_dto=(LectureDTO) sqlMap.queryForObject("selectOneSubLecture", sub_lec_code);
		
		//占쌘뤄옙 占쏙옙占쏙옙트 占쏙옙占쏙옙占쏙옙占쏙옙
		List lec_data_list=sqlMap.queryForList("selectAllLecData", sub_lec_code);
		
		request.setAttribute("sub_lec_dto", sub_lec_dto);
		request.setAttribute("lec_data_list", lec_data_list);
		request.setAttribute("beforePage", currentPage);
		
		return "user/lecture/user_watchRecord.jsp";
	}
	
	@RequestMapping("/report.mooc")
	public String watchLec_main(HttpServletRequest request){
		System.out.println("test");
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("memId");
		
		String t_id=request.getParameter("t_id");
		String main_lec_code=request.getParameter("main_lec_code");
		String sub_lec_code=request.getParameter("sub_lec_code");
		HashMap	map=new HashMap();
		map.put("t_id", t_id);
		map.put("main_lec_code", main_lec_code);
		map.put("sub_lec_code", sub_lec_code);
		map.put("u_id",id);
		int check=(Integer)sqlMap.queryForObject("reportCheck",map);
		if(check==0){
		sqlMap.insert("report", map);
		}
		request.setAttribute("check", check);
		return "/user/user_signAjax.jsp";
	}
	@RequestMapping("user/user_viewQna.mooc")
	public String userViewQna_main(HttpServletRequest request, HttpSession session){
		
		String pageNum=request.getParameter("pageNum");
		List AllList=(ArrayList)sqlMap.queryForList("view_question", null);
		pageAction pageing=new pageAction();
		List view_question = pageing.pageList(pageNum,AllList, 7);
		
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("view_question", view_question);
		content = "user/myStudy/user_viewQnA.jsp";
		
		request.setAttribute("main_content", content);
		
		return main;
	}
	@RequestMapping("user/user_viewReview.mooc")
	//강의 후기
	public String userViewReview_main(HttpServletRequest request, HttpSession session, int main_lec_code){
		
		List AllList = (ArrayList)sqlMap.queryForList("view_review", main_lec_code);
		String pageNum=request.getParameter("pageNum");
		pageAction pageing=new pageAction();
		List view_review = pageing.pageList(pageNum,AllList, 7);
		
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("view_review", view_review);
		content = "user/myStudy/user_viewLecReview.jsp";
		
		request.setAttribute("main_content", content);
		
		return main;
	}
	@RequestMapping("user/user_reviewContent.mooc")
	public String user_ReviewContent_main(HttpServletRequest request){
		
		int view_code = Integer.parseInt(request.getParameter("main_lec_code"));
		String view_subject = request.getParameter("main_lec_subject");
		request.setAttribute("view_code", view_code);
		request.setAttribute("view_subject", view_subject);
		content = "user/myStudy/user_viewLec_reviewContent.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	@RequestMapping("user/user_reviewInsert.mooc")
	public String user_reviewInsert_main(HttpServletRequest request, HttpSession session, LectureReviewDTO dto){
		
		String a1 = request.getParameter("a"); int a = Integer.parseInt(a1);
		System.out.println(a);
		String b1 = request.getParameter("b"); int b = Integer.parseInt(b1);
		String c1 = request.getParameter("c"); int c = Integer.parseInt(c1);
		String d1 = request.getParameter("d"); int d = Integer.parseInt(d1);
		String e1 = request.getParameter("e"); int e = Integer.parseInt(e1);
		String f1 = request.getParameter("f"); int f = Integer.parseInt(f1);
		String g1 = request.getParameter("g"); int g = Integer.parseInt(g1);
		String h1 = request.getParameter("h"); int h = Integer.parseInt(h1);
		String content1 = request.getParameter("content1");
		String view_subject = (String)request.getParameter("view_subject");
		int main_lec_code = Integer.parseInt((String)request.getParameter("main_code"));
		float point = (float)(a+b+c+d+e+f+g+h)/8;
		String id1 = (String)session.getAttribute("memId");
		dto.setLec_r_score(point);
		dto.setU_id(id1);
		dto.setLec_r_content(content1);
		dto.setMain_lec_code(main_lec_code);
		dto.setLec_r_subject(view_subject);
		sqlMap.insert("reviewInsert", dto);
	
		//content="user/lecture/user_viewMainLecture.jsp"; 
		//request.setAttribute("main_content", content);
		return "redirect:/viewMainLec.mooc?main_lec_code="+main_lec_code;
		
	}
	@RequestMapping("user/user_qnaWrite.mooc")
	public String user_qnaWrite_main(HttpServletRequest request, HttpSession session){
		
		int q_code = Integer.parseInt((String)request.getParameter("q_code"));
		request.setAttribute("q1_code", q_code);
		String mem_id = (String)session.getAttribute("memId");
		content="user/myStudy/center_qnaWrite.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	@RequestMapping("user/user_qnaWritePro.mooc")
	public String user_qnaWritePro_main(HttpServletRequest request, LectureQuestionDTO q_dto){
		String id = request.getParameter("u_id");
		int q1_code = Integer.parseInt((String)request.getParameter("main_lec_code"));
		sqlMap.insert("insertQnA", q_dto);
		return "redirect:/viewMainLec.mooc?main_lec_code="+q1_code; //占쌀뀐옙 CODE 占쌨아와쇽옙 REDIRECT 占쏙옙키占쏙옙, 占쏙옙占쏙옙트 占쌨아와쇽옙 占썰변占쏙옙�깍옙占쏙옙 占싹깍옙(占싱곤옙 占쏙옙트占싼뤄옙 占쏙옙占쏙옙占쌉쏙옙占쏙옙 占쏙옙占싸몌옙占쏙옙底�  占쏙옙占쏙옙占쌉쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占신기서 占쏙옙占쌨아쇽옙 占싼몌옙占쏙옙
	}
	
	@RequestMapping("user/user_viewQnaList.mooc")
		public String main_main(HttpServletRequest request, LectureQuestionDTO qna_dto, UserDTO user_dto, HttpSession session){
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null)
			{
				pageNum="1";
			}
			List array=(List)sqlMap.queryForList("qnalist2", qna_dto);
			int pageSize = 10;//占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙
	        int currentPage = Integer.parseInt(pageNum);
	        int startRow = (currentPage - 1) * pageSize ;//占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쌜깍옙 占쏙옙호
	        int endRow = currentPage * pageSize-1;//占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌜뱄옙호
	        int count = array.size();
	        if(count<endRow){
	        	endRow=count;
	        }
	        
	       List<LectureQuestionDTO> list=new ArrayList<LectureQuestionDTO>(endRow-startRow);
	       if (count > 0) {
	        	while(endRow>startRow)
	        	{
	        		
	        		LectureQuestionDTO qna=(LectureQuestionDTO)array.get(startRow);
	        		list.add(qna);
	        		startRow++;
	        	}
	       }
	       if(count>endRow){
	    	   LectureQuestionDTO qna=(LectureQuestionDTO)array.get(startRow);
	    	   list.add(qna);
	       }
       	request.setAttribute("pageSize",pageSize);
       	request.setAttribute("currentPage",currentPage);
       	request.setAttribute("count", count);
		request.setAttribute("list1", list);
		int main_lec_code = Integer.parseInt(request.getParameter("main_lec_code"));
		request.setAttribute("main_lec_code", main_lec_code);
		String id = (String)session.getAttribute("memId");
		UserDTO check = (UserDTO)sqlMap.queryForObject("selectUser", id);
		int u_type = check.getU_type();
		request.setAttribute("u_type", u_type);
		
		content = "user/myStudy/user_viewQnaList.jsp";
		request.setAttribute("main_content", content);
		return main;	
	
	}
	@RequestMapping("user/view_ReContent.mooc")
	public String qnamodify_main(HttpServletRequest request, LectureQuestionDTO q_dto, HttpSession session){
		
		
		int number = Integer.parseInt(request.getParameter("main_code"));
		sqlMap.update("view_ReContent", q_dto);
		//content = "user/myStudy/user_viewQnaList.jsp";
		//request.setAttribute("main_content", content);
		//return main;
		return "redirect:/viewMainLec.mooc?main_lec_code="+number;
	}
	@RequestMapping("user/user_notice.mooc")
	public String user_notice_main(HttpServletRequest request){
		
		List All=sqlMap.queryForList("user_noticeListImportant",Integer.parseInt(request.getParameter("main_lec_code")));
		pageAction pageing=new pageAction();
		List list_1=pageing.pageList("1",All, 3);
		
		String pageNum=request.getParameter("pageNum");
		if(pageNum==null){
			pageNum="1";
		}
		
		HashMap map=new HashMap();
		String searchKey=request.getParameter("searchKey");
		map.put("main_lec_code",Integer.parseInt(request.getParameter("main_lec_code")));
		List Alllist=null;
		if(searchKey!=null&&!searchKey.equals("����")){
			if(request.getParameter("searchKey").equals("lec_n_subject")){
				map.put("lec_n_subject",request.getParameter("searchValue"));
				System.out.println(request.getParameter("searchValue"));
				Alllist=sqlMap.queryForList("user_noticeListSubject",map);
			}
			if(request.getParameter("searchKey").equals("lec_n_content")){
				map.put("lec_n_content", request.getParameter("searchValue"));
				Alllist=sqlMap.queryForList("user_noticeListContent",map);
			}
		}
		if(searchKey==null){
			map.put("main_lec_code", Integer.parseInt(request.getParameter("main_lec_code")));
			Alllist=sqlMap.queryForList("user_noticeList",map);
		}
		int all_count=Alllist.size();
		List list=pageing.pageList(pageNum,Alllist, 7);		
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("list", list);
		request.setAttribute("list_1", list_1);
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("all_count", all_count);
		request.setAttribute("main_lec_code", request.getParameter("main_lec_code"));

		content = "user/lecture/user_notice.jsp";
		request.setAttribute("main_content", content);
		return main;	
	}
	@RequestMapping("user/user_noticeView.mooc")
	public String user_noticeView_main(HttpServletRequest request){
		String pageNum="1";
		if(request.getParameter("pageNum")!=null){  System.out.println("null����"); pageNum=request.getParameter("pageNum");}
		
		int lec_n_num=0;
		if(request.getParameter("lec_n_num")!=null){
			lec_n_num=Integer.parseInt(request.getParameter("lec_n_num"));
		}else{
			lec_n_num=(int) request.getAttribute("lec_n_num");
		}
		LecNoticeDTO lecNotice_dto=(LecNoticeDTO) sqlMap.queryForObject("selectOneLecNotice", lec_n_num);
		
		request.setAttribute("lecNotice_dto", lecNotice_dto);
		request.setAttribute("pageNum", pageNum);
		
		request.setAttribute("check", request.getParameter("check"));
		content = "user/lecture/user_noticeView.jsp";
		request.setAttribute("main_content", content);
		return main;	
	}
	
	
}
	



