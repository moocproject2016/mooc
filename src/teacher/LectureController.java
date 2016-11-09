package teacher;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import _dto.LecDataDTO;
import _dto.LectureDTO;
import _dto.TestDTO;


@Controller
public class LectureController {
	String main = "main.jsp";
	String content; // �� main �������� container �κп� �� content ����
	String myClass_main = "teacher/myClass/_teacher_myClass_main.jsp"; //myStudy�� main������
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	@RequestMapping("test.mooc")
	public String test(){
		
		return "/test.jsp";
	}
	
	@RequestMapping("test1.mooc")
	public String test1(){
	
		return "/test1.jsp";
	}
	
	
	//�� ���� ���ε�
	@RequestMapping("/teacher/classWrite.mooc")	
	public String myclassWrite_main(HttpServletRequest request){
		content = "lectureMake/teacher_makeMainLecture.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	
	//������ ���ΰ��ǿ� ���� ���갭�� ����� ������
	@RequestMapping(value="getSubCtg.mooc",method=RequestMethod.POST)
	public @ResponseBody String getSubCtg(String top_ctg_code){
		System.out.println("getSubCtg �޼���: "+Integer.parseInt(top_ctg_code));
		List subCtgList=sqlMap.queryForList("selectSubCtgList",Integer.parseInt(top_ctg_code));
		String subCtgString="";
		for(int i=0;i<subCtgList.size();i++){
			subCtgString+=(String)subCtgList.get(i);
			if(i!=subCtgList.size()-1){ subCtgString+=","; }
		}
		System.out.println(subCtgList.size());   
		System.out.println(subCtgString);
		return subCtgString;
	}
	
	//������ ���ΰ��Ǹ� DB�� ������Ʈ
	@RequestMapping("teacher/makeMainLecturePro.mooc")
	public String makeMainLecturePro(MultipartHttpServletRequest multi,LectureDTO lectureDTO){
		HttpSession session=multi.getSession();
		String t_id=(String) session.getAttribute("memId");
		System.out.println(t_id);
		lectureDTO.setT_id(t_id);
		String realPath=multi.getRealPath("files")+"\\teacher\\";
		
		//�̹��� ���� ����
		MultipartFile file=multi.getFile("save");
		int nextVal=(int) sqlMap.queryForObject("selectMainLecSeq", null)+1;
		String fileName=nextVal+"_img_"+file.getOriginalFilename();
		String savePath=realPath+fileName;
		File copy=new File(savePath); // �̸��� ������ �� ���� ����
		try {
			file.transferTo(copy);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//DB�� ����
		String main_lec_image="\\teacher\\"+fileName;
		lectureDTO.setMain_lec_image(main_lec_image);
		
		//����ī�װ��̸����� ����ī�װ��ڵ� ��������
		String sub_ctg_name=lectureDTO.getSub_ctg_name();
		System.out.println(sub_ctg_name);
		int sub_ctg_code=(int) sqlMap.queryForObject("selectSubCtgCode", sub_ctg_name);
		lectureDTO.setSub_ctg_code(sub_ctg_code);
		
		//���ΰ��� DB�� ������Ʈ
		sqlMap.update("insertMainLecture", lectureDTO);
		
		//������ ���ΰ����ڵ� ��������
		int main_lec_code=(int) sqlMap.queryForObject("selectMainLecSeq",null);
		lectureDTO.setMain_lec_code(main_lec_code);
		System.out.println("������ ���ΰ����ڵ� "+lectureDTO.getMain_lec_code());
		
		return "forward:/teacher/makeSubLecture.mooc";
	}
	
	@RequestMapping("teacher/makeSubLecture.mooc")
	public String makeSubLecture_main(HttpServletRequest request){		
		content = "lectureMake/teacher_makeSubLecture.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	//������ ���갭�Ǹ� DB�� ������Ʈ
	@RequestMapping("teacher/makeSubLecturePro.mooc")
	public String makeSubLecturePro(MultipartHttpServletRequest multi){
		HttpSession session=multi.getSession();
		String t_id=(String) session.getAttribute("memId");
		int main_lec_code=Integer.parseInt(multi.getParameter("main_lec_code"));
		String[] sub_lec_chapter=multi.getParameterValues("sub_lec_chapter");
		String[] sub_lec_type=multi.getParameterValues("sub_lec_type");
		String[] sub_lec_subject=multi.getParameterValues("sub_lec_subject");
		String[] live_lec_date=multi.getParameterValues("live_lec_date");
		String[] sub_lec_content=multi.getParameterValues("sub_lec_content");
		
		System.out.println("sub_lec_chapter ���� "+sub_lec_chapter.length);
		String realPath=multi.getRealPath("files")+"\\teacher\\";
		List<MultipartFile> files=multi.getFiles("save");
		int record_index=0;
		int live_index=0;
		for(int i=0;i<sub_lec_chapter.length;i++){
			LectureDTO lectureDTO=new LectureDTO();
			String sub_lec_media="";
			if(sub_lec_type[i].equals("0")){ //��ȭ������ ���� file ��������
				MultipartFile file=files.get(record_index++);
				if(!file.getOriginalFilename().equals("")){ //������ �ִ� ���
					String fileName=main_lec_code+"_"+sub_lec_chapter[i]+"_media_"+file.getOriginalFilename();
					if(!fileName.equals("")){
						String savePath=realPath+fileName;
						File copy=new File(savePath); // �̸��� ������ �� ���� ����
						try {
							file.transferTo(copy);
						} catch (Exception e) {
							e.printStackTrace();
						}
						//DB�� ����
						sub_lec_media="\\teacher\\"+fileName;
						lectureDTO.setSub_lec_media(sub_lec_media);
					}
				}
			}
			
			lectureDTO.setMain_lec_code(main_lec_code);
			lectureDTO.setT_id(t_id);
			lectureDTO.setSub_lec_chapter(Integer.parseInt(sub_lec_chapter[i]));
			lectureDTO.setSub_lec_type(Integer.parseInt(sub_lec_type[i]));
			lectureDTO.setSub_lec_subject(sub_lec_subject[i]);
			lectureDTO.setSub_lec_content(sub_lec_content[i]);
			if(sub_lec_type[i].equals("1")){ //�ǽð������� ���� ��¥  dto�� ���
				lectureDTO.setLive_lec_date(live_lec_date[live_index]);
			}
			sqlMap.insert("insertSubLecture",lectureDTO);
			
			//��� ��ϵ� sub_lec_code �޾ƿ��� -> DTO�� �ֱ�
			int sub_lec_code=(int) sqlMap.queryForObject("selectSubLecSeq", null);
			lectureDTO.setSub_lec_code(sub_lec_code);
			System.out.println(sub_lec_code);
			if(lectureDTO.getSub_lec_type()==1){// �ǽð� �����϶��� realtime_lecture�� insert
				System.out.println("�ǽð� ����");
				sqlMap.insert("insertLiveLecture",lectureDTO);
			}
		}
		multi.setAttribute("main_lec_code", main_lec_code);
		
		return "forward:/teacher/subLecture_list.mooc";
	}
	
	@RequestMapping("teacher/subLecture_list.mooc")
	public String subLecture_list_main(HttpServletRequest request){
		int main_lec_code=Integer.parseInt(request.getParameter("main_lec_code"));
		LectureDTO main_lec_dto=(LectureDTO) sqlMap.queryForObject("selectOneMainLecture", main_lec_code);
		List sub_lec_list=sqlMap.queryForList("selectAllSubLectureForMain", main_lec_dto);
		request.setAttribute("sub_lec_list", sub_lec_list);
		request.setAttribute("main_lec_dto", main_lec_dto);
		
		content = "lectureMake/teacher_subLecture_list.jsp";
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	@RequestMapping("teacher/watch.mooc")
	public String watchRecord_main(HttpServletRequest request,String currentPage){		
		int state=0;
		if(request.getParameter("state")!=null){ state=Integer.parseInt(request.getParameter("state")); }
		request.setAttribute("state", state);
		
		int sub_lec_code=Integer.parseInt(request.getParameter("sub_lec_code"));
		LectureDTO sub_lec_dto=(LectureDTO) sqlMap.queryForObject("selectOneSubLecture", sub_lec_code);
		
		//�ڷ� ����Ʈ ��������
		List lec_data_list=sqlMap.queryForList("selectAllLecData", sub_lec_code);
		
		request.setAttribute("sub_lec_dto", sub_lec_dto);
		request.setAttribute("lec_data_list", lec_data_list);
		request.setAttribute("beforePage", currentPage);
		
		if(sub_lec_dto.getSub_lec_type()==0){
			content = "lectureMake/teacher_watchRecord.jsp";
		}else{
			content = "lectureMake/teacher_watchLive.jsp";
		}
		request.setAttribute("main_content", myClass_main);
		request.setAttribute("teacher_myClass_content", content);
		return main;
	}
	
	@RequestMapping("teacher/uploadFile.mooc")
	public String upload_file(HttpServletRequest request,int sub_lec_code){
		request.setAttribute("state", new Integer(0));
		request.setAttribute("sub_lec_code", sub_lec_code);
		
		return "/teacher/myClass/lectureMake/teacher_uploadFile_popup.jsp";
	}
	
	//�����ڷ�DB�� �ڷ� ���
	@RequestMapping("teacher/uploadFilePro.mooc")
	public String uploadFilePro(MultipartHttpServletRequest multi,LecDataDTO lecDataDTO){
		String lec_data_type=lecDataDTO.getLec_data_type();	
		
		
		if(lec_data_type.equals("PPT")||lec_data_type.equals("�Ϲ��̹���")){
			String realPath=multi.getRealPath("files")+"\\teacher\\lecData"+lecDataDTO.getSub_lec_code()+"_";
			
			//�̹��� ���� ����
			MultipartFile file=multi.getFile("save");
			String fileName=file.getOriginalFilename();
			String savePath=realPath+fileName;
			File copy=new File(savePath); // �̸��� ������ �� ���� ����
			try {
				file.transferTo(copy);
			} catch (Exception e) {
				e.printStackTrace();
			}
			lecDataDTO.setLec_data_path("\\teacher\\lecData"+lecDataDTO.getSub_lec_code()+"_"+fileName);
			
			/*
		 	����� �����ϱ� http://tskwon.tistory.com/283 
		 	Image image = JimiUtils.getThumbnail(�������� path + ���ϸ� + Ȯ����, width �� , height �� , Jimi.IN_MEMORY);

			//������ ���ϴ� width�� height ���� ������¡ �� ũ�⸦ �� �մϴ�.

			Jimi.putImage(image, ������� ������ path + ������ �����̸� + Ȯ����);
			
			ex)
			Image image=JimiUtils.getThumbnail(realPath+fileName, 10, 10,  Jimi.IN_MEMORY);
			try {
				Jimi.putImage(image, realPath+"tn_"+fileName);
			} catch (JimiException e) {
				e.printStackTrace();
			}
			 */
			
		}
		
		//DB�� ����
		System.out.println(lecDataDTO.getLec_data_path());
		sqlMap.update("insertLecData", lecDataDTO);
		
		multi.setAttribute("lecDataDTO", lecDataDTO);
		multi.setAttribute("state", new Integer(1));
		
		return "/teacher/myClass/lectureMake/teacher_uploadFile_popup.jsp";
	}
	
	// �ڷ� ���� �˾�
	@RequestMapping("teacher/viewData.mooc")
	public String viewData(HttpServletRequest request,String lec_data_path){
		request.setAttribute("lec_data_path", lec_data_path);
		
		return "/teacher/myClass/lectureMake/teacher_viewData.jsp";
	}
	
	// ���갭�� ����
	@RequestMapping("teacher/modifyRecordLec.mooc")
	public String modifySubLec(MultipartHttpServletRequest multi,LectureDTO lectureDTO,String currentPage,String before_file){
		System.out.println(lectureDTO.getSub_lec_chapter());
		if(!multi.getFile("after_file").getOriginalFilename().equals("")){//���ο� ������ ��,
			System.out.println("���ο�����");
			String realPath=multi.getRealPath("files");
			System.out.println("������ ����"+realPath+before_file);
			//���� ���� ����
			File file=new File(realPath+before_file);
			if(file.exists()){	System.out.println("��������"); file.delete(); }
			
			//�� ���� ����
			MultipartFile newfile=multi.getFile("after_file");
			String fileName=lectureDTO.getMain_lec_code()+"_"+lectureDTO.getSub_lec_chapter()+"_media_"+newfile.getOriginalFilename();
			String savePath=realPath+"\\teacher\\"+fileName;
			System.out.println("������"+savePath);
			File copy=new File(savePath); // �̸��� ������ �� ���� ����
			try {
				newfile.transferTo(copy);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//DTO�� ���ϰ�� ����
			lectureDTO.setSub_lec_media("\\teacher\\"+fileName);
		}else{ // ���� ������ ��
			System.out.println("��������");
			lectureDTO.setSub_lec_media(before_file);
		}
				
		//DB�� ������� ����
		sqlMap.update("updateSubLec", lectureDTO);
		
		//���� �ڷ� �������
		String deleteData[]=multi.getParameterValues("deleteData");
		
		//�ϴ� �����ڷ� ����
		if(deleteData!=null){
			for(int i=0;i<deleteData.length;i++){
				System.out.println(deleteData[i]);
				//���� ���� ����
				String filePath=(String) sqlMap.queryForObject("selectLecDataFile",Integer.parseInt(deleteData[i]));
				String realPath=multi.getRealPath("files");
				File deleteFile=new File(realPath+filePath);
				if(deleteFile.exists()){  System.out.println("���� ����"); deleteFile.delete(); }
				sqlMap.delete("deleteLecData", Integer.parseInt(deleteData[i]));
				sqlMap.delete("deletePPTImage", lectureDTO.getSub_lec_code());
			}
		}
		
		return "forward:/teacher/watch.mooc";
	}
	
	
	// �ǽð� ���� ����
		@RequestMapping("teacher/modifyLiveLec.mooc")
		public String modifyLiveLec(MultipartHttpServletRequest multi,LectureDTO lectureDTO,String currentPage){
			System.out.println(lectureDTO.getSub_lec_chapter());

			//DB�� ������� ����
			sqlMap.update("updateSubLec", lectureDTO);
			
			//���� �ڷ� �������
			String deleteData[]=multi.getParameterValues("deleteData");
			
			//�ϴ� �����ڷ� ����
			if(deleteData!=null){
				for(int i=0;i<deleteData.length;i++){
					System.out.println(deleteData[i]);
					//���� ���� ����
					String filePath=(String) sqlMap.queryForObject("selectLecDataFile",Integer.parseInt(deleteData[i]));
					String realPath=multi.getRealPath("files");
					File deleteFile=new File(realPath+filePath);
					if(deleteFile.exists()){  System.out.println("���� ����"); deleteFile.delete(); }
					sqlMap.delete("deleteLecData", Integer.parseInt(deleteData[i]));
				}
			}
			
			return "forward:/teacher/watch.mooc";
		}
}
