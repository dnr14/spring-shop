package dev.mvc.stock;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.javassist.expr.Instanceof;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import dev.mvc.cateGroup.cateGroupProcInter;
import dev.mvc.tool.StockPageMaker;
import sun.security.jca.GetInstance.Instance;

@Controller()
@RequestMapping("/stock")
public class stockCnt {

	@Autowired
	@Qualifier("stockProc")
	stockProcInter stockProc;

	@Autowired
	@Qualifier("cateGroupProc")
	cateGroupProcInter cateGroupProc;

	public stockCnt() {
		System.out.println("stockCnt ==>  stockCnt 의존성 생성");
	}

	/**
	 * 재고 화면
	 * 
	 * @return
	 */
	@GetMapping("/create")
	public ModelAndView stockForm(@RequestParam(value = "pagenum", defaultValue = "1") int pagenum) {

		ModelAndView mav = new ModelAndView("/stock/stockView");
		StockPageMaker pm = new StockPageMaker();

		int stockCount = stockProc.selectStockCount();
		if (stockCount > 0) {

			pm.setTotalcount(stockCount);
			pm.setPagenum(pagenum);
			pm.setStartPageNum();
			pm.setEndPageNum();

			pm.setCurrentBlock();
			pm.setLastBlock();

			pm.setStartPage();
			pm.setEndPage(pm.getLastBlock(), pm.getCurrentBlock());

			pm.prevnext();

			System.out.println(pm.toString());

			HashMap<String, Object> map = new HashMap<>();
			map.put("startPageNum", pm.getStartPageNum());
			map.put("endPageNum", pm.getEndPageNum());
			mav.addObject("list", stockProc.selectStock(map));
			mav.addObject("pm", pm);
		}

		mav.addObject("stockCateGroup", cateGroupProc.stockCateGroup());
		mav	.addObject("stockCreateRequest", new stockCreateRequest());

		return mav;
				
	}

	/**
	 * 재고 등록
	 * 
	 * @param scr
	 * @param errors
	 * @return
	 */
	@PostMapping("/create")
	public ModelAndView createProc(stockCreateRequest scr, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "stockName", "required", "재고 이름은 필수 입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "manager", "required", "등록자 이름은 필수 입니다.");

		if (scr.getStockCnt() > 99) {
			errors.rejectValue("stockCnt", "bad", "재고 갯수는 99개까지 등록 가능합니다.");
		} else if (scr.getStockCnt() == 0) {
			errors.rejectValue("stockCnt", "bad", "재고 갯수는 0개이상 등록 가능합니다.");
		}

		if (scr.getStockPrice() == 0) {
			errors.rejectValue("stockPrice", "bad", "재고 가격은 0원이상 등록 가능합니다.");
		}

		if (errors.hasErrors()) {
			return new ModelAndView("/stock/stockView").addObject("stockCateGroup", cateGroupProc.stockCateGroup());
		}

		// 재고 등록
		stockProc.create(scr);
		return new ModelAndView("redirect:/stock/create");
	}

	/**
	 * 재고 삭제
	 * 
	 * @param map
	 * @return
	 */
	@PostMapping("/delete")
	@ResponseBody
	public String stockDeleteAjax(@RequestBody HashMap<String, Object> map) {
		JSONObject json = new JSONObject();

		ArrayList<String> list = (ArrayList<String>) map.get("array");

		int count = 0;

		for (String stockNo : list) {
			count += stockProc.delete(Integer.parseInt(stockNo));
		}

		if (count != list.size()) {
			json.put("result", "재고 일부를 삭제하지 못했습니다.");
		} else {
			StockPageMaker pm = new StockPageMaker();
			int pagenum = (int) map.get("pagenum");
			pm.setPagenum(pagenum);
			pm.setStartPageNum();
			pm.setEndPageNum();

			map.put("startPageNum", pm.getStartPageNum());
			map.put("endPageNum", pm.getEndPageNum());

			if (stockProc.selectStock(map).stream().count() == 0) {
				pagenum--;
			}

			json.put("result", "재고를 삭제 했습니다.");
			json.put("pagenum", pagenum);
		}

		return json.toString();
	}

	/**
	 * 재고 수정 불러오기
	 * 
	 * @param stockNo
	 * @return
	 */
	@PostMapping(value = "/update", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String stockUpdateAjax(int stockNo) {
		JSONObject json = new JSONObject();

		try {
			String string = "";
			string = new ObjectMapper().writeValueAsString(stockProc.update(stockNo));
			json.put("stockVO", string);
			json.put("cateGroup", cateGroupProc.stockCateGroup());

		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return json.toString();
	}

	/**
	 * 재고 수정 Proc
	 * 
	 * @param stockNo
	 * @return
	 */
	@PostMapping(value = "/updateProc", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String stockUpdateProcAjax(stockVO stockVO) {
		JSONObject json = new JSONObject();
		int count = stockProc.updateProc(stockVO);
		json.put("count", count);
		return json.toString();
	}

}
