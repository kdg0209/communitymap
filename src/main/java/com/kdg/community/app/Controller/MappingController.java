package com.kdg.community.app.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Domain.Mapping;
import com.kdg.community.app.Service.MapperCategoryConfigService;
import com.kdg.community.app.Service.MapperNameConfigService;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MappingFilesService;
import com.kdg.community.app.Service.MappingHasNamesService;
import com.kdg.community.app.Service.MappingService;

@Controller
public class MappingController {

	private final MappingService mappingService;
	private final MapperService mapperService;
	private final MapperNameConfigService mapperNameConfigService;
	private final MapperCategoryConfigService mapperCategoryConfigService;
	private final MappingHasNamesService mappingHasNamesService;
	
	public MappingController(MappingService mappingService, MapperService mapperService,
			MapperNameConfigService mapperNameConfigService, MapperCategoryConfigService mapperCategoryConfigService,
			MappingHasNamesService mappingHasNamesService) {
		this.mappingService = mappingService;
		this.mapperService = mapperService;
		this.mapperNameConfigService = mapperNameConfigService;
		this.mapperCategoryConfigService = mapperCategoryConfigService;
		this.mappingHasNamesService = mappingHasNamesService;
	}

	@GetMapping(value = "/app/mapping/index")
	public String index(Model model, @RequestParam Long mapperCode) {
		List<Mapping> mappingList = mappingService.mappingList(mapperCode);
		
		model.addAttribute("mappingList", mappingList);
		model.addAttribute("mapperCode", mapperCode);
		
		return "app/mapping/index";
	}
	
	@GetMapping(value = "/app/mapping/write")
	public String write(HttpServletResponse response, HttpSession session, Model model, @RequestParam Long mapperCode) throws IOException {
		Long memberCode = (Long)session.getAttribute("code");
		Mapper mapper 	= mapperService.view(mapperCode, memberCode);
		
		if(mapper == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('잘못된 접근입니다.'); location.href='/';</script>");
			out.flush();
			return "";
		}else {
			long timestamp 								  = System.currentTimeMillis();
			List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapper.getCode());
			List<MapperNameConfig> namesConfigList 		  = mapperNameConfigService.getNameConfigList(mapper.getCode());
			
			model.addAttribute("timestamp", timestamp);
			model.addAttribute("mapperCode", mapperCode);
			model.addAttribute("categoryConfigList", categoryConfigList);
			model.addAttribute("namesConfigList", namesConfigList);
			
			return "app/mapping/write";
		}
	}
	
	@PostMapping(value = "/app/mapping/write")
	@ResponseBody
	public boolean write(Mapping mapping, HttpSession session, @RequestBody Map<String, Object> param) throws Exception {
		
		return true;
	}
	
}
