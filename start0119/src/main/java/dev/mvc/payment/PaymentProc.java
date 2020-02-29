package dev.mvc.payment;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.DeliveryPageMaker;
import dev.mvc.tool.PageMaker;

@Component
public class PaymentProc implements PaymentProcInter {

	@Autowired
	PaymentDAOInter paymentDAO;

	@Override
	public List<PaymentVO> list(String memberId) {
		return paymentDAO.list(memberId);
	}

	@Override
	public List<PaymentVO> select(String memberId) {
		return paymentDAO.select(memberId);
	}

	@Override
	public int create(PaymentCreateDTO paymentCreateDTO) {
		return paymentDAO.create(paymentCreateDTO);
	}

	@Override
	public int update(Map<String, Object> map) {
		return paymentDAO.update(map);
	}

	@Override
	public PaymentVO detail(int orderNo) {
		return paymentDAO.detail(orderNo);
	}

	@Override
	public List<PaymentVO> delivery(DeliveryPageMaker pageMaker) {
		return paymentDAO.delivery(pageMaker);
	}

	@Override
	public int count(Map<String, Object> map) {
		return paymentDAO.count(map);
	}
}
