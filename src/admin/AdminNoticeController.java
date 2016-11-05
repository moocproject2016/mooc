package admin;

import java.io.File;
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
public class AdminNoticeController{
	String main = "/admin/_admin_main.jsp";
	String content; // �� main �������� container �κп� �� content ����
	
	@Autowired
	SqlMapClientTemplate sqlMap;

	@RequestMapping("/admin/noticeList.mooc")
	//�������� ����Ʈ
	public String noticeList_main(HttpServletRequest request){
		
		List type0=sqlMap.queryForList("type0", null);
		request.setAttribute("type0", type0);
		List type1=sqlMap.queryForList("type1", null);
		request.setAttribute("type1", type1);
		
		String pageNum=request.getParameter("pageNum");
		if(pageNum==null || pageNum==""){
			pageNum = "1";
		}
		pageAction pageing=new pageAction();
		List list=pageing.pageList(pageNum, type0, 10);
		
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
				
		content="admin_noticeList.jsp";
		request.setAttribute("admin_main_content", content);
		return main;
	}
	
	@RequestMapping("/admin/noticeContent.mooc")
	//�������� ����
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
		
		content="admin_noticeContent.jsp";
		request.setAttribute("admin_main_content", content);
		return main;
	}
	
	@RequestMapping("/admin/noticeWrite.mooc")
	//�������� �ۼ�
	public String noticeWrite_main(HttpServletRequest request){
		
		content="admin_noticeWrite.jsp";
		request.setAttribute("admin_main_content", content);
		return main;
	}
	
	@RequestMapping("/admin/notice_writePro.mooc")
	//�������� �ۼ� ����
	public String notice_writePro(MultipartHttpServletRequest multi, NoticeDTO dto){
		int notice_num=(int) sqlMap.queryForObject("seqNotice", null);
		notice_num++;
		
		MultipartFile file=multi.getFile("save");
		String realPath=multi.getRealPath("files")+"\\user\\notice_"+notice_num+"_";
		String filename=file.getOriginalFilename();
		File copy=new File(realPath+filename);
		try{
			file.transferTo(copy);
		}catch (Exception e) {e.printStackTrace();}
		dto.setNotice_file("\\user\\notice_"+notice_num+"_"+filename);
		
		sqlMap.insert("insertNotice", dto);
		multi.setAttribute("notice_num",notice_num);
		return "forward:/admin/noticeContent.mooc";
	}
	
	@RequestMapping("/admin/noticeModify.mooc")
	//�������� ����
	public String noticeModify_main(HttpServletRequest request, int notice_num){
		
		NoticeDTO dto=(NoticeDTO)sqlMap.queryForObject("resultNotice", notice_num);
		request.setAttribute("dto", dto);
		
		content="admin_noticeModify.jsp";
		request.setAttribute("admin_main_content", content);
		return main;
	}
	
	@RequestMapping("/admin/noticeModifyPro.mooc")
	//�������� ���� ����
	public String noticeModifyPro_main(MultipartHttpServletRequest multi, NoticeDTO dto){
		
		MultipartFile file=multi.getFile("save");
		String realPath=multi.getRealPath("files")+"\\user\\notice_"+dto.getNotice_num()+"_";
		String filename=file.getOriginalFilename();
		if(!filename.equals("")){//file�� ������ ������.
			File deleteFile=new File(multi.getRealPath("files")+dto.getNotice_file());
			if(deleteFile.exists()){ deleteFile.delete(); }
			File copy=new File(realPath+filename);
			try{
				file.transferTo(copy);
			}catch (Exception e) {e.printStackTrace();}
			dto.setNotice_file("\\user\\notice_"+dto.getNotice_num()+"_"+filename); //DB�� ����Ǵ� ��
		}
		sqlMap.update("updateNotice", dto);
		multi.setAttribute("dto", dto);
		
		content="admin_noticeContent.jsp";
		multi.setAttribute("main_content", content);
		return "forward:/admin/noticeContent.mooc";
	}
	
	@RequestMapping("/admin/noticeDelete.mooc")
	//�������� ����
	public String noticeDelete_main(HttpServletRequest request, int notice_num, String pageNum){
		
		sqlMap.delete("deleteNotice", notice_num);
		
		content="admin_noticeList.jsp";
		request.setAttribute("admin_main_content", content);
		request.setAttribute("pageNum", pageNum);
		return "forward:/admin/noticeList.mooc";
	}
	
	
	@RequestMapping("/admin/notice_download.mooc")
	//�������� �ٿ�
	public ModelAndView admin_download(HttpServletRequest request, String fileName){
		String realPath=request.getRealPath("files");
		File down=new File(realPath+fileName);
		ModelAndView mv=new ModelAndView("download", "downloadFile", down);
		return mv;
	}
	
}