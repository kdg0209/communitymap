package com.kdg.community.app.Controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdg.community.app.Common.GetUserIp;
import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.Mapping;
import com.kdg.community.app.Domain.MappingDeclare;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MappingDeclareService;
import com.kdg.community.app.Service.MappingService;

@Controller
public class MappingdeclareController {

	private final MapperService mapperService;
	private final MappingService mappingService;
	private final MappingDeclareService mappingDeclareService;

	public MappingdeclareController(MapperService mapperService, MappingService mappingService,
			MappingDeclareService mappingDeclareService) {
		this.mapperService = mapperService;
		this.mappingService = mappingService;
		this.mappingDeclareService = mappingDeclareService;
	}

	@GetMapping(value = "/app/mappingDeclare/index")
	@Transactional
	public String index(HttpServletResponse response, HttpSession session, Model model, @RequestParam Long mappingCode, @RequestParam Long mapperCode, @RequestParam(defaultValue = "1") int page) throws Exception {
		Long memberCode = (Long)session.getAttribute("code");
		Mapper mapper = mapperService.view(mapperCode, memberCode);
		
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
			model.addAttribute("mapperCode", mapperCode);
			
			return "app/mappingDeclare/index";
		}
	}

	@GetMapping(value = "/app/mappingDeclare/write")
	public String write(HttpServletResponse response, Model model, @RequestParam Long mappingCode, @RequestParam Long mapperCode) throws Exception {
		Mapping mapping = mappingService.view(mappingCode, mapperCode);
		
		if(mapping == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();	
			
			out.println("<script>alert('잘못된 접근입니다.'); location.href='/';</script>");
			out.flush();
			
			return "/";
		}else {
			
			model.addAttribute("mapping", mapping);
			return "app/mappingDeclare/write";
		}
	}
	
	@PostMapping(value = "/app/mappingDeclare/write")
	@ResponseBody
	@Transactional
	public Boolean write(HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		Long mappingCode = Long.parseLong((String) param.get("mappingCode"));
		Long mapperCode  = Long.parseLong((String) param.get("mapperCode"));
		String memo		 = (String) param.get("memo");
		
		Mapping mapping	    	= mappingService.view(mappingCode, mapperCode);
		GetUserIp getUserIp 	= new GetUserIp();
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		Date time 				= new Date();
		
		try {
			MappingDeclare mappingdeclare = new MappingDeclare();
			mappingdeclare.setMapping(mapping);
			mappingdeclare.setMemo(memo);
			mappingdeclare.setWriteDate(format.format(time));
			mappingdeclare.setWriteIp(getUserIp.returnIP());
			
			mappingDeclareService.insert(mappingdeclare);
			mappingService.DeclareUpdate(mappingCode, mapperCode);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
}
