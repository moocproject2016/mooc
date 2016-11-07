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
	//�ǽð� ���� ����
	public String doLiveClass(HttpServletRequest request,int sub_lec_code){
		// ���� �̸�Ȯ��
		String t_id=(String) sqlMap.queryForObject("selectLecTID", sub_lec_code);
		request.setAttribute("t_id", t_id);
		
		LectureDTO sub_lec_dto=(LectureDTO) sqlMap.queryForObject("selectOneSubLecture", sub_lec_code);
		
		
		//�ڷ� ����Ʈ ��������
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
		File copy=new File(savePath); // �̸��� ������ �� ���� ����
		try {
			video_file.transferTo(copy);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//DB�� ������Ʈ (sub_lecture�� sub_lec_type�� 2(�ǽð����� �Ϸ�)��  ���� ��  sub_lec_media ���, live_lecture�� live_lec_flag�� 0(���ǿϷ�)���� ����)
		int sub_lec_code=Integer.parseInt(multi.getParameter("sub_lec_code"));
		sqlMap.update("completeLiveLec", sub_lec_code);
		//������ �̵������� �ִ��� Ȯ��! ������ ','�� �̾� ���̰� DB ������Ʈ
		String sub_lec_media=(String) sqlMap.queryForObject("getSubLecMedia", sub_lec_code);
		LectureDTO lecDTO=new LectureDTO();
		lecDTO.setSub_lec_code(sub_lec_code);
		if(sub_lec_media!=null){
			sub_lec_media=sub_lec_media+",\\teacher\\"+video_fileName;
			lecDTO.setSub_lec_media(sub_lec_media);
			System.out.println("null�ƴ�"+lecDTO.getSub_lec_media());
			sqlMap.update("updateSubLecMedia", lecDTO);
		}else{
			lecDTO.setSub_lec_media("\\teacher\\"+video_fileName);
			System.out.println("null��"+lecDTO.getSub_lec_media());
			sqlMap.update("updateSubLecMedia", lecDTO);
		}*/

		return "doLive.jsp";
	}
}
