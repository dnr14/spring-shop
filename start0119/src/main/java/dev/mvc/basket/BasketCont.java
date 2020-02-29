package dev.mvc.basket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.memberLoginCheck;

@Controller
@RequestMapping("/basket")
public class BasketCont {

	@Autowired
	BasketProcInter basketProc;
	
	@GetMapping("/add")
	public @ResponseBody String add(
			@RequestParam("stockNo") int stockNo,
			@RequestParam("title") String stockName,
			@RequestParam("cnt") int stockCnt,
			@RequestParam("uri") String uri,
			@RequestParam("contentsNo") int contentsNo,
			HttpSession session
			) {
		
		
		JSONObject json = new JSONObject();
		Map<String, Object> map = new HashMap<String, Object>();
		String id = session.getAttribute("id").toString();
		map.put("stockNo", stockNo);
		map.put("stockName", stockName);
		map.put("stockCnt", stockCnt);
		map.put("uri", uri);
		map.put("contentsNo", contentsNo);
		map.put("memberId", id);
		
		int totalcount = basketProc.fivecount(id);
		System.out.println(totalcount);
		if(totalcount != 5) {
			int duplicate_count = basketProc.count(map);
			if(duplicate_count == 0) {
				int count =basketProc.create(map);
				if(count > 0) {
					json.put("result", "ok");
				}
			}else {
				json.put("result", "duplicate");
			}
		}else {
			json.put("result", "over");
		}
	
		return json.toString();
	}
	
	@GetMapping("/list")
	public ModelAndView Basket(HttpSession session) {
		ModelAndView mav = new ModelAndView("basket/list");
		if(session.getAttribute("id") ==null) {
			return new ModelAndView("member/login").addObject("memberLoginCheck", new memberLoginCheck());
		}
		String id = session.getAttribute("id").toString();
		
		List<BasketVO> list = basketProc.getbasket(id);
		mav.addObject("list",list);
		return mav;
	}
	
	
	@PostMapping("/delete")
	public @ResponseBody String delete(@RequestBody Map<String, ArrayList<String>> map , HttpSession session) {
		if(session.getAttribute("id") == null) {
			return new JSONObject().put("result", "fail").toString();
		}
		JSONObject json = new JSONObject();
		String id = session.getAttribute("id").toString();
		HashMap<String, Object> mm = new HashMap<>();
		mm.put("memberId", id);
		
		map.get("list").stream().forEach(action->{
			mm.put("basketNo", action);
			basketProc.delete(mm);
		});
		json.put("result", "ok");
		return json.toString();
	}
	
	
}
