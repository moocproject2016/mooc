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
	String content; // 각 main 페이지의 container 부분에 들어갈 content 정의
	String myClass_main = "teacher/myClass/_teacher_myClass_main.jsp"; //myStudy의 main페이지
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	//----------------------------myClass 시작----------------------------//
	
	
	@RequestMapping("/teacher/myClass.mooc")
	//myclass 메인
	public String myStudy_main(HttpServletRequest request){
		HttpSession session=request.getSession();
		String t_id=(String) session.getAttribute("memId");
		
		//공지사항
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
		
		//강의 후기
		LectureReviewDTO lecReviewDTO=new LectureReviewDTO();
		lecReviewDTO.setT_id(t_id);
		lecReviewDTO.setLec_r_regdate(Timestamp.valueOf("2016-01-01 00:00:00"));
		List lec_review_list=sqlMap.queryForList("myreviewlistForT", lecReviewDTO);
		request.setAttribute("lec_review_list", lec_review_list);
		
		
		//강의질문
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
	//강사 메인에서 강의질문 답변 등록
	@RequestMapping("teacher/view_ReContent2.mooc")
	public String qnamodify2_main(HttpServletRequest request, LectureQuestionDTO q_dto, HttpSession session){
		sqlMap.update("view_ReContent", q_dto);
		return "redirect:/teacher/myClass.mooc";
	}

	@RequestMapping("/teacher/classList.mooc")
	//강의 관리
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
		System.out.println("getSubLecture 메서드: "+Integer.parseInt(main_lec_code));
		LectureDTO lectureDTO=new LectureDTO();
		lectureDTO.setMain_lec_code(Integer.parseInt(main_lec_code));
		List subLecList=sqlMap.queryForList("selectAllSubLectureForMain",lectureDTO);
		String main_lec_subject=(String) sqlMap.queryForObject("selectMainLecSubject", Integer.parseInt(main_lec_code));
		request.setAttribute("main_lec_subject", main_lec_subject);
		request.setAttribute("main_lec_code", Integer.parseInt(main_lec_code));
		request.setAttribute("subLecList", subLecList);
		return "teacher/myClass/teacher_classList_Ajax.jsp";
	}
	
	
	//메인강의 수정폼
	@RequestMapping("/teacher/classModify.mooc")
	public String classModify_main(HttpServletRequest request,int main_lec_code){
		//메인강의 정보 가져오기
		LectureDTO main_lec_dto =(LectureDTO) sqlMap.queryForObject("selectOneMainLecture", main_lec_code);
		
		//서브강의 목록 가져오기
		List sub_lec_list=sqlMap.queryForList("selectAllSubLectureForMain", main_lec_dto);
		
				
		request.setAttribute("main_lec_dto", main_lec_dto);
		request.setAttribute("sub_lec_list", sub_lec_list);
		content = "teacher_classModify.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	//메인강의 수정 업데이트
	@RequestMapping("/teacher/classModifyPro.mooc")
	public String classModifyPro(MultipartHttpServletRequest multi){
		LectureDTO lectureDTO=new LectureDTO();
		//메인 강의 수정
		HttpSession session=multi.getSession();
		String t_id=(String) session.getAttribute("memId");
		int main_lec_code=Integer.parseInt(multi.getParameter("main_lec_code"));
		String main_lec_subject=multi.getParameter("main_lec_subject");
		String main_lec_content=multi.getParameter("main_lec_content");
		String before_img=multi.getParameter("before_img");
		String after_img=multi.getParameter("after_img");
		System.out.println("메인강의코드 "+main_lec_code);
		lectureDTO.setMain_lec_code(main_lec_code);
		lectureDTO.setMain_lec_subject(main_lec_subject);
		lectureDTO.setMain_lec_content(main_lec_content);
		String main_lec_image="";
		MultipartFile file=multi.getFile("after_img");
		List<Integer> existSubLecList=new ArrayList<Integer>(); // 실제 있어야하는 Sub_Lec_code 리스트
		List<Integer> dbSubLecList=sqlMap.queryForList("selectSubLecCodeList", main_lec_code); //현재 DB에 존재하는 sub_lec_code의 리스트를 받아옴
		String realPath=multi.getRealPath("files");
		
		if(file.getOriginalFilename().equals("")){ // 기존 이미지인 경우
			System.out.println("기존 이미지"+before_img);
			lectureDTO.setMain_lec_image(before_img);
		}else{ // 새로 등록한 이미지인 경우
			
			//기존 이미지 삭제
			File beforeImg=new File(realPath+before_img);
			System.out.println("삭제할 이미지"+realPath+before_img);
			if(beforeImg.exists()){	beforeImg.delete(); }
			//이미지 파일 저장
			
			String fileName=main_lec_code+"_img_"+file.getOriginalFilename();
			String savePath=realPath+"\\teacher\\"+fileName;
			System.out.println("새 이미지"+savePath);
			File copy=new File(savePath); // 이름이 동일한 빈 파일 생성
			try {
				file.transferTo(copy);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//DB에 저장
			main_lec_image="\\teacher\\"+fileName;
			lectureDTO.setMain_lec_image(main_lec_image);
		}
		sqlMap.update("updateMainLec", lectureDTO);
		
		
		//서브 강의가 하나라도 있는 경우
		if(multi.getParameterValues("sub_lec_code")!=null){
		
			//서브 강의 목록 수정 및 삽입
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
				
				
				//동영상
				if(Integer.parseInt(sub_lec_type[i])==0){ //녹화강의일때
					System.out.println(fileState[i]);
					if(fileState[i].equals("new")){ // 새로 등록한 동영상일 경우
						MultipartFile mediaFile=after_file_list.get(i);
						String mediaFileName="\\teacher\\"+main_lec_code+"_"+sub_lec_chapter[i]+"_media_"+mediaFile.getOriginalFilename();
						System.out.println("새로 등록한 동영상:"+realPath+mediaFileName);
						
						//기존 파일 삭제
						File deleteFile=new File(realPath+before_file[i]);
						if(deleteFile.exists()){ deleteFile.delete(); }
						System.out.println("삭제할 파일:"+realPath+before_file[i] );
						
						//새 파일 등록
						File copy=new File(realPath+mediaFileName);
						try {
							mediaFile.transferTo(copy);
						} catch (Exception e) {
							e.printStackTrace();
						}
						sub_lec_dto.setSub_lec_media(mediaFileName);
						
					}else{ // 기존 동영상일 경우
						System.out.println("기존 동영상");
						sub_lec_dto.setSub_lec_media(before_file[i]);
					}
					
				}else if(Integer.parseInt(sub_lec_type[i])==2){  // 완료된 실시간 강의인 경우
					sub_lec_dto.setSub_lec_media(before_file[i]);
				}
				
				
				//기존에 없는 서브강의일 때 (sub_lec_code==0)
				if(newUpdate==true){ // 기존에 없는 서브강의이면 insert
					System.out.println("insert");
					System.out.println("메인강의코드 "+main_lec_code);
					sqlMap.insert("insertSubLecture", sub_lec_dto);
					//sub_lec_code 시퀀스 가져오기
					sub_lec_dto.setSub_lec_code((int) sqlMap.queryForObject("selectSubLecSeq", null));
					if(Integer.parseInt(sub_lec_type[i])==1){ // 실시간 강의인 경우
						sqlMap.insert("insertLiveLecture", sub_lec_dto);
					}
				}else{ //기존에 등록된 서브강의 일 때 update
					System.out.println("update");
					sqlMap.update("updateSubLec", sub_lec_dto);
					if(Integer.parseInt(sub_lec_type[i])==1){ // 실시간 강의인 경우
						System.out.println("실시간 강의인 경우 업데이트");
						sqlMap.update("updateLiveLec", sub_lec_dto);
					}else if(Integer.parseInt(sub_lec_type[i])==0){ // 녹화강의 인 경우, 기존 실시간 강의 레코드가 있으면 삭제
						System.out.println("녹화 강의인 경우 업데이트안함");
						sqlMap.delete("deleteLiveLec", sub_lec_dto.getSub_lec_code());
					}
				}
				existSubLecList.add(sub_lec_dto.getSub_lec_code()); // 현재 존재하는 서브강의 코드
			}
			
		}
		// 서브 강의 삭제한 경우 DB(sub_lecture와 live_lecture)에서 삭제 및 해당 미디어 파일삭제
		for(int i=0;i<dbSubLecList.size();i++){
			int sub_lec_code2=dbSubLecList.get(i);
			boolean exist=false;
			for(int j=0;j<existSubLecList.size();j++){
				if(sub_lec_code2==existSubLecList.get(j)){ //db에 존재하는 서브강의가 실제로 존재하면 true
					exist=true;
				}
			}
			if(exist==false){ //db에 존재하는 서브강의가 실제로 존재하지 않는 경우 삭제, 파일도 삭제
				System.out.println("실제 존재하지 않는 서브강의 삭제: "+sub_lec_code2);
				//파일 찾아와서 삭제
				String fileName=(String) sqlMap.queryForObject("getSubLecMedia",sub_lec_code2);
				String[] fileNameArray=fileName.split(",");
				for(int j=0;j<fileNameArray.length;j++){
					File deleteFile=new File(realPath+fileNameArray[j]);
					if(deleteFile.exists()){	deleteFile.delete(); }
				}
				sqlMap.delete("deleteSubLec", sub_lec_code2);
				//실시간 강의 DB에서도 삭제
				sqlMap.delete("deleteLiveLec", sub_lec_code2);
			}
		}
		
		return "redirect:/teacher/classList.mooc";
	}
	//메인강의 삭제폼
	@RequestMapping("/teacher/classDelete.mooc")
	public String classDelete_main(HttpServletRequest request,int main_lec_code){
		sqlMap.delete("deleteMainLec", main_lec_code);
		sqlMap.delete("deleteSubLec", main_lec_code);
		//실시간 강의 DB 삭제, 실제 파일 삭제, 공지사항, 
	
		return "redirect:/teacher/classList.mooc";
	}
		
	@RequestMapping("/teacher/quizList.mooc")
	//퀴즈 관리
	public String quizList_main(HttpServletRequest request){
		
		
		content = "board/teacher_quizList.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
		
	@RequestMapping("/teacher/qnaList.mooc")
	//질문 답변
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
		
		// 강사의 메인강의 목록 뽑아오기
		List main_lec_list=sqlMap.queryForList("selectMainLecListForTID",t_id);
		System.out.println("메인강의 개수"+main_lec_list.size());
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
	//강사 메인에서 강의질문 답변 등록
		@RequestMapping("teacher/view_ReContent3.mooc")
		public String qnamodify3_main(HttpServletRequest request, LectureQuestionDTO q_dto){
			int main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));
			sqlMap.update("view_ReContent", q_dto);
			request.setAttribute("main_lec_code", main_lec_code);
			return "redirect:/teacher/qnaList.mooc";
		}
		
		@RequestMapping("/teacher/reviewList.mooc")
		//강의 후기목록
		public String classReviewList_main(HttpServletRequest request, LectureReviewDTO lecReviewDTO){
			
			if(request.getParameter("main_lec_code")!=null){
				lecReviewDTO.setMain_lec_code(Integer.parseInt(request.getParameter("main_lec_code")));
			}
			
			HttpSession session=request.getSession();
			String t_id = (String)session.getAttribute("memId");
			lecReviewDTO.setT_id(t_id);
			
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null){ pageNum="1"; }
			
			// 강사의 메인강의 목록 뽑아오기
			List main_lec_list=sqlMap.queryForList("selectMainLecListForTID",t_id);
			System.out.println("메인강의 개수"+main_lec_list.size());
			request.setAttribute("main_lec_list", main_lec_list);
			request.setAttribute("main_lec_code", lecReviewDTO.getMain_lec_code());
			
			// 강의후기 뽑아오기
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
	//녹화 강의 시작
	public String doRecodeClass_main(HttpServletRequest request){
		content = "teacher_doRecordClass.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	@RequestMapping("/teacher/liveLecListClass.mooc")
	public String liveLecListClass_main(HttpServletRequest request){
		//실시간 강의목록 가져오기
		HttpSession session=request.getSession();
		String t_id=(String) session.getAttribute("memId");
		List subLiveLecList=sqlMap.queryForList("selectSubLiveLecList", t_id);
		request.setAttribute("subLiveLecList", subLiveLecList);
		System.out.println("사이즈:"+subLiveLecList.size());
		
		content = "teacher_liveLecListClass.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	//----------------------------myClass 끝----------------------------//
}
