package common;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import _dto.StudygroupBoardDTO;

@Controller
public class DoConferenceController {
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	
	@RequestMapping("/conferenceRoomAjax.mooc")
	//�ǽð� ���� ����
	public String conferenceRoomAjax(MultipartHttpServletRequest multi){
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyMMdd_HH:mm", Locale.KOREA );
		Date currentTime = new Date ( );
		String mTime = mSimpleDateFormat.format ( currentTime );
		int stg_code=Integer.parseInt(multi.getParameter("stg_code"));
		String textblob=multi.getParameter("textblob");
		MultipartFile chat_file=multi.getFile("textblob");
		String realPath=multi.getRealPath("files");
		String filename="\\community\\"+Integer.toString(stg_code)+"_chat_"+mTime+".txt";
		String savePath=realPath+filename;
		System.out.println(savePath);
		File copy=new File(savePath); // �̸��� ������ �� ���� ����
		try {
			chat_file.transferTo(copy);
		} catch (Exception e) {
			e.printStackTrace();
		}
		StudygroupBoardDTO sgbdto=new StudygroupBoardDTO();
		sgbdto.setStg_code(stg_code);
		sgbdto.setStg_b_data(filename);
		sgbdto.setStg_b_subject("ȸ�ǹ� ä�ñ��_"+mTime);
		sgbdto.setStg_b_type("ȸ�ǹ�");
		sgbdto.setU_id("����");
		sqlMap.insert("insertStudyBoard", sgbdto);
		
		return "conferenceRoomAjax.jsp";
	}
}
