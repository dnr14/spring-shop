package dev.mvc.stock;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

import dev.mvc.cateGroup.cateGroupProcInter;

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
	 * @return
	 */
	@GetMapping("/create")
	public ModelAndView stockForm() {
		
		for(stockVO vo : stockProc.selectStock()) {
			System.out.println(vo.toString());
		}
		
		return new ModelAndView("/stock/stockView")
				.addObject("stockCateGroup", cateGroupProc.stockCateGroup())
				.addObject("stockCreateRequest", new stockCreateRequest())
				.addObject("list", stockProc.selectStock());
		
	}
	
	/**
	 * 재고 등록
	 * @param scr
	 * @param errors
	 * @return
	 */
	@PostMapping("/create")
	public ModelAndView createProc(stockCreateRequest scr ,Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "stockName", "required", "재고 이름은 필수 입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "manager", "required", "등록자 이름은 필수 입니다.");
		
		if(scr.getStockCnt()  > 99) {
			errors.rejectValue("stockCnt", "bad", "재고 갯수는 99개까지 등록 가능합니다.");
		}else if(scr.getStockCnt() == 0){
			errors.rejectValue("stockCnt", "bad", "재고 갯수는 0개이상 등록 가능합니다.");
		}
		
		if(scr.getStockPrice() == 0) {
			errors.rejectValue("stockPrice", "bad", "재고 가격은 0원이상 등록 가능합니다.");
		}
		
		if(errors.hasErrors()) {
			return new ModelAndView("/stock/stockView")
					.addObject("stockCateGroup", cateGroupProc.stockCateGroup());
		}
		
		// 재고 등록
		stockProc.create(scr);
		return new ModelAndView("redirect:/stock/create");
	}
	
	
	
	
	
}
