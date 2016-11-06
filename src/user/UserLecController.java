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
import _dto.LectureDTO;
import _dto.LectureQuestionDTO;
import _dto.LectureReviewDTO;
import _dto.UserDTO;
import _dto.pageAction;

@Controller
public class UserLecController {
	String main = "main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	@RequestMapping("/viewMainLec.mooc")
	public String viewMainLec_main(HttpServletRequest request, LectureReviewDTO dto){
		int main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));
		LectureDTO main_lec_dto=(LectureDTO) sqlMap.queryForObject("selectOneMainLecture", main_lec_code);
		List sub_lec_list=sqlMap.queryForList("selectAllSubLectureForMain", main_lec_dto);
		int sub_lec_count=sub_lec_list.size();
		
		String t_id = request.getParameter("t_id");
		request.setAttribute("t_id", t_id);
		HashMap a=new HashMap();
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("memId");
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
		content="user/lecture/user_viewMainLecture.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	@RequestMapping("/watchLec.mooc")
	public String watchLec_main(HttpServletRequest request,int sub_lec_code,String currentPage){
		LectureDTO sub_lec_dto=(LectureDTO) sqlMap.queryForObject("selectOneSubLecture", sub_lec_code);
		
		//자료 리스트 가져오기
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
	public String userViewReview_main(HttpServletRequest request, HttpSession session){
		
		String subject = (String)request.getParameter("main_lec_subject");
		
		
		List AllList = (ArrayList)sqlMap.queryForList("view_review", subject);
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
		return "redirect:/viewMainLec.mooc?main_lec_code="+q1_code; //할꺼 CODE 받아와서 REDIRECT 시키기, 리스트 받아와서 답변기능까지 하기(이건 컨트롤러 질문게시판 새로만들어서  질문게시판 폼으로 연결 거기서 값받아서 뿌리기
	}
	
	@RequestMapping("user/user_viewQnaList.mooc")
		public String main_main(HttpServletRequest request, LectureQuestionDTO qna_dto, UserDTO user_dto, HttpSession session){
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null)
			{
				pageNum="1";
			}
			List array=(List)sqlMap.queryForList("qnalist2", qna_dto);
			int pageSize = 10;//한 페이지의 글의 개수
	        int currentPage = Integer.parseInt(pageNum);
	        int startRow = (currentPage - 1) * pageSize ;//한 페이지의 시작글 번호
	        int endRow = currentPage * pageSize-1;//한 페이지의 마지막 글번호
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
	
}
	



