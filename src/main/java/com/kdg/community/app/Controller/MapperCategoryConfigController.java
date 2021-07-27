package com.kdg.community.app.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Domain.Mapping;
import com.kdg.community.app.Service.MapperCategoryConfigService;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MappingService;

@Controller
public class MapperCategoryConfigController {

	private final MapperService mapperService;
	private final MappingService mappingService;
	private final MapperCategoryConfigService mapperCategoryConfigService;

	public MapperCategoryConfigController(MapperService mapperService, MappingService mappingService,
			MapperCategoryConfigService mapperCategoryConfigService) {
		this.mapperService = mapperService;
		this.mappingService = mappingService;
		this.mapperCategoryConfigService = mapperCategoryConfigService;
	}

	@GetMapping(value = "/app/mapperCategoryConfig/edit")
	public String edit(HttpSession session, Model model, @RequestParam Long code) {
		
		MapperCategoryConfig config = mapperCategoryConfigService.getView(code);
		
		model.addAttribute("config", config);
		
		return "app/mapperCategoryConfig/edit";
	}
	
	@PostMapping(value = "/app/mapperCategoryConfig/edit")
	@ResponseBody
	public Boolean edit(MapperCategoryConfig mapperCategoryConfig) {
		
		mapperCategoryConfigService.update(mapperCategoryConfig);
		return true;
	}
	
	@GetMapping(value = "/app/mapperCategoryConfig/delete")
	@Transactional
	public void delete(HttpServletResponse response, HttpSession session, @RequestParam Long code, @RequestParam Long mapperCode) throws IOException {
		Long memberCode = (Long)session.getAttribute("code");
		Mapper mapper 	= mapperService.view(mapperCode, memberCode);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(mapper == null) {
			out.println("<script>alert('접근 권한이 업습니다.'); location.href='/app/login/index';</script>");
			out.flush();
		}else {
			MapperCategoryConfig config = mapperCategoryConfigService.getView(code);

			List<Mapping> mappingList = mappingService.findCategoryCodeList(config.getCode());
			
			System.out.println(mappingList);
			for(Mapping item : mappingList) {
				Mapping mapping = new Mapping();
				mapping.setCode(item.getCode());
				mapping.setMapper(item.getMapper());
				mapping.setMapperCategoryConfig(null);
				mapping.setMarkerImg(null);
				
				mappingService.updateByCategoryDelete(mapping);
			}
			mapperCategoryConfigService.delete(code);
			
			out.println("<script>location.href='/app/mapper/edit?code="+ mapper.getCode() +"';</script>");
			out.flush();
			
		}
	}
}
