package user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import _dto.QnAListDTO;

@Controller
public class QnAListController {
	String main = "main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	@RequestMapping("/qna.mooc")
		public String qna_main(HttpServletRequest request, QnAListDTO user_qnadto, HttpSession session){
			
			String id = (String)session.getAttribute("memId");
			user_qnadto.setU_id(id);
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null)
			{
				pageNum="1";
			}
			List array=(List)sqlMap.queryForList("user_qnalist", user_qnadto);
			
			
			int pageSize = 10;//한 페이지의 글의 개수
	        int currentPage = Integer.parseInt(pageNum);
	        int startRow = (currentPage - 1) * pageSize ;//한 페이지의 시작글 번호
	        int endRow = currentPage * pageSize-1;//한 페이지의 마지막 글번호
	        int count = array.size();
	        if(count<endRow){
	        	endRow=count;
	        }
	        
	       List<QnAListDTO> list=new ArrayList<QnAListDTO>(endRow-startRow);
	       if (count > 0) {
	        	while(endRow>startRow)
	        	{
	        		
	        		QnAListDTO qna=(QnAListDTO)array.get(startRow);
	        		list.add(qna);
	        		startRow++;
	        	}
	       }
	       if(count>endRow){
	    	   QnAListDTO qna=(QnAListDTO)array.get(startRow);
	    	   list.add(qna);
	       }
		   	request.setAttribute("pageSize",pageSize);
		   	request.setAttribute("currentPage",currentPage);
		   	request.setAttribute("count", count);
			request.setAttribute("list", list);
	
			content="user/center/center_qnaList.jsp";
			request.setAttribute("main_content", content);
			return main;
		}
	
	@RequestMapping("/user/center/center_qnaDeleteForm.mooc")
		public String delete(HttpServletRequest request, int[] num){
		
			String indexList[] = request.getParameter("checkIndex").split(",");
			
			for(int i=0; i < indexList.length; i++){

			sqlMap.delete("user_qnadelete", Integer.parseInt(indexList[i]));
			}
			return "redirect:/qna.mooc";
		}	
	
	@RequestMapping("/user/center/center_qnaWrite.mooc")
		public String write(HttpServletRequest request, HttpSession session){
			String mem_id = (String)session.getAttribute("memId");
		
			content="user/center/center_qnaWrite.jsp";
			request.setAttribute("main_content", content);
			return main;
		}
	
	@RequestMapping("/user/center/center_qnaWritePro.mooc")
	public String writePro(QnAListDTO user_qnadto){
		
		sqlMap.insert("user_qnawrite", user_qnadto);
		return "redirect:/qna.mooc";
	}
}
