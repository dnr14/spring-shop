package dev.mvc.cateGroup;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping(value="/cateGroup")
public class cateGroupCnt {

	@Qualifier("cateGroupProc")
	@Autowired
	cateGroupProcInter cateGroupProc;

	public cateGroupCnt() {
		System.out.println("cateGroupCnt ==>  cateGroupCnt 의존성 생성");
	}

	@GetMapping("/create")
	public ModelAndView cateGroupView() {

		ModelAndView model = new ModelAndView("categroup/cateGroupView");
		model.addObject("cateGroupCreateRequest", new cateGroupCreateRequest());
		model.addObject("cateGroupList", cateGroupProc.list());
		return model;
	}

	/**
	 * 카테고리 생성
	 * @param cgc
	 * @param errors
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/create")
	public ModelAndView cateGroupView(cateGroupCreateRequest cgc, Errors errors) throws Exception {
		int cateGroupCount = cateGroupProc.cateGroupCount();
		String View = "redirect:/cateGroup/create.do";

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "categrpName", "required", "카테고리 이름은 필수 입니다.");

		if (cgc.getCategrpSeqno() > 5) {
			errors.rejectValue("categrpSeqno", "bad", "5 이상은 입력 불가능 합니다.");
		}

		if (cateGroupCount == 5) {
			return new ModelAndView("categroup/cateGroupView").addObject("Excess", "카테고리는 5개 이상 등록이 불가능 합니다.")
					.addObject("cateGroupList", cateGroupProc.list());
		}

		if (errors.hasErrors()) {
			return new ModelAndView("categroup/cateGroupView").addObject("cateGroupList", cateGroupProc.list());
		}

		cateGroupProc.create(cgc);
		return new ModelAndView(View);
	}

	/**
	 * 카테고리 삭제
	 * 
	 * @param map
	 * @return
	 */
	@PostMapping(value = "/cateGroupDelete", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String cateGroupDelete(@RequestBody HashMap<String, ArrayList<Integer>> map) {
		for (int categrpNo : map.get("array")) {
			cateGroupProc.cateGroupDelete(categrpNo);
		}
		JSONObject jsonobejct = new JSONObject();
		jsonobejct.put("message", "모두 삭제 되었습니다.");

		return jsonobejct.toString();
	}

	/**
	 * 카테고리 사이드 메뉴 출력
	 * 
	 * @return
	 */
	@RequestMapping(value = "/cateGroupSideList", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView cateGroupSideList() {
		return new ModelAndView("menu/cateGroupList").addObject("cateGroupSideList", cateGroupProc.cateGroupSideList());
	}

	/**
	 * 카테고리 수정 내용 가져오기
	 * 
	 * @param VO
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/cateGroupUpdate", produces = "text/plain;charset=UTF-8")
	public String cateGroupUpdate(cateGroupVO vo) {
		JSONObject jsonobject = new JSONObject();
		String string = "";
		try {
			string = new ObjectMapper().writeValueAsString(cateGroupProc.cateGroupUpdateForm(vo));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		jsonobject.put("cateGroupVO", string);
		return jsonobject.toString();
	}
	
	
	/**
	 * 카테고리 수정 로직
	 * @param vo
	 * @return count 1 이상 성공 count 0 실패 
	 */
	@ResponseBody
	@PostMapping(value="/cateGroupUpdateProc", produces="text/plain;charset=UTF-8")
	public String cateGroupUpdateProc(cateGroupVO vo) {
		System.out.println(vo.toString());
		int count = cateGroupProc.cateGroupUpdateProc(vo);
		System.out.println(count);
		JSONObject jsonobject = new JSONObject();
		jsonobject.put("count", count);
		return jsonobject.toString();
	}
	
	/**
	 * 네브바 목록
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="/cateGroupTopList", produces="text/plain;charset=UTF-8")
	public String cateGroupTopList() {
		return new JSONObject().put("list", cateGroupProc.cateGroupTopList())
				.toString();
	}

}
