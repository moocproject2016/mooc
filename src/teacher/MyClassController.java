package teacher;
import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import _dto.LecNoticeDTO;
import _dto.LectureDTO;
import _dto.LectureQuestionDTO;
import _dto.LectureReviewDTO;
import _dto.pageAction;

@Controller
public class MyClassController {
	
	String main = "main.jsp";
	String content; // �� main �������� container �κп� �� content ����
	String myClass_main = "teacher/myClass/_teacher_myClass_main.jsp"; //myStudy�� main������
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	//----------------------------myClass ����----------------------------//
	
	
	@RequestMapping("/teacher/myClass.mooc")
	//myclass ����
	public String myStudy_main(HttpServletRequest request){
		HttpSession session=request.getSession();
		String t_id=(String) session.getAttribute("memId");
		
		//��������
		LecNoticeDTO lecNoticeDTO=new LecNoticeDTO();
		lecNoticeDTO.setT_id(t_id);
		lecNoticeDTO.setLec_n_type(1);
		lecNoticeDTO.setLec_n_regdate(Timestamp.valueOf("2016-01-01 00:00:00"));
		List lec_notice_list1=sqlMap.queryForList("selectAllLecNotice",lecNoticeDTO);
		lecNoticeDTO.setLec_n_type(0);
		List lec_notice_list0=sqlMap.queryForList("selectAllLecNotice",lecNoticeDTO);
		int all_count=lec_notice_list1.size()+lec_notice_list0.size();
		request.setAttribute("all_count", all_count);
		
		request.setAttribute("lec_notice_list1", lec_notice_list1);
		request.setAttribute("lec_notice_list0", lec_notice_list0);
		
		//���� �ı�
		LectureReviewDTO lecReviewDTO=new LectureReviewDTO();
		lecReviewDTO.setT_id(t_id);
		lecReviewDTO.setLec_r_regdate(Timestamp.valueOf("2016-01-01 00:00:00"));
		List lec_review_list=sqlMap.queryForList("myreviewlistForT", lecReviewDTO);
		request.setAttribute("lec_review_list", lec_review_list);
		
		
		//��������
		LectureQuestionDTO lecQuestionDTO=new LectureQuestionDTO();
		lecQuestionDTO.setT_id(t_id);
		lecQuestionDTO.setLec_c_content("0");
		List lec_qeustion_list=sqlMap.queryForList("lec_questionForT", lecQuestionDTO);
		request.setAttribute("lec_qeustion_list", lec_qeustion_list);
		request.setAttribute("u_type", 1);
		
		
		content = "_teacher_myClass_container.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	//���� ���ο��� �������� �亯 ���
	@RequestMapping("teacher/view_ReContent2.mooc")
	public String qnamodify2_main(HttpServletRequest request, LectureQuestionDTO q_dto, HttpSession session){
		sqlMap.update("view_ReContent", q_dto);
		return "redirect:/teacher/myClass.mooc";
	}

	@RequestMapping("/teacher/classList.mooc")
	//���� ����
	public String classList_main(HttpServletRequest request){
		HttpSession session=request.getSession();
		String t_id=(String) session.getAttribute("memId");
		List main_lec_list=sqlMap.queryForList("selectAllMainLecture", t_id);
		int main_lec_count=main_lec_list.size();
		request.setAttribute("main_lec_list", main_lec_list);
		request.setAttribute("main_lec_count", main_lec_count);
		List sub_lec_list=sqlMap.queryForList("selectAllSubLecture",null);
		request.setAttribute("sub_lec_list", sub_lec_list);
		
		content = "teacher_classList.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	//ajax
	@RequestMapping("teacher/classList_Ajax.mooc")
	public String getSubLecture(HttpServletRequest request,String main_lec_code){
		System.out.println("getSubLecture �޼���: "+Integer.parseInt(main_lec_code));
		LectureDTO lectureDTO=new LectureDTO();
		lectureDTO.setMain_lec_code(Integer.parseInt(main_lec_code));
		List subLecList=sqlMap.queryForList("selectAllSubLectureForMain",lectureDTO);
		String main_lec_subject=(String) sqlMap.queryForObject("selectMainLecSubject", Integer.parseInt(main_lec_code));
		request.setAttribute("main_lec_subject", main_lec_subject);
		request.setAttribute("main_lec_code", Integer.parseInt(main_lec_code));
		request.setAttribute("subLecList", subLecList);
		return "teacher/myClass/teacher_classList_Ajax.jsp";
	}
	
	
	//���ΰ��� ������
	@RequestMapping("/teacher/classModify.mooc")
	public String classModify_main(HttpServletRequest request,int main_lec_code){
		//���ΰ��� ���� ��������
		LectureDTO main_lec_dto =(LectureDTO) sqlMap.queryForObject("selectOneMainLecture", main_lec_code);
		
		//���갭�� ��� ��������
		List sub_lec_list=sqlMap.queryForList("selectAllSubLectureForMain", main_lec_dto);
		
				
		request.setAttribute("main_lec_dto", main_lec_dto);
		request.setAttribute("sub_lec_list", sub_lec_list);
		content = "teacher_classModify.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	//���ΰ��� ���� ������Ʈ
	@RequestMapping("/teacher/classModifyPro.mooc")
	public String classModifyPro(MultipartHttpServletRequest multi){
		LectureDTO lectureDTO=new LectureDTO();
		//���� ���� ����
		HttpSession session=multi.getSession();
		String t_id=(String) session.getAttribute("memId");
		int main_lec_code=Integer.parseInt(multi.getParameter("main_lec_code"));
		String main_lec_subject=multi.getParameter("main_lec_subject");
		String main_lec_content=multi.getParameter("main_lec_content");
		String before_img=multi.getParameter("before_img");
		String after_img=multi.getParameter("after_img");
		System.out.println("���ΰ����ڵ� "+main_lec_code);
		lectureDTO.setMain_lec_code(main_lec_code);
		lectureDTO.setMain_lec_subject(main_lec_subject);
		lectureDTO.setMain_lec_content(main_lec_content);
		String main_lec_image="";
		MultipartFile file=multi.getFile("after_img");
		List<Integer> existSubLecList=new ArrayList<Integer>(); // ���� �־���ϴ� Sub_Lec_code ����Ʈ
		List<Integer> dbSubLecList=sqlMap.queryForList("selectSubLecCodeList", main_lec_code); //���� DB�� �����ϴ� sub_lec_code�� ����Ʈ�� �޾ƿ�
		String realPath=multi.getRealPath("files");
		
		if(file.getOriginalFilename().equals("")){ // ���� �̹����� ���
			System.out.println("���� �̹���"+before_img);
			lectureDTO.setMain_lec_image(before_img);
		}else{ // ���� ����� �̹����� ���
			
			//���� �̹��� ����
			File beforeImg=new File(realPath+before_img);
			System.out.println("������ �̹���"+realPath+before_img);
			if(beforeImg.exists()){	beforeImg.delete(); }
			//�̹��� ���� ����
			
			String fileName=main_lec_code+"_img_"+file.getOriginalFilename();
			String savePath=realPath+"\\teacher\\"+fileName;
			System.out.println("�� �̹���"+savePath);
			File copy=new File(savePath); // �̸��� ������ �� ���� ����
			try {
				file.transferTo(copy);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//DB�� ����
			main_lec_image="\\teacher\\"+fileName;
			lectureDTO.setMain_lec_image(main_lec_image);
		}
		sqlMap.update("updateMainLec", lectureDTO);
		
		
		//���� ���ǰ� �ϳ��� �ִ� ���
		if(multi.getParameterValues("sub_lec_code")!=null){
		
			//���� ���� ��� ���� �� ����
			String[] sub_lec_code=multi.getParameterValues("sub_lec_code");
			String[] sub_lec_chapter=multi.getParameterValues("sub_lec_chapter");
			String[] sub_lec_type=multi.getParameterValues("sub_lec_type");
			String[] sub_lec_subject=multi.getParameterValues("sub_lec_subject");
			String[] before_file=multi.getParameterValues("before_file");
			String[] live_lec_date=multi.getParameterValues("live_lec_date");
			String[] sub_lec_content=multi.getParameterValues("sub_lec_content");
			String[] fileState=multi.getParameterValues("fileState");
			List<MultipartFile> after_file_list=multi.getFiles("after_file");
			
			for(int i=0;i<sub_lec_code.length;i++){
				System.out.println("========================");
				LectureDTO sub_lec_dto=new LectureDTO();
				boolean newUpdate=false;
				if(!sub_lec_code[i].equals("")){ sub_lec_dto.setSub_lec_code(Integer.parseInt(sub_lec_code[i])); }
				else{ newUpdate=true; }
				sub_lec_dto.setSub_lec_subject(sub_lec_subject[i]);
				sub_lec_dto.setSub_lec_chapter(Integer.parseInt(sub_lec_chapter[i]));
				sub_lec_dto.setSub_lec_content(sub_lec_content[i]);
				sub_lec_dto.setSub_lec_type(Integer.parseInt(sub_lec_type[i]));
				sub_lec_dto.setLive_lec_date(live_lec_date[i]);
				sub_lec_dto.setT_id(t_id);
				sub_lec_dto.setMain_lec_code(main_lec_code);
				
				
				//������
				if(Integer.parseInt(sub_lec_type[i])==0){ //��ȭ�����϶�
					System.out.println(fileState[i]);
					if(fileState[i].equals("new")){ // ���� ����� �������� ���
						MultipartFile mediaFile=after_file_list.get(i);
						String mediaFileName="\\teacher\\"+main_lec_code+"_"+sub_lec_chapter[i]+"_media_"+mediaFile.getOriginalFilename();
						System.out.println("���� ����� ������:"+realPath+mediaFileName);
						
						//���� ���� ����
						File deleteFile=new File(realPath+before_file[i]);
						if(deleteFile.exists()){ deleteFile.delete(); }
						System.out.println("������ ����:"+realPath+before_file[i] );
						
						//�� ���� ���
						File copy=new File(realPath+mediaFileName);
						try {
							mediaFile.transferTo(copy);
						} catch (Exception e) {
							e.printStackTrace();
						}
						sub_lec_dto.setSub_lec_media(mediaFileName);
						
					}else{ // ���� �������� ���
						System.out.println("���� ������");
						sub_lec_dto.setSub_lec_media(before_file[i]);
					}
					
				}else if(Integer.parseInt(sub_lec_type[i])==2){  // �Ϸ�� �ǽð� ������ ���
					sub_lec_dto.setSub_lec_media(before_file[i]);
				}
				
				
				//������ ���� ���갭���� �� (sub_lec_code==0)
				if(newUpdate==true){ // ������ ���� ���갭���̸� insert
					System.out.println("insert");
					System.out.println("���ΰ����ڵ� "+main_lec_code);
					sqlMap.insert("insertSubLecture", sub_lec_dto);
					//sub_lec_code ������ ��������
					sub_lec_dto.setSub_lec_code((int) sqlMap.queryForObject("selectSubLecSeq", null));
					if(Integer.parseInt(sub_lec_type[i])==1){ // �ǽð� ������ ���
						sqlMap.insert("insertLiveLecture", sub_lec_dto);
					}
				}else{ //������ ��ϵ� ���갭�� �� �� update
					System.out.println("update");
					sqlMap.update("updateSubLec", sub_lec_dto);
					if(Integer.parseInt(sub_lec_type[i])==1){ // �ǽð� ������ ���
						System.out.println("�ǽð� ������ ��� ������Ʈ");
						sqlMap.update("updateLiveLec", sub_lec_dto);
					}else if(Integer.parseInt(sub_lec_type[i])==0){ // ��ȭ���� �� ���, ���� �ǽð� ���� ���ڵ尡 ������ ����
						System.out.println("��ȭ ������ ��� ������Ʈ����");
						sqlMap.delete("deleteLiveLec", sub_lec_dto.getSub_lec_code());
					}
				}
				existSubLecList.add(sub_lec_dto.getSub_lec_code()); // ���� �����ϴ� ���갭�� �ڵ�
			}
			
		}
		// ���� ���� ������ ��� DB(sub_lecture�� live_lecture)���� ���� �� �ش� �̵�� ���ϻ���
		for(int i=0;i<dbSubLecList.size();i++){
			int sub_lec_code2=dbSubLecList.get(i);
			boolean exist=false;
			for(int j=0;j<existSubLecList.size();j++){
				if(sub_lec_code2==existSubLecList.get(j)){ //db�� �����ϴ� ���갭�ǰ� ������ �����ϸ� true
					exist=true;
				}
			}
			if(exist==false){ //db�� �����ϴ� ���갭�ǰ� ������ �������� �ʴ� ��� ����, ���ϵ� ����
				System.out.println("���� �������� �ʴ� ���갭�� ����: "+sub_lec_code2);
				//���� ã�ƿͼ� ����
				String fileName=(String) sqlMap.queryForObject("getSubLecMedia",sub_lec_code2);
				String[] fileNameArray=fileName.split(",");
				for(int j=0;j<fileNameArray.length;j++){
					File deleteFile=new File(realPath+fileNameArray[j]);
					if(deleteFile.exists()){	deleteFile.delete(); }
				}
				sqlMap.delete("deleteSubLec", sub_lec_code2);
				//�ǽð� ���� DB������ ����
				sqlMap.delete("deleteLiveLec", sub_lec_code2);
			}
		}
		
		return "redirect:/teacher/classList.mooc";
	}
	//���ΰ��� ������
	@RequestMapping("/teacher/classDelete.mooc")
	public String classDelete_main(HttpServletRequest request,int main_lec_code){
		sqlMap.delete("deleteMainLec", main_lec_code);
		sqlMap.delete("deleteSubLec", main_lec_code);
		//�ǽð� ���� DB ����, ���� ���� ����, ��������, 
	
		return "redirect:/teacher/classList.mooc";
	}
		
	@RequestMapping("/teacher/quizList.mooc")
	//���� ����
	public String quizList_main(HttpServletRequest request){
		
		
		content = "board/teacher_quizList.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
		
	@RequestMapping("/teacher/qnaList.mooc")
	//���� �亯
	public String qnaList_main(HttpServletRequest request,LectureQuestionDTO lecQueDTO){
		int main_lec_code=0;
		if(request.getAttribute("main_lec_code")!=null){
			main_lec_code=(int) request.getAttribute("main_lec_code");	
		}
		if(request.getParameter("main_lec_code")!=null){
			main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));	
		}
		lecQueDTO.setMain_lec_code(main_lec_code);
		
		HttpSession session=request.getSession();
		String t_id=(String) session.getAttribute("memId");
		lecQueDTO.setT_id(t_id);
		
		String pageNum=request.getParameter("pageNum");
		List AllList=(ArrayList)sqlMap.queryForList("lec_questionForT", lecQueDTO);
		pageAction pageing=new pageAction();
		List view_question = pageing.pageList(pageNum,AllList, 7);
		request.setAttribute("all_count", AllList.size());
		
		// ������ ���ΰ��� ��� �̾ƿ���
		List main_lec_list=sqlMap.queryForList("selectMainLecListForTID",t_id);
		System.out.println("���ΰ��� ����"+main_lec_list.size());
		request.setAttribute("main_lec_list", main_lec_list);
		request.setAttribute("main_lec_code", lecQueDTO.getMain_lec_code());
		
		System.out.println(main_lec_code+"/"+t_id);
		request.setAttribute("count",pageing.count());
		request.setAttribute("currentPage", pageing.current());
		request.setAttribute("pageSize", pageing.size());
		request.setAttribute("view_question", view_question);
		request.setAttribute("u_type", 1);
		
		content = "board/teacher_qnaList.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	//���� ���ο��� �������� �亯 ���
		@RequestMapping("teacher/view_ReContent3.mooc")
		public String qnamodify3_main(HttpServletRequest request, LectureQuestionDTO q_dto){
			int main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));
			sqlMap.update("view_ReContent", q_dto);
			request.setAttribute("main_lec_code", main_lec_code);
			return "redirect:/teacher/qnaList.mooc";
		}
		
		@RequestMapping("/teacher/reviewList.mooc")
		//���� �ı���
		public String classReviewList_main(HttpServletRequest request, LectureReviewDTO lecReviewDTO){
			
			if(request.getParameter("main_lec_code")!=null){
				lecReviewDTO.setMain_lec_code(Integer.parseInt(request.getParameter("main_lec_code")));
			}
			
			HttpSession session=request.getSession();
			String t_id = (String)session.getAttribute("memId");
			lecReviewDTO.setT_id(t_id);
			
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null){ pageNum="1"; }
			
			// ������ ���ΰ��� ��� �̾ƿ���
			List main_lec_list=sqlMap.queryForList("selectMainLecListForTID",t_id);
			System.out.println("���ΰ��� ����"+main_lec_list.size());
			request.setAttribute("main_lec_list", main_lec_list);
			request.setAttribute("main_lec_code", lecReviewDTO.getMain_lec_code());
			
			// �����ı� �̾ƿ���
			List AllList=sqlMap.queryForList("myreviewlistForT",lecReviewDTO);
			pageAction pageing=new pageAction();
			List member = pageing.pageList(pageNum,AllList, 10);
			request.setAttribute("all_count", AllList.size());
			
			request.setAttribute("count",pageing.count());
			request.setAttribute("currentPage", pageing.current());
			request.setAttribute("pageSize", pageing.size());
			request.setAttribute("member", member);
			
			content = "board/teacher_reviewList.jsp";
			request.setAttribute("main_content", myClass_main);
			request.setAttribute("teacher_myClass_content", content);
			return main;
		}
	
	
	
	@RequestMapping("/teacher/doRecodeClass.mooc")
	//��ȭ ���� ����
	public String doRecodeClass_main(HttpServletRequest request){
		content = "teacher_doRecordClass.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	@RequestMapping("/teacher/liveLecListClass.mooc")
	public String liveLecListClass_main(HttpServletRequest request){
		//�ǽð� ���Ǹ�� ��������
		HttpSession session=request.getSession();
		String t_id=(String) session.getAttribute("memId");
		List subLiveLecList=sqlMap.queryForList("selectSubLiveLecList", t_id);
		request.setAttribute("subLiveLecList", subLiveLecList);
		System.out.println("������:"+subLiveLecList.size());
		
		content = "teacher_liveLecListClass.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	//----------------------------myClass ��----------------------------//
}
