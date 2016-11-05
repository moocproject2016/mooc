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
	String content; // �� main �������� container �κп� �� content ����
	String commu_main = "myStudyRoom/_commu_myStudyRoom_main.jsp";
	
	@RequestMapping("/community.mooc")
	//myStudy ����
		public String community_main(HttpServletRequest request){
			content = "_commu_main_container.jsp";
			request.setAttribute("community_main_content", content);
			return main;
		}
	
	/*���͵� ä�� �޴� Ŭ���� */
	
	@RequestMapping("study/studylist.mooc")
	//ä�� ���͵� ����Ʈ
		public String studylist_main(HttpServletRequest request,StudygroupDTO stgDto){
			int sub_ctg_code=Integer.parseInt(request.getParameter("sub_ctg_code"));
			String sub_ctg_name	= (String) sqlMap.queryForObject("selectSubCtgName",sub_ctg_code); 
			List stdlist = sqlMap.queryForList("selectlist", stgDto); //ī�װ��ڵ� �Ѱ��ֱ�
	
			//����¡
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
	
	
	/*���͵� ����� �޴� Ŭ���� */
	
	@RequestMapping("study/StudyWrite.mooc")
	//���͵� �� �����
		public String StudyWrite_main(HttpServletRequest request){
			List ctglist =sqlMap.queryForList("selectAllTopCtg",null);
			request.setAttribute("list",ctglist);
			
			content = "commu_studyWrite.jsp";
			request.setAttribute("community_main_content", content);
			return main;
		}
	
	@RequestMapping("study/myStudyWritePro.mooc")
	//���͵� �游��� ���� 
		public String writePro(HttpServletRequest request, StudygroupDTO stgDto){
			String sub_ctg_name=stgDto.getSub_ctg_name();
			System.out.println(sub_ctg_name);
			int sub_ctg_code=(int) sqlMap.queryForObject("selectSubCtgCode", sub_ctg_name);
			stgDto.setSub_ctg_code(sub_ctg_code);
			
			HttpSession session=request.getSession();
			String u_id=(String) session.getAttribute("memId");
			stgDto.setU_id(u_id);
			sqlMap.insert("insertStg",stgDto);
			int stg_code=(int) sqlMap.queryForObject("SelectStgl", null); // �����̰� �Ѱ�
			stgDto.setStg_code(stg_code);
			sqlMap.insert("InsertStgl", stgDto);
			
			return "redirect:/study/myStudyList.mooc";
		}
	
	@RequestMapping("study/studyModify.mooc")
	//���͵� �� ����
		public String studyModify_main(HttpServletRequest request, int stg_code){
		 	//HttpSession session = request.getSession();  //���� ���� ������  �̷��� ���߿� �ٲٱ�
		 	//String id = session.getAttribute("memId"); 
		
			StudygroupDTO dto =(StudygroupDTO)sqlMap.queryForObject("selectstg",stg_code);
			request.setAttribute("dto", dto);

			content = "commu_studyModify.jsp";
			request.setAttribute("community_main_content", content);
			request.setAttribute("stg_code", stg_code);
			return main;
		}
	
	@RequestMapping("study/myStudymodifyPro.mooc")
	//���͵� �� ���� ����
		public String modifyPro_main(HttpServletRequest request, StudygroupDTO stgDto){
			sqlMap.update("updatestg", stgDto);
			request.setAttribute("community_main_content", content);
			return "redirect:/study/myStudyList.mooc";
	}
	
	@RequestMapping("study/studyJoin.mooc")
	//���͵� �����ϱ�
		public String studyJoin(HttpServletRequest request,StudygroupDTO stgDto){
			HttpSession session=request.getSession();
			String u_id=(String) session.getAttribute("memId");
			stgDto.setU_id(u_id);
			sqlMap.insert("insertJoin", stgDto);
			int sub_ctg_code=Integer.parseInt(request.getParameter("sub_ctg_code"));
			return "redirect:studylist.mooc?sub_ctg_code="+sub_ctg_code;
		}
	
	@RequestMapping("study/myStudydelete.mooc")
	//���͵� Ż��
		public String myStudydelete(HttpServletRequest request, StudygroupDTO stgDto){
			HttpSession session=request.getSession();
			String u_id=(String) session.getAttribute("memId");
			stgDto.setU_id(u_id);
			
			sqlMap.delete("mydeletelist",stgDto);
			return "redirect:myStudyList.mooc";
		}
}