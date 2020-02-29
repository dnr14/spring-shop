package dev.mvc.payment;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.basket.BasketProcInter;
import dev.mvc.member.memberLoginCheck;
import dev.mvc.tool.Random;

@Controller
@RequestMapping("/payment")
public class PaymentCont {

	@Autowired
	PaymentProcInter paymentProc;

	@Autowired
	BasketProcInter basketProc;

	@GetMapping("/create")
	public ModelAndView createForm(HttpSession session) {
		if (session.getAttribute("id") == null) {
			return new ModelAndView("member/login").addObject("memberLoginCheck", new memberLoginCheck());
		}

		String id = session.getAttribute("id").toString();
		List<PaymentVO> list = paymentProc.list(id);

		ModelAndView mav = new ModelAndView("payment/list");
		mav.addObject("list", list);

		return mav;
	}

	@PostMapping("/create")
	public @ResponseBody String createProc(@RequestBody Map<String, Object> map, HttpSession session) {

		JSONObject json = new JSONObject();
		// 배송정보 가져오고
		// 장바구니에 가져오고
		// 배송정보에 맞게 생성
		String kind = map.get("paymentkind").toString();// 결제방법
		String id = session.getAttribute("id").toString();
		
		PaymentCreateDTO dto = new PaymentCreateDTO();
		dto.setOrderName(map.get("ordername").toString());
		dto.setOrderZipcode(map.get("orderzipcode").toString());
		dto.setOrderAddress1(map.get("orderaddress1").toString());
		dto.setOrderAddress2(map.get("orderaddress2").toString());
		dto.setOrderPhone(map.get("ordernumber").toString());
		dto.setKind(map.get("paymentkind").toString());
		dto.setBank(map.get("bank").toString());
		dto.setMemberid(id);

		List<PaymentVO> list = paymentProc.select(id);
		
		if (kind.equals("계좌이체") || kind.equals("신용카드")) {
			dto.setStatus("결제완료");
		} else if (kind.equals("무통장입금")) {
			dto.setStatus("결제 대기 중");
		}
		
		HashMap<String, Object> delete = new HashMap<>();
		Random random = new Random(new StringBuilder());
		
		list.stream().forEach(c->{
			dto.setStockName(c.getStockname());
			dto.setStockPrice(c.getStockprice());
			dto.setStockCnt(c.getCnt());
			dto.setTotalPrice(c.getStockprice(), c.getCnt());
			dto.setStaticNumber(random.getRandom(8));//송장번호
			int count = paymentProc.create(dto);
			if(count > 0) {
				delete.put("basketNo", c.getBasketno());
				delete.put("memberId", id);
				basketProc.delete(delete);
			}
		});
		return json.toString();
	}

}
