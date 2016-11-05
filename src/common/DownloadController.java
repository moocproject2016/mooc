package common;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DownloadController {
	//공지사항 파일 다운로드	
		@RequestMapping("/Download.mooc")
		public ModelAndView tNoticeFileDownload(HttpServletRequest request, String fileName){
			String realPath=request.getRealPath("files");
			System.out.println(realPath+fileName);
			File down=new File(realPath+fileName);
			ModelAndView mv=new ModelAndView("download", "downloadFile", down);
			return mv;
		}
}
