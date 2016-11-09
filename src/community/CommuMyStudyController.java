package community;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import _dto.StudygroupBoardDTO;

@Controller
public class CommuMyStudyController {
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	String main = "/community/_commu_main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	String commu_main = "myStudyRoom/_commu_myStudyRoom_main.jsp";
	
	
/*나의 스터디 목록 메뉴 클릭시 */
	
	@RequestMapping("/study/myStudyRoomMain.mooc")
	//나의 스터디룸 메인
		public String myStudyRoomMain_main(HttpServletRequest request, int stg_code){
			HttpSession session = request.getSession();
			String u_id=(String) session.getAttribute("memId");
			session.setAttribute("code", stg_code);
			
			List stgMemberList = sqlMap.queryForList("stgMemberList", stg_code);	
			List stgList = sqlMap.queryForList("selectstg", stg_code);	
		
			content = "_commu_myStudyRoom_container.jsp";
			
			request.setAttribute("stgMemberList", stgMemberList);
			request.setAttribute("stgList", stgList);
			request.setAttribute("u_id", u_id);
			request.setAttribute("stg_code", stg_code);
			request.setAttribute("community_main_content", commu_main);
			request.setAttribute("commu_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("study/myStudyList.mooc")
	//나의 스터디 목록 리스트
		public String myStudyList_main(HttpServletRequest request){
			HttpSession session=request.getSession();
			String u_id=(String) session.getAttribute("memId");
			List mystudylist;
			if (request.getParameter("state")!=null){	
				mystudylist = sqlMap.queryForList("myselectlist1", u_id);	
			}else{	
				mystudylist = sqlMap.queryForList("myselectlist", u_id);  
			}
			request.setAttribute("list", mystudylist);
			
			content = "commu_myStudyList.jsp";
			request.setAttribute("community_main_content", content);
			return main;
		}
	
	@RequestMapping("/study/myStudyBoardList.mooc")
	//스터디 게시판
		public String myStudyBoardList_main(HttpServletRequest request,StudygroupBoardDTO sgbdto ){
			HttpSession session = request.getSession();
			int stg_code = (int) session.getAttribute("code");
			  sgbdto.setStg_code(stg_code); 
			  if(sgbdto.getSearchBType()==null){ sgbdto.setSearchBType("0");}
			  List list =sqlMap.queryForList("stgboardAll",sgbdto );
		      request.setAttribute("list",list);
		   
			content = "board/commu_studyBoardList.jsp";
			
			request.setAttribute("stg_code", stg_code);
			request.setAttribute("community_main_content", commu_main);
			request.setAttribute("commu_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/study/myStudyMeetingRoom.mooc")
	//스터디 회의방
		public String myStudyMeetingRoom_main(HttpServletRequest request){
		 
			HttpSession session = request.getSession();
			int stg_code = (int) session.getAttribute("code");
			content = "commu_studyMeetingRoom.jsp";
			
			request.setAttribute("stg_code", stg_code);
			request.setAttribute("community_main_content", commu_main);
			request.setAttribute("commu_myStudy_content", content);
			
			return main;
		}
}