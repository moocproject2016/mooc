package admin;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import _dto.QnAListDTO;
import _dto.UserDTO;
import user.EmailAuthentication;

@Controller
public class AdminController {
	
	String main = "/admin/_admin_main.jsp";
	String content; // �� main �������� container �κп� �� content ����
	
	@Autowired
	SqlMapClientTemplate sqlMap;

	@RequestMapping("/admin.mooc")
	//admin ����������
		public String adm_main(HttpServletRequest request, QnAListDTO qna_dto){
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null)
			{
				pageNum="1";
			}
			List array=(List)sqlMap.queryForList("qnalist", qna_dto);
			
			
			int pageSize = 4;//�� �������� ���� ����
	        int currentPage = Integer.parseInt(pageNum);
	        int startRow = (currentPage - 1) * pageSize ;//�� �������� ���۱� ��ȣ
	        int endRow = currentPage * pageSize-1;//�� �������� ������ �۹�ȣ
	        int count = array.size();
	        if(count<endRow){
	        	endRow=count;
	        }
	        
	       List<QnAListDTO> list=new ArrayList<QnAListDTO>(endRow-startRow);
	       if (count > 0) {
	        	while(endRow>startRow)
	        	{
	        		
	        		QnAListDTO qna=(QnAListDTO)array.get(startRow);
	        		list.add(qna);
	        		startRow++;
	        	}
	       }
	       if(count>endRow){
	    	   QnAListDTO qna=(QnAListDTO)array.get(startRow);
	    	   list.add(qna);
	       }
       	request.setAttribute("pageSize",pageSize);
       	request.setAttribute("currentPage",currentPage);
       	request.setAttribute("count", count);
		request.setAttribute("list", list);
		
		//����
		int student=(Integer)sqlMap.queryForObject("studentStats", null);
		int blackStats=(Integer)sqlMap.queryForObject("blackStats", null);
		int teacherStats=(Integer)sqlMap.queryForObject("teacherStats", null);
		List userlist=(List)sqlMap.queryForList("userinfo", null);
		Iterator iter=userlist.iterator();
		
		_dto.UserDTO dto;
		Calendar cal=Calendar.getInstance();
		cal.setTimeInMillis(System.currentTimeMillis());
		SimpleDateFormat simpleToday=new SimpleDateFormat("yy-MM-dd");
		SimpleDateFormat simple=new SimpleDateFormat("yy-MM");
		
		String date=simpleToday.format(cal.getTime());
		cal.add(Calendar.DATE,-1);
		String date_1=simple.format(cal.getTime())+"-01";
		cal.add(Calendar.MONTH ,-1);
		String date_2=simple.format(cal.getTime())+"-01";
		cal.add(Calendar.MONTH ,-1);
		String date_3=simple.format(cal.getTime())+"-01";
		cal.add(Calendar.MONTH ,-1);
		String date_4=simple.format(cal.getTime())+"-01";
		cal.add(Calendar.MONTH ,-1);
		String date_5=simple.format(cal.getTime())+"-01";
		Date day =null;
		Date day_1 =null;
		Date day_2 =null;
		Date day_3 =null;
		Date day_4 =null;
		Date day_5 =null;
		Date day_6;
		int dayCount=0;
		int dayCount_1=0;
		int dayCount_2=0;
		int dayCount_3=0;
		int dayCount_4=0;
		int dayCount_5=0;
		int userCount=0;
		try {
			day=simple.parse(date);
			day_1=simple.parse(date_1);
			day_2=simple.parse(date_2);
			day_3=simple.parse(date_3);
			day_4=simple.parse(date_4);
			day_5=simple.parse(date_5);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		while(iter.hasNext()){
			dto=(_dto.UserDTO)iter.next();
			Timestamp stamp=dto.getU_indate();
			userCount++;
			stamp.getDate(); //��¥
			stamp.getMonth();
			stamp.getYear();
			String i=stamp.getYear()+"-"+(stamp.getMonth()+1)+"-"+stamp.getDate();
			i=i.substring(1);
			try {
				day_6=simple.parse(i);
				if(day_6.before(day_5)){
					dayCount_5++;
				}else if(day_6.before(day_4)){

					dayCount_4++;
				}else if(day_6.before(day_3)){
					dayCount_3++;
				}else if(day_6.before(day_2)){

					dayCount_2++;
				}else if(day_6.before(day_1)){

					dayCount_1++;
				}else{
					dayCount++;
				}

			}catch(Exception e){}

		}
		request.setAttribute("userCount", userCount);
		String[] dat5=date_5.split("-");
		String[] dat4=date_4.split("-");
		String[] dat3=date_3.split("-");
		String[] dat2=date_2.split("-");
		String[] dat1=date_1.split("-");
		String[] dat=date.split("-");
		request.setAttribute("date_5_1", dat5[1]);
		request.setAttribute("date_4_1", dat4[1]);
		request.setAttribute("date_3_1", dat3[1]);
		request.setAttribute("date_2_1", dat2[1]);
		request.setAttribute("date_1_1", dat1[1]);
		request.setAttribute("date_0_1", dat[1]);
		request.setAttribute("date_0_2", dat[2]);
		request.setAttribute("date_5",	"20"+dat5[0]);
		request.setAttribute("date_4", "20"+dat4[0]);
		request.setAttribute("date_3", "20"+dat3[0]);
		request.setAttribute("date_2", "20"+dat2[0]);
		request.setAttribute("date_1", "20"+dat1[0]);
		request.setAttribute("date", "20"+dat[0]);
		
		request.setAttribute("dayCount_5", dayCount_5);
		request.setAttribute("dayCount_4", dayCount_4);
		request.setAttribute("dayCount_3", dayCount_3);
		request.setAttribute("dayCount_2", dayCount_2);
		request.setAttribute("dayCount_1", dayCount_1);
		request.setAttribute("dayCount", dayCount);
		request.setAttribute("student", student);
		request.setAttribute("blackStats", blackStats);
		request.setAttribute("teacherStats", teacherStats);
		
		//���
		
		content="_admin_main_container.jsp";
		request.setAttribute("admin_main_content", content);
		return main;
	}
	
	@RequestMapping("/admin/qnaWrite.mooc")
	//QnA ������ �亯
	public String qnamodify(HttpServletRequest request){
		
		String c_con=request.getParameter("c_content");
		String q_num=request.getParameter("q_num");
		HashMap map = new HashMap();
		map.put("c_content",c_con);
		map.put("q_num", q_num);
		
		sqlMap.update("qnaupdate", map);
		return "redirect:/admin.mooc";
	}
	
	@RequestMapping("/admin/qnaDelete.mooc")
	//QnA ������ ����
	public String qnadelete(HttpServletRequest request){
		String indexList[] = request.getParameter("checkIndex").split(",");
		
		for(int i=0; i < indexList.length; i++){
			sqlMap.delete("qnadelete", Integer.parseInt(indexList[i]));
		}
		return "redirect:/admin.mooc";
	}
	
				
	
	@RequestMapping("/admin/accessList.mooc")
	//������Ȳ
		public String adm_accessList(HttpServletRequest request, UserDTO admin_dto){
		
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null)
			{
				pageNum="1";
			}
			List array=(List)sqlMap.queryForList("humanlist", admin_dto);

			
			int pageSize = 4;//�� �������� ���� ����
	        int currentPage = Integer.parseInt(pageNum);
	        int startRow = (currentPage - 1) * pageSize ;//�� �������� ���۱� ��ȣ
	        int endRow = currentPage * pageSize-1;//�� �������� ������ �۹�ȣ
	        int count = array.size();
	        if(count<endRow){
	        	endRow=count;
	        }
	        
	       List<UserDTO> list=new ArrayList<UserDTO>(endRow-startRow);
	       if (count > 0) {
	        	while(endRow>startRow)
	        	{
	        		
	        		UserDTO user=(UserDTO)array.get(startRow);
	        		list.add(user);
	        		startRow++;

	        	}
	       }
	       if(count>endRow){
	    	   UserDTO user=(UserDTO)array.get(startRow);
	    	   list.add(user);
	
	       }
		   	request.setAttribute("pageSize",pageSize);
		   	request.setAttribute("currentPage",currentPage);
		   	request.setAttribute("count", count);
			request.setAttribute("list", list);
			
			content = "admin_accessList.jsp";
			request.setAttribute("admin_main_content", content);
			return main;
		}
	
	
	//----------------------------ȸ�� ���� ����----------------------------//
	
	@RequestMapping("/admin/userList.mooc")
	//��������
		public String adm_userList(HttpServletRequest request){
			String type=request.getParameter("type");
			List list=null;
			if(type==null){
				list = (List)sqlMap.queryForList("userinfo", null);
			}else if(type!=null){
				list = (List)sqlMap.queryForList("usertype", Integer.parseInt(type));
			}
			
			request.setAttribute("list", list);
			
			content = "admin_userList.jsp";
			request.setAttribute("admin_main_content", content);
			return main;
		}
	
	@RequestMapping("admin/userModify.mooc")
	//��ü ����� ��������
		public String modify(UserDTO admin_dto){
			
			sqlMap.update("userupdate", admin_dto);
			return "redirect:/admin/userList.mooc";
		}
	
	
	@RequestMapping("/admin/blackList.mooc")
	//�ҷ����� ����
		public String adm_blackList(HttpServletRequest request){

			List list = (List)sqlMap.queryForList("blacklist", null);
			
			request.setAttribute("list", list);
			
			content = "admin_blackList.jsp";
			request.setAttribute("admin_main_content", content);
			return main;
		}
	
	@RequestMapping("/admin/blackListOut.mooc")
	//�ҷ����� Ż��
		public String blackListOut(HttpServletRequest request, String id){
			
			sqlMap.update("blackistupdate", id);
			return "redirect:/admin/userList.mooc";
			
	}
	
	//----------------------------ȸ�� ���� ��----------------------------//
	
	//----------------------------�Խ��� ���� ����----------------------------//
	
	
	@RequestMapping("/admin/admin_sendEmail.mooc")
		public String admin_sendEmail(HttpServletRequest request){	//�޸հ��� ��������
			String id=request.getParameter("checkIndex");
			String[] u_id=id.split(",");
			
			for(int i=0;i<u_id.length;i++){
				EmailAuthentication.sendSleepMail(u_id[i]);
			}
			return "redirect:/admin/accessList.mooc";
		}
	
	
	@RequestMapping("admin/qnaList.mooc")
	//����
		public String adm_QnAmain(HttpServletRequest request, QnAListDTO qna_dto){
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null)
			{
				pageNum="1";
			}
			List array=(List)sqlMap.queryForList("qnalist1", qna_dto);
			
			
			int pageSize = 10;//�� �������� ���� ����
	        int currentPage = Integer.parseInt(pageNum);
	        int startRow = (currentPage - 1) * pageSize ;//�� �������� ���۱� ��ȣ
	        int endRow = currentPage * pageSize-1;//�� �������� ������ �۹�ȣ
	        int count = array.size();
	        if(count<endRow){
	        	endRow=count;
	        }
	        
	       List<QnAListDTO> list=new ArrayList<QnAListDTO>(endRow-startRow);
	       if (count > 0) {
	        	while(endRow>startRow)
	        	{
	        		
	        		QnAListDTO qna=(QnAListDTO)array.get(startRow);
	        		list.add(qna);
	        		startRow++;
	        	}
	       }
	       if(count>endRow){
	    	   QnAListDTO qna=(QnAListDTO)array.get(startRow);
	    	   list.add(qna);
	       }
		   	request.setAttribute("pageSize",pageSize);
		   	request.setAttribute("currentPage",currentPage);
		   	request.setAttribute("count", count);
			request.setAttribute("list", list);
			
			content="admin_qnaList.jsp";
			request.setAttribute("admin_main_content", content);
			return main;
		}
	
	@RequestMapping("/admin/qnaWriteForm.mooc")	
		public String modify(HttpServletRequest request){	//���ǰԽ��� �亯
			
			String c_con=request.getParameter("c_content");
			String q_num=request.getParameter("q_num");
			HashMap map = new HashMap();
			map.put("c_content",c_con);
			map.put("q_num", q_num);
			
			sqlMap.update("qnaupdate", map);
			return "redirect:/admin/qnaList.mooc";
		}
	
	@RequestMapping("admin/searchqnaList.mooc")
	//����
		public String adm_qnaSearch(HttpServletRequest request, QnAListDTO qna_dto){
			String pageNum=request.getParameter("pageNum");
			List List = null;
			if(pageNum==null)
			{
				pageNum="1";
			}
			
			if(qna_dto.getQ_subject()!=null){
				List = (List)sqlMap.queryForList("search_subject", qna_dto);
			}else if(qna_dto.getU_id()!=null){
				List = (List)sqlMap.queryForList("search_id", qna_dto);
			}
			
			int pageSize = 10;//�� �������� ���� ����
	        int currentPage = Integer.parseInt(pageNum);
	        int startRow = (currentPage - 1) * pageSize ;//�� �������� ���۱� ��ȣ
	        int endRow = currentPage * pageSize-1;//�� �������� ������ �۹�ȣ
	        int count = List.size();
	        if(count<endRow){
	        	endRow=count;
	        }
	        
	       List<QnAListDTO> list=new ArrayList<QnAListDTO>(endRow-startRow);
	       if (count > 0) {
	        	while(endRow>startRow)
	        	{
	        		
	        		QnAListDTO qna=(QnAListDTO)List.get(startRow);
	        		list.add(qna);
	        		startRow++;
	        	}
	       }
	       if(count>endRow){
	    	   QnAListDTO qna=(QnAListDTO)List.get(startRow);
	    	   list.add(qna);
	       }
		   	request.setAttribute("pageSize",pageSize);
		   	request.setAttribute("currentPage",currentPage);
		   	request.setAttribute("count", count);
			request.setAttribute("list", list);
			
			content="admin_qnaList.jsp";
			request.setAttribute("admin_main_content", content);
			return main;
		}
	
	@RequestMapping("/admin/qnaDeleteForm.mooc")	//���� �Խ��� ����
		public String delete(HttpServletRequest request){
			String indexList[] = request.getParameter("checkIndex").split(",");
			
			for(int i=0; i < indexList.length; i++){
				sqlMap.delete("qnadelete1", Integer.parseInt(indexList[i]));
			}
	
			return "redirect:/admin/qnaList.mooc";
		}
	//----------------------------�Խ��� ���� ��----------------------------//
	
	
	@RequestMapping("/admin/adminError.mooc")
	public String error(){
		return "/admin/adminError.jsp";
	}
	
}