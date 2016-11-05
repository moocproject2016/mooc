package community;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartFile;
import _dto.StudygroupBoardDTO;

@Controller
public class CommuBoardController {
	
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	String main = "/community/_commu_main.jsp";
	String content; // �� main �������� container �κп� �� content ����
	String commu_main = "myStudyRoom/_commu_myStudyRoom_main.jsp";
	
	
	@RequestMapping("/study/myStudyBoardWrite.mooc")
	//�Խ��� �ۼ���
	public String myStudyBoardWrite_main(HttpServletRequest request){
		HttpSession session = request.getSession();
		int stg_code = (int) session.getAttribute("code");
		
		content="board/commu_studyBoardWrite.jsp";
		request.setAttribute("community_main_content", commu_main);
		request.setAttribute("commu_myStudy_content", content);
		return main;
	}
	
	@RequestMapping("/study/myStudyBoardWritePro.mooc")
	//�Խ��� �ۼ� ����
		public String myStudyBoardWritePro(MultipartHttpServletRequest multi, StudygroupBoardDTO sgbdto){
			HttpSession session= multi.getSession();
			int stg_code = (int) session.getAttribute("code");
			int stg_b_num=(int) sqlMap.queryForObject("seqStudyBoard", null);
			stg_b_num++;
			
			MultipartFile file=multi.getFile("save");
			String realPath=multi.getRealPath("files")+"\\user\\StudyBoard_"+stg_b_num+"_";
			System.out.println(realPath);
			String filename=file.getOriginalFilename();
			File copy=new File(realPath+filename);
			try{
				file.transferTo(copy);
			}catch (Exception e) {e.printStackTrace();}
			sgbdto.setStg_b_data("\\user\\StudyBoard_"+stg_b_num+"_"+filename);
			sgbdto.setStg_code(stg_code);
			sqlMap.insert("insertStudyBoard", sgbdto);
			
			multi.setAttribute("community_main_content", commu_main);
			multi.setAttribute("commu_myStudy_content", content);
			multi.setAttribute("stg_b_num",stg_b_num);
			
			return "forward:/study/myStudyBoardRoom.mooc";
		}
	
	@RequestMapping("/study/myStudyBoardRoom.mooc")
	//�Խ��� ���� ���� 
	public String myStudyBoardRoom_main(HttpServletRequest request){
		HttpSession session = request.getSession();
		int stg_code = (int) session.getAttribute("code");
		
		int stg_b_num=0;
		//writeForm���� �Ѱܹ޾��� ��, setAttribute�� ���ؼ� �Ѿ�Ա� ������ getAttribute("notice_num")!=null�� true�� �ȴ�.
		if(request.getAttribute("stg_b_num")!=null){
			stg_b_num=(int) request.getAttribute("stg_b_num");
			System.out.println("ss"+stg_b_num);
		//list���� �Ѿ���� ��, /mooc/notice_content.mooc?notice_num=${dto.notice_num}�� ���� �Ѿ���� ������ getParameter("notice_num")!=null�� true�� �ȴ�.
		}else if(request.getParameter("stg_b_num")!=null){
			
			stg_b_num=Integer.parseInt(request.getParameter("stg_b_num"));
			System.out.println("sa"+stg_b_num);
		}
		
		StudygroupBoardDTO sgbdto=(StudygroupBoardDTO)sqlMap.queryForObject("resultStudyBoard",stg_b_num);
		request.setAttribute("sgbdto", sgbdto);
		
		content="board/commu_studyRoom.jsp";
		request.setAttribute("community_main_content", commu_main);
		request.setAttribute("commu_myStudy_content", content);
		return main;
	}
	
	@RequestMapping("/study/myStudyBoardModify.mooc")
	//���͵� �Խ��� ����
		public String modifyForm_main(HttpServletRequest request, int stg_b_num){
			
			StudygroupBoardDTO sgbdto=(StudygroupBoardDTO)sqlMap.queryForObject("resultStudyBoard", stg_b_num);
			request.setAttribute("sgbdto", sgbdto);
			
			content="board/commu_studyBoardModify.jsp";
			
			request.setAttribute("community_main_content", commu_main);
			request.setAttribute("commu_myStudy_content", content);
			return main;
		}
	
	@RequestMapping("/study/myStudyBoardModifyPro.mooc")
	//���͵� �Խ��� ���� ����
		public String modifyFormPro(MultipartHttpServletRequest multi, StudygroupBoardDTO sgbdto){
			
			MultipartFile file=multi.getFile("save");
			String realPath=multi.getRealPath("files")+"\\user\\StudyBoard_"+sgbdto.getStg_b_num()+"_";
			
			String filename=file.getOriginalFilename();
			if(!filename.equals("")){//file�� ������ ������.
				File deleteFile=new File(multi.getRealPath("files")+sgbdto.getStg_b_data());
				if(deleteFile.exists()){ deleteFile.delete(); }
				File copy=new File(realPath+filename);
				try{
					file.transferTo(copy);
				}catch (Exception e) {e.printStackTrace();}
				sgbdto.setStg_b_data("\\user\\StudyBoard_"+sgbdto.getStg_b_num()+"_"+filename); //DB�� ����Ǵ� ��
			}
			sqlMap.update("updateStgBoard", sgbdto);
			multi.setAttribute("sgbdto", sgbdto);
			
			multi.setAttribute("community_main_content", commu_main);
			multi.setAttribute("commu_myStudy_content", content);
			return "forward:/study/myStudyBoardRoom.mooc";
		}
	
	@RequestMapping("/study/myStudyBoardDelete.mooc")
	//���͵� �Խ��� ����
		public String StudyGroupDelete(HttpServletRequest request, int stg_b_num){
			
			sqlMap.delete("deleteStgboard", stg_b_num);
			
			content="board/commu_studyBoardDelete.jsp";
			request.setAttribute("main_content", content);
			return "forward:/study/myStudyBoardList.mooc";
		}
	
	@RequestMapping("/study/myStudyBoardDownload.mooc")
	//���͵� �Խ��� ÷������ �ٿ�ε�
		public ModelAndView myStudyBoardDownload(HttpServletRequest request, String fileName){
			String realPath=request.getRealPath("files");
			File down=new File(realPath+fileName);
			ModelAndView mv=new ModelAndView("download", "downloadFile", down);
			return mv;
		}
	
	@RequestMapping(value="study/getSubCtg.mooc",method=RequestMethod.POST)
	//������ ���ΰ��ǿ� ���� ���갭�� ����� ������
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
}