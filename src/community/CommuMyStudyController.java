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
	String content; // �� main �������� container �κп� �� content ����
	String commu_main = "myStudyRoom/_commu_myStudyRoom_main.jsp";
	
	
/*���� ���͵� ��� �޴� Ŭ���� */
	
	@RequestMapping("study/myStudyList.mooc")
	//���� ���͵� ��� ����Ʈ
		public String myStudyList_main(HttpServletRequest request){
			HttpSession session=request.getSession();
			String u_id=(String) session.getAttribute("memId");
			List mystudylist = sqlMap.queryForList("myselectlist", u_id); //ī�װ����ڵ� �Ѱ��ֱ�
			
			request.setAttribute("list",mystudylist);
			content = "commu_myStudyList.jsp";
			request.setAttribute("community_main_content", content);
			return main;
		}
	
	@RequestMapping("/study/myStudyRoomMain.mooc")
	//���� ���͵�� ����
		public String myStudyRoomMain_main(HttpServletRequest request, int stg_code){
			HttpSession session = request.getSession();
			session.setAttribute("code", stg_code);
		
			content = "_commu_myStudyRoom_container.jsp";
			
			request.setAttribute("stg_code", stg_code);
			request.setAttribute("community_main_content", commu_main);
			request.setAttribute("commu_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/study/myStudyBoardList.mooc")
	//���͵� �Խ���
		public String myStudyBoardList_main(HttpServletRequest request,StudygroupBoardDTO sgbdto ){
			HttpSession session = request.getSession();
			int stg_code = (int) session.getAttribute("code");
			  sgbdto.setStg_code(stg_code); 
			  System.out.println("stg_code:"+stg_code);
			  System.out.println("SearchBType:"+sgbdto.getSearchBType());
			  if(sgbdto.getSearchBType()==null){ sgbdto.setSearchBType("0");}
			  List list =sqlMap.queryForList("stgboardAll",sgbdto );
		      request.setAttribute("list",list);
		   
			content = "board/commu_studyBoardList.jsp";
			request.setAttribute("community_main_content", commu_main);
			request.setAttribute("commu_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/study/myStudyMeetingRoom.mooc")
	//���͵� ȸ�ǹ�
		public String myStudyMeetingRoom_main(HttpServletRequest request){
		 
			HttpSession session = request.getSession();
			int stg_code = (int) session.getAttribute("code");
			content = "commu_studyMeetingRoom.jsp";
			
			request.setAttribute("stg_code", stg_code);
			request.setAttribute("community_main_content", commu_main);
			request.setAttribute("commu_myStudy_content", content);
			
			return main;
		}
	
	@RequestMapping("/study/myStudyMemberList.mooc")
	//���͵� ��� ���
		public String myStudyMemberList_main(HttpServletRequest request){
		
			HttpSession session = request.getSession();
			int stg_code = (int) session.getAttribute("code");
		   
			content = "commu_studyMemberList.jsp";
			request.setAttribute("community_main_content", commu_main);
			request.setAttribute("commu_myStudy_content", content);
			return main;
		}
}