package user;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import _dto.LectureReviewDTO;
import _dto.QuestionDTO;
import _dto.pageAction;

@Controller
public class ReviewController {
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	String main = "main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	String myStudy_main = "user/myStudy/_user_myStudy_main.jsp"; //myStudy의 main페이지
	
	@RequestMapping("/user/reviewContent.mooc")
	public String reviewContent(HttpServletRequest request){
		content = "user_reviewContent.jsp";
		request.setAttribute("main_content" , myStudy_main);
		request.setAttribute("user_myStudy_content", content);
		return main;
	}
	
	@RequestMapping("user/review.mooc")
	public String review_main(HttpServletRequest request, HttpSession session, LectureReviewDTO dto){
				
		if(session != null){
		
		String a1 = request.getParameter("a");
		int a = Integer.parseInt(a1);
		System.out.println(a);
		String b1 = request.getParameter("b");
		int b = Integer.parseInt(b1);
		String c1 = request.getParameter("c");
		int c = Integer.parseInt(c1);
		String d1 = request.getParameter("d");
		int d = Integer.parseInt(d1);
		String e1 = request.getParameter("e");
		int e = Integer.parseInt(e1);
		String f1 = request.getParameter("f");
		int f = Integer.parseInt(f1);
		String g1 = request.getParameter("g");
		int g = Integer.parseInt(g1);
		String h1 = request.getParameter("h");
		int h = Integer.parseInt(h1);
		
		String content1 = request.getParameter("content1");
		float point = (float)(a+b+c+d+e+f+g+h)/8;
		dto.setLec_r_score(point);
		dto.setU_id((String)session.getAttribute("memId"));
		dto.setLec_r_content(content1);
		}
		sqlMap.insert("review", dto);
		content = "user_reviewList.jsp";
		request.setAttribute("main_content" , myStudy_main);
		request.setAttribute("user_myStudy_content", content);
		return main;
		
	}
	@RequestMapping("user/reviewList.mooc")
	public String reviewList_main( HttpServletRequest request, LectureReviewDTO dto, HttpSession session){
		
		String id = (String)session.getAttribute("memId");
		
		String pageNum=request.getParameter("pageNum");
		List AllList=(ArrayList)sqlMap.queryForList("myreviewlist",id);
		pageAction pageing=new pageAction();
		List member = pageing.pageList(pageNum,AllList, 10);
	
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("member", member);
		content = "user_reviewList.jsp";
		request.setAttribute("main_content" , myStudy_main);
		request.setAttribute("user_myStudy_content", content);
		return main;
	}
	@RequestMapping("user/myQuestion.mooc")
	public String questionList_main(HttpServletRequest request, HttpSession session, QuestionDTO q_dto){
		
		String id = (String)session.getAttribute("memId");
			
		String pageNum=request.getParameter("pageNum");
		List AllList=(ArrayList)sqlMap.queryForList("question", id);
		pageAction pageing=new pageAction();
		List question=pageing.pageList(pageNum,AllList, 10);
			
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("question", question);
		content = "user_myQuestionList.jsp";
		request.setAttribute("main_content" , myStudy_main);
		request.setAttribute("user_myStudy_content", content);
		return main;
		
	}
	@RequestMapping("user/myLecture_review.mooc")
	public String myLecture_reviewList_main(HttpServletRequest request, HttpSession session){
		
		String id = (String)session.getAttribute("memId");
		String pageNum=request.getParameter("pageNum");
		List AllList=(ArrayList)sqlMap.queryForList("lec_review",id);
		pageAction pageing=new pageAction();
		List lec_review = pageing.pageList(pageNum,AllList, 7);
		
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("lec_review", lec_review);
		
		content = "user_myLec_reviewList.jsp";
		request.setAttribute("main_content" , myStudy_main);
		request.setAttribute("user_myStudy_content", content);
		return main;
	}
	@RequestMapping("user/myStgWriter.mooc")
	public String myStgWriterList_main(HttpServletRequest request, HttpSession session){
		
		String id = (String)session.getAttribute("memId");
		String pageNum=request.getParameter("pageNum");
		List AllList=(ArrayList)sqlMap.queryForList("stg_b", id);
		pageAction pageing=new pageAction();
		List stg_b = pageing.pageList(pageNum,AllList, 7);
		
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("stg_b", stg_b);
		content = "user_myStgList.jsp";
		request.setAttribute("main_content" , myStudy_main);
		request.setAttribute("user_myStudy_content", content);
		return main;
			
	}
	@RequestMapping("user/myLec_questionList.mooc")
	public String myLecQuestionList_main(HttpServletRequest request, HttpSession session){
		
		String id = (String)session.getAttribute("memId");
		String pageNum=request.getParameter("pageNum");
		List AllList=(ArrayList)sqlMap.queryForList("lec_question", id);
		pageAction pageing=new pageAction();
		List lecture_question = pageing.pageList(pageNum,AllList, 7);
		
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("lecture_question", lecture_question);
		content = "user_myLec_QuestionList.jsp";
		request.setAttribute("main_content" , myStudy_main);
		request.setAttribute("user_myStudy_content", content);
		return main;
		}

	
	@RequestMapping("user/myQuestionDelete.mooc")
	public String myQuestionDelete(HttpServletRequest request, int[] q_num, HttpSession session){
	{
	
		String[] index=request.getParameterValues("index");
		String[] index2 = request.getParameterValues("checkbox");
		for(int i=0; i < index.length; i++){
			for(int j=0;j<index2.length;j++){
				if(index[i].equals(index2[j])){
				int num=Integer.parseInt(index[i]);
			sqlMap.delete("qnadelete", q_num[num]);
			}}}
	
		return "redirect:myQuestion.mooc";
	}
		
	}
	@RequestMapping("user/myLec_reviewDelete.mooc")
	public String myLec_reviewDelete(HttpServletRequest request,int[] main_lec_code, HttpSession session){
		
		String[] index = request.getParameterValues("index");
		String[] index2 = request.getParameterValues("checkbox");
		for(int i=0; i < index.length; i++){
			for(int j=0;j<index2.length;j++){
				if(index[i].equals(index2[j])){
				int num = Integer.parseInt(index[i]);
				sqlMap.delete("myreviewdelete", main_lec_code[num]);
				}
		}
		}
		return "redirect:myLecture_review.mooc";
	}
	@RequestMapping("user/myStgDelete.mooc")
	public String myStgDelete(HttpServletRequest request, int[] stg_b_num, HttpSession session){
		
		String[] index = request.getParameterValues("index");
		String[] index2 = request.getParameterValues("checkbox");
		
		for(int i = 0; i < index.length; i++){
			for(int j=0;j<index2.length;j++){
				if(index[i].equals(index2[j])){
					int num = Integer.parseInt(index[i]);
					sqlMap.delete("mystgdelete", stg_b_num[num]);
				}
			}
		}
	
			
		
		return "redirect:myStgWriter.mooc";
	}
	@RequestMapping("user/myLec_questionDelete.mooc")
	public String myLec_questionDelete(HttpServletRequest request, int[] lec_q_num, HttpSession session){
		
		String[] index = request.getParameterValues("index");
		String[] index2 = request.getParameterValues("checkbox");			
		for(int i = 0; i < index.length; i++){
			for(int j=0;j<index2.length;j++){
				if(index[i].equals(index2[j])){
			
			int num = Integer.parseInt(index[i]);
			
			sqlMap.delete("mylec_q_delete", lec_q_num[num]);
				}
			}
		
		}
		return "redirect:myLec_questionList.mooc";
	}
	@RequestMapping("user/Lec_reviewDelete.mooc")
	public String Lec_reviewDelete(HttpServletRequest request,int[] main_lec_code, HttpSession session){
		
		String[] index = request.getParameterValues("index");
		String[] index2 = request.getParameterValues("checkbox");
		for(int i=0; i < index.length; i++){
			for(int j=0;j<index2.length;j++){
				if(index[i].equals(index2[j])){
				int num = Integer.parseInt(index[i]);
				sqlMap.delete("reviewdelete", main_lec_code[num]);
				}
		}
		}
		return "redirect:reviewList.mooc";
	}
		
	
	
}


