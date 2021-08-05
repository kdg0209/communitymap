package com.kdg.community.admin.Controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MappingDeclare;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MappingDeclareService;
import com.kdg.community.app.Service.MappingService;

@Controller
public class AdminMappingDeclareController {

	private final MapperService mapperService;
	private final MappingService mappingService;
	private final MappingDeclareService mappingDeclareService;
	
	public AdminMappingDeclareController(MapperService mapperService, MappingService mappingService,
			MappingDeclareService mappingDeclareService) {
		this.mapperService = mapperService;
		this.mappingService = mappingService;
		this.mappingDeclareService = mappingDeclareService;
	}
	
	@GetMapping(value = "/admin/mappingDeclare/index")
	@Transactional
	public String index(HttpServletResponse response, Model model, @RequestParam Long mappingCode, @RequestParam Long mapperCode, @RequestParam(defaultValue = "1") int page) throws Exception {
		Mapper mapper = mapperService.issetMapper(mapperCode);
		
		if(mapper == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('접근권한이 없습니다.'); location.href='/app/login/index';</script>");
			out.flush();
			
			return "app/login/index";
		}else {
			page = page - 1;
			
			Pageable pageable = PageRequest.of(page, 6, Sort.by(Sort.Direction.DESC, "writeDate"));
			Page<MappingDeclare> declareList = mappingDeclareService.declareList(mappingCode, pageable);
			
			model.addAttribute("getTotalElements", declareList.getTotalElements()); //전체 데이터 수
			model.addAttribute("getTotalPages", declareList.getTotalPages());       //전체 페이지 수
			model.addAttribute("hasNext", declareList.hasNext()); 					//이전 페이지 여부
			model.addAttribute("hasPrevious", declareList.hasPrevious());	        //다음 페이지 여부
			
			model.addAttribute("declareList", declareList.getContent());
			model.addAttribute("page", page + 1);
			model.addAttribute("mappingCode", mappingCode);
			model.addAttribute("memberCode", mapper.getMember().getCode());
			model.addAttribute("mapperCode", mapperCode);
			
			return "admin/mappingDeclare/index";
		}
	}
}
