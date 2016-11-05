package user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import _dto.ProcessDTO;


@Controller
public class ProcessController {
	@Autowired
	SqlMapClientTemplate sqlMap;
	@RequestMapping("user_progress_ajax.mooc")
	public String process(HttpServletRequest request){
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("memId");
		int main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));
		int sub_lec_code=Integer.parseInt(request.getParameter("sub_lec_code"));
		ProcessDTO processDTO=new ProcessDTO();
		processDTO.setSub_lec_code(sub_lec_code);
		processDTO.setMain_lec_code(main_lec_code);
		processDTO.setU_id(id);
		sqlMap.update("insertSubLecProcess", processDTO);
		return "/mooc/user/lecture/user_watchRecord.jsp";
	}
}
