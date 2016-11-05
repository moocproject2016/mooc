package teacher;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import _dto.LecNoticeDTO;
import _dto.pageAction;

@Controller
public class LecNoticeController {
	String main = "main.jsp";
	String content; // �� main �������� container �κп� �� content ����
	String myClass_main = "teacher/myClass/_teacher_myClass_main.jsp"; //myStudy�� main������
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	@RequestMapping("/teacher/noticeList.mooc")
	//�������� ����Ʈ
	public String tNoticeList_main(HttpServletRequest request){
		
		LecNoticeDTO lecNoticeDTO=new LecNoticeDTO();
		if(request.getParameter("main_lec_code")!=null){
			lecNoticeDTO.setMain_lec_code(Integer.parseInt(request.getParameter("main_lec_code")));
		}
		//�˻�
		String searchKey=request.getParameter("searchKey");
		String searchValue=request.getParameter("searchValue");
		lecNoticeDTO.setSearchKey(searchKey);
		lecNoticeDTO.setSearchValue(searchValue);
		System.out.println("searchKey"+lecNoticeDTO.getSearchKey());
		System.out.println("searchValue"+lecNoticeDTO.getSearchValue());
		
		
		HttpSession session=request.getSession();
		String t_id=(String) session.getAttribute("memId");
		List main_lec_list=sqlMap.queryForList("selectMainLecListForTID",t_id);
		System.out.println("���ΰ��� ����"+main_lec_list.size());
		request.setAttribute("main_lec_list", main_lec_list);
		
		System.out.println("���ΰ����ڵ�"+lecNoticeDTO.getMain_lec_code());
		lecNoticeDTO.setT_id(t_id);
		lecNoticeDTO.setLec_n_type(1);
		List lec_notice_list1=sqlMap.queryForList("selectAllLecNotice",lecNoticeDTO);
		lecNoticeDTO.setLec_n_type(0);
		List lec_notice_list0=sqlMap.queryForList("selectAllLecNotice",lecNoticeDTO);
		int all_count=lec_notice_list1.size()+lec_notice_list0.size();
		request.setAttribute("all_count", all_count);
		
		//����¡
		String pageNum="1";
		if(request.getParameter("pageNum")!=null){  System.out.println("null�ƴ�"); pageNum=request.getParameter("pageNum");}
		System.out.println(pageNum);
		pageAction pageing=new pageAction();
		List list=pageing.pageList(pageNum,lec_notice_list0, 10);
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		
		request.setAttribute("lec_notice_list1", lec_notice_list1);
		request.setAttribute("lec_notice_list0", list);
		request.setAttribute("main_lec_code", lecNoticeDTO.getMain_lec_code());
		request.setAttribute("pageNum", pageNum);
		
		content = "board/teacher_noticeList.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	@RequestMapping("/teacher/noticeWrite.mooc")
	//�������� �ۼ�
	public String tNoticeWrite_main(HttpServletRequest request){

		int main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));
		request.setAttribute("main_lec_code", main_lec_code);
		
		HttpSession session=request.getSession();
		String t_id=(String) session.getAttribute("memId");
		List main_lec_list=sqlMap.queryForList("selectMainLecListForTID",t_id);
		request.setAttribute("main_lec_list", main_lec_list);
		
		content = "board/teacher_noticeWrite.jsp";
		
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	@RequestMapping("/teacher/noticeWritePro.mooc")
	//�������� DB ���
	public String tNoticeWritePro(MultipartHttpServletRequest multi,LecNoticeDTO lecNoticeDTO){
		HttpSession session=multi.getSession();
		String t_id=(String) session.getAttribute("memId");
		lecNoticeDTO.setT_id(t_id);
		int lec_n_num=(int) sqlMap.queryForObject("selectLecNoticeSeq", null);
		lec_n_num++;
		//÷������
		String realPath=multi.getRealPath("files");
		MultipartFile file=multi.getFile("save");
		String filename="";
		if(file!=null){
			filename="\\teacher\\lecNotice_"+lec_n_num+"_"+file.getOriginalFilename();
			File copy=new File(realPath+filename);
			try{
				file.transferTo(copy);
			}catch(Exception e){ e.printStackTrace(); }
		}
		lecNoticeDTO.setLec_n_file(filename);
		System.out.println("�߿����:"+lecNoticeDTO.getLec_n_type());
		sqlMap.insert("insertLecNotice", lecNoticeDTO);
		
		multi.setAttribute("lec_n_num",lec_n_num);
		return "forward:/teacher/noticeContent.mooc";
	}
	
	
	
	@RequestMapping("/teacher/noticeContent.mooc")
	//�������� ����
	public String tNoticeContent_main(HttpServletRequest request){
		String pageNum="1";
		if(request.getParameter("pageNum")!=null){  System.out.println("null�ƴ�"); pageNum=request.getParameter("pageNum");}
		
		int lec_n_num=0;
		if(request.getParameter("lec_n_num")!=null){
			lec_n_num=Integer.parseInt(request.getParameter("lec_n_num"));
		}else{
			lec_n_num=(int) request.getAttribute("lec_n_num");
		}
		LecNoticeDTO lecNotice_dto=(LecNoticeDTO) sqlMap.queryForObject("selectOneLecNotice", lec_n_num);
		
		request.setAttribute("lecNotice_dto", lecNotice_dto);
		request.setAttribute("pageNum", pageNum);
		
		content = "board/teacher_noticeContent.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	
	@RequestMapping("/teacher/noticeModify.mooc")
	//�������� ����
	public String tNoticeModify_main(HttpServletRequest request){
		int lec_n_num=Integer.parseInt(request.getParameter("lec_n_num"));
		
		HttpSession session=request.getSession();
		String t_id=(String) session.getAttribute("memId");
		List main_lec_list=sqlMap.queryForList("selectMainLecListForTID",t_id);
		request.setAttribute("main_lec_list", main_lec_list);
		
		LecNoticeDTO lecNoticeDTO=(LecNoticeDTO) sqlMap.queryForObject("selectOneLecNotice", lec_n_num);
		request.setAttribute("lecNoticeDTO", lecNoticeDTO);
		
		content = "board/teacher_noticeModify.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	@RequestMapping("/teacher/noticeModifyPro.mooc")
	//�������� ����
	public String tNoticeModifyPro_main(MultipartHttpServletRequest multi,LecNoticeDTO lecNoticeDTO){
		System.out.println("������ȣ"+lecNoticeDTO.getLec_n_num());
		String before_file=multi.getParameter("before_file");
		String after_file=multi.getParameter("after_file");
		
		MultipartFile file=multi.getFile("after_file");
		System.out.println(file);
		if(file!=null){//���ο� ������ ��,
			System.out.println("���ο�����");
			String realPath=multi.getRealPath("files");
			System.out.println("������ ����"+realPath+before_file);
			//���� ���� ����
			File deletefile=new File(realPath+before_file);
			if(deletefile.exists()){	System.out.println("��������"); deletefile.delete(); }
			
			//�� ���� ����
			String fileName="\\teacher\\"+"lecNotice_"+lecNoticeDTO.getLec_n_num()+"_"+file.getOriginalFilename();
			String savePath=realPath+fileName;
			System.out.println("������"+savePath);
			File copy=new File(savePath); // �̸��� ������ �� ���� ����
			try {
				file.transferTo(copy);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//DTO�� ���ϰ�� ����
			lecNoticeDTO.setLec_n_file(fileName);
		}else{ // ���� ������ ��
			System.out.println("��������");
			lecNoticeDTO.setLec_n_file(before_file);
		}
		
		//DB�� ������� ����
		sqlMap.update("updateLecNotice", lecNoticeDTO);
		
		
		multi.setAttribute("lec_n_num",lecNoticeDTO.getLec_n_num());
		return "forward:/teacher/noticeContent.mooc";
	}
	
	@RequestMapping("/teacher/noticeDelete.mooc")
	//�������� ����
	public String tNoticeDelete_main(HttpServletRequest request){
		int lec_n_num=Integer.parseInt(request.getParameter("lec_n_num"));
		String filename=(String) sqlMap.queryForObject("getLecNFile", lec_n_num);
		System.out.println("������ȣ:"+lec_n_num);
		System.out.println("��������:"+filename);
		//���� ����
		String realPath=request.getRealPath("files");
		File deleteFile=new File(realPath+filename);
		System.out.println(realPath+filename);
		if(deleteFile.exists()){ deleteFile.delete(); }
				
		//DB���� ����
		sqlMap.delete("deleteLecNotice", lec_n_num);
		
		content = "board/teacher_noticeDelete.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
}
