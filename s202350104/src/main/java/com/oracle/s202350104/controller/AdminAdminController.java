package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.CommonCodes;
import com.oracle.s202350104.model.Favorite;
import com.oracle.s202350104.model.RestaurantsContent;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.AdminListService;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.CommonCodeService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/admin/*")
public class AdminAdminController {

	private final AdminListService als;
	private final CommonCodeService ccs;
	private final AreaService as;
	private final UserService us;
	
	/* 전체적으로 각 Method들이 무슨 기능을 하고 있는지 간략하게 주석을 남겨주시면 다른 분들도 이해하기 좋을 것  같아요.
	 * by.엄민용
	 */ 

	@RequestMapping(value = "/adminList")
	public String adminList(Users user, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "adminList", "start");
			int totalAdminList = als.totalAdminList();

			Paging page = new Paging(totalAdminList, currentPage);
			user.setStart(page.getStart());
			user.setEnd(page.getEnd());

			List<Users> listUser = als.listUser(user);

			model.addAttribute("totalAdminList", totalAdminList);
			model.addAttribute("page", page);
			model.addAttribute("listUser", listUser);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "adminList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "adminList", "end");
		}

		return "admin/admin/adminList";
	}

	@RequestMapping(value = "/commonCode")
	public String commonCode(CommonCodes commonCode, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "commonCode", "start");
			int totalCommonCode = ccs.totalCommonCode();

			int path = 0;

			Paging page = new Paging(totalCommonCode, currentPage);
			commonCode.setStart(page.getStart());
			commonCode.setEnd(page.getEnd());

			List<CommonCodes> listCommonCode = ccs.listCommonCode(commonCode);
			List<CommonCodes> listCommon = ccs.listCommonCode();

			model.addAttribute("totalCommonCode", totalCommonCode);
			model.addAttribute("listCommonCode", listCommonCode);
			model.addAttribute("listCommon", listCommon);
			model.addAttribute("page", page);

			model.addAttribute("path", path);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "commonCode", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "commonCode", "end");
		}

		return "admin/admin/commonCode";
	}

	@RequestMapping(value = "/commonCodeSearch")
	public String commonCodeSeacrch(CommonCodes commonCode, String currentPage, 
									Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "AdminAdminController commonCodeSearch", "start");
			int totalCommonCode = ccs.conTotalCommonCode(commonCode);

			int path = 1;
			String big_code = request.getParameter("big_code");

			Paging page = new Paging(totalCommonCode, currentPage);
			commonCode.setStart(page.getStart());
			commonCode.setEnd(page.getEnd());

			List<CommonCodes> listSearchCommonCode = ccs.listSearchCommonCode(commonCode);
			List<CommonCodes> listCommon = ccs.listCommonCode();

			model.addAttribute("totalCommonCode", totalCommonCode);
			model.addAttribute("path", path);
			model.addAttribute("big_code", big_code);
			model.addAttribute("page", page);
			model.addAttribute("listCommonCode", listSearchCommonCode);
			model.addAttribute("listCommon", listCommon);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "AdminAdminController commonCodeSearch", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "AdminAdminController commonCodeSearch", "end");
		}

		return "admin/admin/commonCode";
	}

	
	@RequestMapping(value = "/commonCodeInsertForm")
	public String commonCodeInsertForm() {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin commonCodeInsertForm", "Start");
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin commonCodeInsertForm Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin commonCodeInsertForm", "End");
		}
			
		return "admin/admin/commonCodeInsertForm";
	}
	
	
	@RequestMapping(value = "commonCode/insert")
	public String commonCodeInsert(Model model, CommonCodes commonCode) {
		UUID transactionId = UUID.randomUUID();
		
		int result = ccs.insertCommonCode(commonCode);
		
		if(result > 0) {
			return "redirect:/admin/admin/commonCode";
		} else {
			model.addAttribute("msg", "입력실패 확인해보세요");
			return "forward:commonCodeInsertForm";
		}
			
	}
	
	
	@RequestMapping(value = "commonCodeDelete")
	public String commonCodeDelete(Model model, CommonCodes commonCode) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin commonCodeDelete", "Start");
			int result = ccs.deleteCommonCode(commonCode);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin commonCodeDelete Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin commonCodeDelete", "End");
		}
		
		return "redirect:commonCode";	
	} 
	
	
	@RequestMapping(value = "commonCodeUpdateForm")
	public String commonCodeUpdateForm(Model model, String currentPage, CommonCodes commonCode) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin commonCodeUpdateForm", "Start");
			commonCode = ccs.detailCommonCode(commonCode);
			
			model.addAttribute("commonCode", commonCode);
			model.addAttribute("currentPage", currentPage);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin commonCodeUpdateForm Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin commonCodeUpdateForm", "End");
		}
		
		return "admin/admin/commonCodeUpdateForm";	
	} 
	
	
	@RequestMapping(value = "commonCodeUpdate")
	public String commonCodeUpdate(Model model, String currentPage, CommonCodes commonCode) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin commonCodeUpdate", "Start");
			int result = ccs.updateCommonCode(commonCode);
			log.info("admin commonCodeUpdate result ->" + result);			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin commonCodeUpdate Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin commonCodeUpdate", "End");
		}
		
		return "redirect:/admin/admin/commonCode";	
	} 


	
	@RequestMapping(value = "/areaCode")
	public String areaCode(Areas area, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "areaCode", "start");
			int totalAreaCode = as.totalAreaCode();
			int path = 0;

			Paging page = new Paging(totalAreaCode, currentPage);
			area.setStart(page.getStart());
			area.setEnd(page.getEnd());

			List<Areas> listAreaCode = as.listAreas(area);
			List<Areas> listAreas = as.listAreas();

			model.addAttribute("totalAreaCode", totalAreaCode);
			model.addAttribute("path", path);
			model.addAttribute("page", page);
			model.addAttribute("listAreaCode", listAreaCode);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("currentPage", currentPage);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "areaCode", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "areaCode", "end");
		}

		return "admin/admin/areaCode";

	}

	@RequestMapping(value = "/areaCodeSearch")
	public String areaCodeSearch(Areas area, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "areaCode", "start");
			int totalAreaCode = as.conTotalAreaCode(area);
			int path = 1;
			String area_code = request.getParameter("area");

			Paging page = new Paging(totalAreaCode, currentPage);
			area.setStart(page.getStart());
			area.setEnd(page.getEnd());

			List<Areas> listSearchAreaCode = as.listSearchAreaCode(area);
			List<Areas> listAreas = as.listAreas();

			model.addAttribute("totalAreaCode", totalAreaCode);
			model.addAttribute("path", path);
			model.addAttribute("area", area_code);
			model.addAttribute("page", page);
			model.addAttribute("listAreaCode", listSearchAreaCode);
			model.addAttribute("listAreas", listAreas);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "areaCode", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "areaCode", "end");
		}

		return "admin/admin/areaCode";
	}

	
	@RequestMapping(value = "areaCodeInsertForm")
	public String areaCodeInsertForm() {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin areaCodeInsertForm", "Start");
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin areaCodeInsertForm Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin areaCodeInsertForm", "End");
		}
			
		return "admin/admin/areaCodeInsertForm";
	}
	
	
	@RequestMapping(value = "areaCode/insert")
	public String areaInsert(Model model, Areas area) {
		UUID transactionId = UUID.randomUUID();
		
		int result = as.insertArea(area);
		
		if(result>0) {
			return "redirect:/admin/admin/areaCode";
		} else {
			model.addAttribute("msg", "입력실패 확인해보세요");
			return "forward:areaInsertForm";
		}
			
	}
	
	
	@RequestMapping(value = "areaCodeDelete")
	public String areaCodeDelete(Areas area, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin areaCodeDelete", "start");;
			int result = as.deleteAreaCode(area);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin areaCodeDelete Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin areaCodeDelete", "end");
		}
		
		return "redirect:areaCode";	
	} 
	
	
	@RequestMapping(value = "areaCodeUpdateForm")
	public String areaCodeUpdateForm(Model model, Areas area, String currentPage) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin areaCodeUpdateForm", "start" );
			Areas areaCode = as.detailAreaCode(area);
			
			model.addAttribute("areaCode", areaCode);
			model.addAttribute("currentPage", currentPage);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin areaCodeUpdateForm Exception", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin areaCodeUpdateForm", "end");
		}
		return "admin/admin/areaCodeUpdateForm";
	}
	
	
	@RequestMapping(value = "areaCodeUpdate")
	public String areaCodeUpdaete(Model model, Areas area, String currentPage) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin areaCodeUpdate", "start" );
			int result = as.updateAreaCode(area);
			log.info("admin areaCodeUpdate result ->" + result);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin areaCodeUpdate Exception", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin areaCodeUpdate", "end");
		}
		return "redirect:/admin/admin/areaCode";
	}
				
	
}
