package user;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import _dto.NoticeDTO;
import _dto.pageAction;

@Controller
public class CenterController{
	String main = "main.jsp";
	String content; // �� main �������� container �κп� �� content ����
	
	@Autowired
	SqlMapClientTemplate sqlMap;

	@RequestMapping("/notice.mooc")
	//�������� ����Ʈ
	public String notice_main(HttpServletRequest request){
		
		List type0=sqlMap.queryForList("type0", null);
		request.setAttribute("type0", type0);
		List type1=sqlMap.queryForList("type1", null);
		request.setAttribute("type1", type1);
		
		String pageNum=request.getParameter("pageNum");
		pageAction pageing=new pageAction();
		List list=pageing.pageList(pageNum, type0, 10);
		
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
				
		content="user/center/center_noticeList.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	@RequestMapping("/noticeContent.mooc")
	public String noticeContent_main(HttpServletRequest request, String pageNum){
		if(request.getParameter("pageNum")==null||request.getParameter("pageNum").equals("")){
			pageNum = "1";
		}
				
		int notice_num=0;
		//writeForm���� �Ѱܹ޾��� ��, setAttribute�� ���ؼ� �Ѿ�Ա� ������ getAttribute("notice_num")!=null�� true�� �ȴ�.
		if(request.getAttribute("notice_num")!=null){
			
			notice_num=(int) request.getAttribute("notice_num");
		//list���� �Ѿ���� ��, /mooc/notice_content.mooc?notice_num=${dto.notice_num}�� ���� �Ѿ���� ������ getParameter("notice_num")!=null�� true�� �ȴ�.
		}else if(request.getParameter("notice_num")!=null){
			
			notice_num=Integer.parseInt(request.getParameter("notice_num"));
		}
		
		NoticeDTO dto=(NoticeDTO)sqlMap.queryForObject("resultNotice", notice_num);
		request.setAttribute("dto", dto);
		request.setAttribute("pageNum", pageNum);
		
		content="user/center/center_noticeContent.jsp";
		request.setAttribute("main_content", content);
		return main;
	}
	
	
	@RequestMapping("/notice_download.mooc")
	public ModelAndView download(HttpServletRequest request, String fileName){
		String realPath=request.getRealPath("files");
		File down=new File(realPath+fileName);
		ModelAndView mv=new ModelAndView("download", "downloadFile", down);
		return mv;
	}
	
}

