package dev.mvc.photo;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dev.mvc.contents.ContentsProcInter;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired @Qualifier("ContentsProc")	
	ContentsProcInter contentsProc;
	
	public HomeController() {
		System.out.println("HomeController 빈 생성 =>");
	}
	
	// dispachservlet url-pattern을 /로 해놓으면 
	// defaultservlet의 url-pattern도 기본 /로 되어있다.
	// 모든 요청은 톰캣이 먼저 받는다.
	// /로 들어온 요청을 캐치하여 
	//
	 /*   <welcome-file-list>
	    <welcome-file>index.html</welcome-file>
	    <welcome-file>index.htm</welcome-file>
	    <welcome-file>index.jsp</welcome-file>
	</welcome-file-list>*/
	// welcome에 등록된 파일이 있는지 찾는다 만약 못찾으면 
	// 톰캣은 dispachservlet한태 권한을 넘겨서 dispachservlet가  url-pattern에 맞는
	// requestMapping을 찾는다.
	@RequestMapping(value="/" , method=RequestMethod.GET)
	public String home(Model model) {
		model.addAttribute("list", contentsProc.index_list());
		return "home";
	}
	
}
