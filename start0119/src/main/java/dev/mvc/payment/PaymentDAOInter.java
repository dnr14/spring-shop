package dev.mvc.payment;

import java.util.List;
import java.util.Map;

import dev.mvc.tool.DeliveryPageMaker;

public interface PaymentDAOInter {
	public List<PaymentVO> list(String memberId);

	public List<PaymentVO> select(String memberId);

	public int create(PaymentCreateDTO paymentCreateDTO);
	
	public List<PaymentVO> delivery(DeliveryPageMaker pageMaker);
	
	public int update(Map<String, Object> map);
	
	public PaymentVO detail(int orderNo);
	public int count(Map<String, Object> map);
	
}