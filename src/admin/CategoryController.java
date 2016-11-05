package admin;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import _dto.CtgDTO;

@Controller
public class CategoryController {
	@Autowired
	SqlMapClientTemplate sqlMap; 
	
	List list;
	String main = "/admin/_admin_main.jsp";
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의

	@RequestMapping("/admin/ctgList.mooc")
	//카테고리 관리
		public String adm_ctgList(HttpServletRequest request, String ctg_code, String searchSubName, String searchTopName){
		
			Map map = new HashMap();
		
			if(searchSubName == null){searchSubName = "";}
			if(ctg_code == null){ctg_code = "0";}
				
			map.put("SUB_SEARCH_KEY", searchSubName);
			map.put("CTG_CODE", Integer.parseInt(ctg_code));
				
				if(searchTopName!=null){map.put("TOP_SEARCH_KEY",searchTopName);}
					
				list = sqlMap.queryForList("selectAllCtgList", map);
				
				if(list.size()==0){
					map.remove("TOP_SEARCH_KEY");
					list = sqlMap.queryForList("selectAllCtgList", map);
					String x = "x";
					request.setAttribute("x", x);
					}
				
				if(searchTopName!=null){
					CtgDTO dto = new CtgDTO();
					dto = (CtgDTO) list.get(0);
					request.setAttribute("ctg_code", dto.getTop_ctg_code());
					}
			
				content = "admin_ctgList.jsp";
				List allTopCtg = sqlMap.queryForList("selectAllTopCtg", null); //대분류 리스트
				
				if(ctg_code!=null && searchTopName==null){request.setAttribute("ctg_code", ctg_code);}
				
				request.setAttribute("ctgList", list);
				request.setAttribute("topCtgList", allTopCtg);
				request.setAttribute("admin_main_content", content);
				
				return main;
		}
	
	@RequestMapping("/admin/ctgTopWrite.mooc")
	//대분류 생성
		public String ctgTopWrite(HttpServletRequest request){
			String[] topName = request.getParameterValues("top_ctg_name");
			for(int i=0; i<topName.length; i++){
				if(topName[i]!=""){
					String top = topName[i];
					sqlMap.insert("insertTOP_CATEGORY", top);
				}
			}
			return "redirect:/admin/ctgList.mooc";
		}
	
	@RequestMapping("/admin/ctgSubWrite.mooc")
	//소분류 생성
		public String ctgSubWrite(HttpServletRequest request){
		
			String[] subName = request.getParameterValues("sub_ctg_name");
			int topCode = Integer.parseInt(request.getParameter("top_ctg_code"));
			for(int i=0; i<subName.length; i++){
				if(subName[i]!=""){
					CtgDTO dto = new CtgDTO();
					dto.setSub_ctg_name(subName[i]);
					dto.setTop_ctg_code(topCode);
					sqlMap.insert("insertSUB_CATEGORY", dto);
				}
			}
			return "redirect:/admin/ctgList.mooc";
		}
	
	@RequestMapping("/admin/ctgSubModify.mooc")
	//소분류 이름 수정
		public String ctgSubModify(HttpServletRequest request){
			String[] subCode = request.getParameterValues("sub_ctg_code");
			String[] subName = request.getParameterValues("sub_ctg_name");
			String[] topCode = request.getParameterValues("top_ctg_code");
			
			for(int i=0; i<subCode.length; i++){
				CtgDTO dto = new CtgDTO();
				dto.setSub_ctg_code(Integer.parseInt(subCode[i]));
				dto.setSub_ctg_name(subName[i]);
				dto.setTop_ctg_code(Integer.parseInt(topCode[i]));
				sqlMap.update("updateSUB_CATEGORY", dto);			
			}
			return "redirect:/admin/ctgList.mooc";
		}
	
	@RequestMapping("/admin/ctgDelete.mooc")
	//소분류 일괄 삭제
		public String ctgDelete(HttpServletRequest request){
			String[] subCode = request.getParameterValues("checkbox");
			int subCtg;
			String uri="";
			
			if(subCode!=null){
				for(int i=0; i<subCode.length; i++){
					if(subCode[i]!=null){
					subCtg = Integer.parseInt(subCode[i]);
					sqlMap.update("deleteSUB_CATEGORY", subCtg);
					}
				}
			}
			
			Integer check = Integer.parseInt(request.getParameter("tcheck"));
			
			if (check!=null){
					uri="redirect:/admin/ctgTopPreDelete.mooc?ctg_code="+check;
			}else{
					uri="redirect:/admin/ctgList.mooc";
			}
			return uri;
		}
	
	@RequestMapping("/admin/ctgSubMove.mooc")
	//소분류 대분류 수정
		public String ctgSubMove(HttpServletRequest request, String top_ctg_code){
			String[] subCode = request.getParameterValues("checkbox");
			String uri = "";
			
			for(int i=0; i<subCode.length; i++){
				CtgDTO dto = new CtgDTO();
				dto.setSub_ctg_code(Integer.parseInt(subCode[i]));
				dto.setTop_ctg_code(Integer.parseInt(top_ctg_code));
				sqlMap.update("moveSUB_CATEGORY", dto);			
			}
			Integer check = Integer.parseInt(request.getParameter("tcheck"));
			
			if (check!=null){
					uri="redirect:/admin/ctgTopPreDelete.mooc?ctg_code="+check;
			}else{
					uri="redirect:/admin/ctgList.mooc";
			}
			return uri;
		}
	
	@RequestMapping("/admin/ctgTopModify.mooc")
	//대분류 이름 수정
		public String ctgTopModify(HttpServletRequest request){
			
			String[] topCode = request.getParameterValues("top_ctg_code");
			String[] topName = request.getParameterValues("top_ctg_name");
			
			for(int i=0; i<topCode.length; i++){
				CtgDTO dto = new CtgDTO();
				dto.setTop_ctg_code(Integer.parseInt(topCode[i]));
				dto.setTop_ctg_name(topName[i]);
				sqlMap.update("updateTOP_CATEGORY", dto);			
			}
			return "redirect:/admin/ctgList.mooc";
		}
	
	@RequestMapping("/admin/ctgTopPreDelete.mooc")
	//대분류 삭제 이전 체크
		public String ctgTopPreDelete(HttpServletRequest request, String ctg_code){
			int x = 0;
			String uri = "";
			
			x = (int) sqlMap.queryForObject("countSubCtg", Integer.parseInt(ctg_code));
			
			if(x==0){
				ctgTopDelete(ctg_code);
				uri = "redirect:/admin/ctgList.mooc";
			}else{
				request.setAttribute("subCount", x);
				
				List allTopCtg = sqlMap.queryForList("selectAllTopCtg", null); //대분류 리스트
				request.setAttribute("topCtgList", allTopCtg);
				
				list = sqlMap.queryForList("getSubList", Integer.parseInt(ctg_code));
				request.setAttribute("subCtgList", list);	
				
				request.setAttribute("ctg_code", ctg_code);		
				
				uri = "/admin/admin_ctgMove.jsp";
			}
			return uri;
		}
	
	//대분류 삭제
	public void ctgTopDelete(String ctg_code){
			sqlMap.delete("deleteTOP_CATEGORY", Integer.parseInt(ctg_code));
		}
	
	@RequestMapping("/admin/ctgSubPreDelete.mooc")
	//소분류 삭제 이전 체크 
		public String ctgSubPreDelete(HttpServletRequest request, String ctg_code){
			int x = 0;
			String uri = "";
			
			x = (int) sqlMap.queryForObject("countSubCtg_mainLec", Integer.parseInt(ctg_code));
			
			if(x==0){
				ctgSubDelete(ctg_code);
				uri = "redirect:/admin/ctgList.mooc";
			}else{
				request.setAttribute("sub_MainLec_Count", x);
				
				List allTopCtg = sqlMap.queryForList("selectAllTopCtg", null); //대분류 리스트
				request.setAttribute("topCtgList", allTopCtg);
				
				list = sqlMap.queryForList("getSubCtg_mainLec", Integer.parseInt(ctg_code));
				request.setAttribute("subCtg_mainLecList", list);
				request.setAttribute("ctg_code", ctg_code);		
				
				uri = "/admin/admin_ctgMove.jsp";
			}
			return uri;
		}
	
	//소분류 삭제
		public void ctgSubDelete(String ctg_code){
			sqlMap.delete("deleteSUB_CATEGORY", Integer.parseInt(ctg_code));		
		}
		
	@RequestMapping("/admin/ctgSub_mainLecDelete.mooc")
	//소분류 삭제시 메인 강의 삭제
		public String ctgSub_mainLecDelete(HttpServletRequest request, String main_code, String ctg_code){
			String[] mainCode = request.getParameterValues("checkbox");
			for(int i=0;i<mainCode.length;i++){
				sqlMap.delete("deleteSubCtg_MainLec", Integer.parseInt(mainCode[i]));
			}
			String uri = "redirect:/admin/ctgSubPreDelete.mooc?ctg_code="+ctg_code;
		return uri;
		}
	
	@RequestMapping("/admin/ctgSub_mainLecMove.mooc")
	//메인 강의 소분류 변경
		public String ctgSub_mainLecMove(HttpServletRequest request, String ctg_code, String sub_ctg_name){
			Map map = new HashMap();
			int subCode = (int) sqlMap.queryForObject("selectSubCtgCodeList", sub_ctg_name);
			String[] mainCode = request.getParameterValues("checkbox");
			
			for(int i=0;i<mainCode.length;i++){
				map.put("MAIN_CODE", Integer.parseInt(mainCode[i]));
				map.put("CTG_CODE", subCode);
				sqlMap.update("moveSubCtg_MainLec", map);
			}
			request.setAttribute("ctg_code", Integer.parseInt(ctg_code));
			String uri = "redirect:/admin/ctgSubPreDelete.mooc?ctg_code="+ctg_code;
		return uri;
		}
}