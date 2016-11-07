package common;

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

import _dto.LectureDTO;
@Controller
public class DoLiveController {
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	
	@RequestMapping("/doLive.mooc")
	//실시간 강의 시작
	public String doLiveClass(HttpServletRequest request,int sub_lec_code){
		// 강사 이름확인
		String t_id=(String) sqlMap.queryForObject("selectLecTID", sub_lec_code);
		request.setAttribute("t_id", t_id);
		
		LectureDTO sub_lec_dto=(LectureDTO) sqlMap.queryForObject("selectOneSubLecture", sub_lec_code);
		
		
		//자료 리스트 가져오기
		List lec_data_list=sqlMap.queryForList("selectAllLecData", sub_lec_code);
		
		request.setAttribute("sub_lec_dto", sub_lec_dto);
		request.setAttribute("lec_data_list", lec_data_list);
		return "doLive.jsp";
	}
	@RequestMapping("/doLive_ajax.mooc")
	public String doLive_ajax(MultipartHttpServletRequest multi){
		System.out.println("doLive_ajax");
		String u_id=multi.getParameter("u_id");
		String u_type=multi.getParameter("u_type");
		System.out.println(u_id+"/"+u_type);
		/*
		String video_fileName=multi.getParameter("video-filename");
		MultipartFile video_file=multi.getFile("video-blob");
		String realPath=multi.getRealPath("files")+"\\teacher\\";
		String savePath=realPath+video_fileName;
		System.out.println(savePath);
		File copy=new File(savePath); // 이름이 동일한 빈 파일 생성
		try {
			video_file.transferTo(copy);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//DB에 업데이트 (sub_lecture의 sub_lec_type을 2(실시간강의 완료)로  변경 및  sub_lec_media 등록, live_lecture의 live_lec_flag를 0(강의완료)으로 변경)
		int sub_lec_code=Integer.parseInt(multi.getParameter("sub_lec_code"));
		sqlMap.update("completeLiveLec", sub_lec_code);
		//기존에 미디어동영상이 있는지 확인! 있으면 ','로 이어 붙이고 DB 업데이트
		String sub_lec_media=(String) sqlMap.queryForObject("getSubLecMedia", sub_lec_code);
		LectureDTO lecDTO=new LectureDTO();
		lecDTO.setSub_lec_code(sub_lec_code);
		if(sub_lec_media!=null){
			sub_lec_media=sub_lec_media+",\\teacher\\"+video_fileName;
			lecDTO.setSub_lec_media(sub_lec_media);
			System.out.println("null아님"+lecDTO.getSub_lec_media());
			sqlMap.update("updateSubLecMedia", lecDTO);
		}else{
			lecDTO.setSub_lec_media("\\teacher\\"+video_fileName);
			System.out.println("null임"+lecDTO.getSub_lec_media());
			sqlMap.update("updateSubLecMedia", lecDTO);
		}*/

		return "doLive.jsp";
	}
}
