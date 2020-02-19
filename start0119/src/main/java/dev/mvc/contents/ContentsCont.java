package dev.mvc.contents;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cateGroup.cateGroupProcInter;
import dev.mvc.tool.PageMaker;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
@RequestMapping("/contents")
public class ContentsCont {

	// 기본 생성자로 주입
	@Autowired
	@Qualifier("ContentsProc") // id값으로 찾아서 주입
	private ContentsProcInter ContentsProc;

	@Autowired
	private cateGroupProcInter cateGroupProc;

	/**
	 * 상품 등록 화면
	 * 
	 * @return
	 */
	@GetMapping("/create")
	public ModelAndView creatForm() {
		return new ModelAndView("contents/create").addObject("ContentsCreateDto", new ContentsCreateDto())
				.addObject("cate", cateGroupProc.stockCateGroup());
	}

	/**
	 * 상품 등록 Proc
	 * 
	 * @param ContentsCreateDto
	 * @param errors
	 * @return
	 */
	@PostMapping("/create")
	public ModelAndView createProc(@ModelAttribute("ContentsCreateDto") ContentsCreateDto ContentsCreateDto,
			Errors errors, HttpServletRequest request) {

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "required", "내용은 필수 입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "keyword", "required", "keyword는 필수 입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "contents", "required", "내용은 필수 입니다.");

		if (ContentsCreateDto.getCategrpNo() == 0) {
			errors.rejectValue("categrpNo", "error", "카테고리를 선택하세요.");
		}
		if (ContentsCreateDto.getStockNo() == 0) {
			errors.rejectValue("stockNo", "error", "상품을 선택하세요.");
		}
		if (ContentsCreateDto.getDeliveryCharge() < 0 || ContentsCreateDto.getDeliveryCharge() > 9999) {
			errors.rejectValue("deliveryCharge", "error", "배송비는 0원 부터 9999원 까지 가능합니다.");
		}
		if (errors.hasErrors()) {
			return new ModelAndView("contents/create").addObject("cate", cateGroupProc.stockCateGroup());
		}

		// 내용 생성
		int count = ContentsProc.create(ContentsCreateDto);

		if (count == 1) {
			int contentsNo = ContentsProc.cotentsNoSelect();

			// 카테고리 cnt 증가
			cateGroupProc.cateGroupCntUp(ContentsCreateDto.getCategrpNo());

			String upDir = Tool.getRealPath(request, "/contents/storage");

			List<MultipartFile> fnamesMF = ContentsCreateDto.getFnamesMF();

			// 이미지가 있으면
			if (fnamesMF.get(0).getSize() > 0) {
				String fname = "";
				String fupname = "";
				long fsize = 0;

				int fnamesMF_count = fnamesMF.size(); // 전송 파일 갯수

				if (fnamesMF_count > 0) {

					HashMap<String, Object> map = new HashMap<String, Object>();
					for (MultipartFile multipartFile : fnamesMF) { // 파일 추출
						fsize = multipartFile.getSize();
						if (fsize > 0) {
							fname = multipartFile.getOriginalFilename();
							
							if(!Tool.isImage(fname)) {
								return new ModelAndView("contents/contentsFail").addObject("error", "확장자 오류 jpg, jpeg, png, gif만 가능");
							}
							// 업로드 후 파일 이름 리턴
							fupname = Upload.saveFileSpring(multipartFile, upDir);

							map.put("contentsNo", contentsNo);
							map.put("fname", fname);
							map.put("fupname", fupname);
							map.put("fsize", fsize);

							ContentsProc.create(map);
						}

					}
				}

			}

			MultipartFile fthum = ContentsCreateDto.getFthum();
			if (fthum.getSize() > 0) {
				
				if(!Tool.isImage(fthum.getOriginalFilename())) {
					return new ModelAndView("contents/contentsFail").addObject("error", "확장자 오류 jpg, jpeg, png, gif만 가능");
				}

				String fupname = "";
				fupname = Upload.saveFileSpring(fthum, upDir); // 원본 파일
				String thum_image = Tool.preview(upDir, fupname, 200, 300);// 썸네일 생성

				if (thum_image != null) {
					HashMap<String, Object> map = new HashMap<String, Object>();

					Tool.deleteFile(upDir, fupname);
					String fname = fthum.getOriginalFilename();
					long fsize = fthum.getSize();
					
					map.put("contentsNo", contentsNo);
					map.put("fname", fname);
					map.put("fsize", fsize);
					map.put("thumb", thum_image);
					
					ContentsProc.create(map);
				}
			}

		} else {
			// 생성 실패
			return new ModelAndView("contents/contentsFail").addObject("error", "글 등록 실패");
		}

		return new ModelAndView("redirect:/contents/list");
	}

	/**
	 * 카테고리 호출
	 * 
	 * @param categrpNo
	 * @return
	 */
	@GetMapping(value = "/CateGroupAjax", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String CateGroupAjax(int categrpNo) {
		JSONObject json = new JSONObject();
		json.put("cate", ContentsProc.CateGroupAjax(categrpNo));
		return json.toString();
	}
	
	/**
	 * 게시글 뿌려주기
	 * @return
	 */
	@GetMapping("/list")
	public ModelAndView list(
			@RequestParam(value="pagenum", defaultValue = "1")  int pagenum
			) {
		
		PageMaker pagemaker = new PageMaker();
		
		// 전체 게시글 개수를 지정한다.
		pagemaker.setTotalcount(ContentsProc.pagingCount());
		// 현재 페이지를 페이지 객체에 저장한다.
		pagemaker.setPagenum(pagenum);
		// 현재 페이지 블록 몇번인지 현재 페이지 번호를 통해서 지정
		pagemaker.setCurrentblock(pagenum);
		// 마지막 블록 번호를 전체 게시글 수를 통해서 정한다.
		pagemaker.setLastblock(pagemaker.getTotalcount());
		
		pagemaker.setStartPageNum(pagenum);
		pagemaker.setEndPageNum(pagenum);
		
		pagemaker.setStartPage(pagemaker.getCurrentblock());
		pagemaker.setEndPage(pagemaker.getLastblock(), pagemaker.getCurrentblock());

		pagemaker.prevnext(pagenum);
		
		List<ContentsVO> list = new ArrayList<ContentsVO>();
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("startPageNum", pagemaker.getStartPageNum());
		map.put("endPageNum", pagemaker.getEndPageNum());
		
		list = ContentsProc.list(map);
		
		for(ContentsVO vo : list) {
			System.out.println(vo.toString());
		}
		
		return new ModelAndView("contents/list")
				.addObject("list", list)
				.addObject("page", pagemaker);
	}
	

}
