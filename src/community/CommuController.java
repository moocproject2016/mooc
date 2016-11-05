package community;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import _dto.StudygroupDTO;
import _dto.pageAction;

@Controller
public class CommuController {
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	String main = "/community/_commu_main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	String commu_main = "myStudyRoom/_commu_myStudyRoom_main.jsp";
	
	@RequestMapping("/community.mooc")
	//myStudy 메인
		public String community_main(HttpServletRequest request){
			content = "_commu_main_container.jsp";
			request.setAttribute("community_main_content", content);
			return main;
		}
	
	/*스터디 채널 메뉴 클릭시 */
	
	@RequestMapping("study/studylist.mooc")
	//채널 스터디 리스트
		public String studylist_main(HttpServletRequest request,StudygroupDTO stgDto){
			int sub_ctg_code=Integer.parseInt(request.getParameter("sub_ctg_code"));
			String sub_ctg_name	= (String) sqlMap.queryForObject("selectSubCtgName",sub_ctg_code); 
			List stdlist = sqlMap.queryForList("selectlist", stgDto); //카테고리코드 넘겨주기
	
			//페이징
			String pageNum="1";
			if(request.getParameter("pageNum")!=null){  pageNum=request.getParameter("pageNum");}
			pageAction pageing=new pageAction();
			List list=pageing.pageList(pageNum,stdlist, 10);
			request.setAttribute("count",pageing.count());
			request.setAttribute("currentPage", pageing.current());
			request.setAttribute("pageSize", pageing.size());
			
			request.setAttribute("name", sub_ctg_name);
			request.setAttribute("list",list);
			request.setAttribute("sub_ctg_code",sub_ctg_code);
			
			content = "commu_studyList.jsp";
			request.setAttribute("community_main_content", content);
			return main;
		}
	
	
	/*스터디 만들기 메뉴 클릭시 */
	
	@RequestMapping("study/StudyWrite.mooc")
	//스터디 방 만들기
		public String StudyWrite_main(HttpServletRequest request){
			List ctglist =sqlMap.queryForList("selectAllTopCtg",null);
			request.setAttribute("list",ctglist);
			
			content = "commu_studyWrite.jsp";
			request.setAttribute("community_main_content", content);
			return main;
		}
	
	@RequestMapping("study/myStudyWritePro.mooc")
	//스터디 방만들기 프로 
		public String writePro(HttpServletRequest request, StudygroupDTO stgDto){
			String sub_ctg_name=stgDto.getSub_ctg_name();
			System.out.println(sub_ctg_name);
			int sub_ctg_code=(int) sqlMap.queryForObject("selectSubCtgCode", sub_ctg_name);
			stgDto.setSub_ctg_code(sub_ctg_code);
			
			HttpSession session=request.getSession();
			String u_id=(String) session.getAttribute("memId");
			stgDto.setU_id(u_id);
			sqlMap.insert("insertStg",stgDto);
			int stg_code=(int) sqlMap.queryForObject("SelectStgl", null); // 민정이가 한거
			stgDto.setStg_code(stg_code);
			sqlMap.insert("InsertStgl", stgDto);
			
			return "redirect:/study/myStudyList.mooc";
		}
	
	@RequestMapping("study/studyModify.mooc")
	//스터디 방 수정
		public String studyModify_main(HttpServletRequest request, int stg_code){
		 	//HttpSession session = request.getSession();  //임의 세션 떄문에  이런식 나중에 바꾸기
		 	//String id = session.getAttribute("memId"); 
		
			StudygroupDTO dto =(StudygroupDTO)sqlMap.queryForObject("selectstg",stg_code);
			request.setAttribute("dto", dto);

			content = "commu_studyModify.jsp";
			request.setAttribute("community_main_content", content);
			request.setAttribute("stg_code", stg_code);
			return main;
		}
	
	@RequestMapping("study/myStudymodifyPro.mooc")
	//스터디 방 수정 프로
		public String modifyPro_main(HttpServletRequest request, StudygroupDTO stgDto){
			sqlMap.update("updatestg", stgDto);
			request.setAttribute("community_main_content", content);
			return "redirect:/study/myStudyList.mooc";
	}
	
	@RequestMapping("study/studyJoin.mooc")
	//스터디 가입하기
		public String studyJoin(HttpServletRequest request,StudygroupDTO stgDto){
			HttpSession session=request.getSession();
			String u_id=(String) session.getAttribute("memId");
			stgDto.setU_id(u_id);
			sqlMap.insert("insertJoin", stgDto);
			int sub_ctg_code=Integer.parseInt(request.getParameter("sub_ctg_code"));
			return "redirect:studylist.mooc?sub_ctg_code="+sub_ctg_code;
		}
	
	@RequestMapping("study/myStudydelete.mooc")
	//스터디 탈퇴
		public String myStudydelete(HttpServletRequest request, StudygroupDTO stgDto){
			HttpSession session=request.getSession();
			String u_id=(String) session.getAttribute("memId");
			stgDto.setU_id(u_id);
			
			sqlMap.delete("mydeletelist",stgDto);
			return "redirect:myStudyList.mooc";
		}
}