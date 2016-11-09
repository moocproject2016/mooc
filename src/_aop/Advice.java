package _aop;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

@Aspect
public class Advice {
	@Autowired
	SqlMapClientTemplate sqlMap;
	
	@Around("execution(public String adm_*(..))")
	public Object before(ProceedingJoinPoint jp) throws Throwable{
		HttpServletRequest request=(HttpServletRequest)jp.getArgs()[0];
		System.out.println(jp.getTarget());
		HttpSession session=request.getSession();
		String id=(String) session.getAttribute("memId");
		if(id==null){
			return "redirect:/user/loginError.mooc";
		}else{
			int u_type=(int) sqlMap.queryForObject("checkAdmin", id);
			if(u_type!=2){
				return "redirect:/admin/adminError.mooc";
			}
			return jp.proceed();
		}
	}
	@After("execution(public String *_main(..))")
	public void after(JoinPoint jp){
		System.out.println("after");
		
		
		HttpServletRequest request=(HttpServletRequest)jp.getArgs()[0]; // ���� ��з� ����Ʈ
		
		List topCtgList=sqlMap.queryForList("selectAllTopCtg",null);
		List subCtgList=sqlMap.queryForList("selectAllSubCtg",null);
		request.setAttribute("topCtgList", topCtgList);
		request.setAttribute("subCtgList", subCtgList);
		
		HttpSession session=request.getSession(); // ���� ���͵� ����Ʈ
		if(session!=null){
			String u_id=(String) session.getAttribute("memId");
			int t_idCount=0;
			if((Integer)sqlMap.queryForObject("t_idfro",u_id)!=null){
				t_idCount=(Integer)sqlMap.queryForObject("t_idfro",u_id);
			}
			List mystudylist = sqlMap.queryForList("myselectlist", u_id);
			
			String u_name= (String) sqlMap.queryForObject("getU_name", u_id);
			request.setAttribute("t_idCount",t_idCount);
			request.setAttribute("u_id",u_id);
			request.setAttribute("u_name",u_name);
			request.setAttribute("mystudylist_main",mystudylist);
		}
		
	}	
}
