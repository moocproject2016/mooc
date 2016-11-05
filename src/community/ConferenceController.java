package community;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ConferenceController {

	@RequestMapping("/conferenceRoom.mooc")
	//myStudy ∏ﬁ¿Œ
	public String conferenceRoom(HttpServletRequest request, int stg_code){
		request.setAttribute("stg_code", stg_code);
		return "/community/myConferenceRoom/commu_conferenceRoom.jsp";
	}
}