package com.kdg.community.admin.Controller;

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
public class AdminMapperCategoryConfigController {

	private final MapperService mapperService;
	private final MappingService mappingService;
	private final MapperCategoryConfigService mapperCategoryConfigService;
	
	public AdminMapperCategoryConfigController(MapperService mapperService, MappingService mappingService,
			MapperCategoryConfigService mapperCategoryConfigService) {
		this.mapperService = mapperService;
		this.mappingService = mappingService;
		this.mapperCategoryConfigService = mapperCategoryConfigService;
	}
	
	@GetMapping(value = "/admin/mapperCategoryConfig/edit")
	public String edit(Model model, @RequestParam Long code, @RequestParam Long memberCode) {
		
		MapperCategoryConfig config = mapperCategoryConfigService.getView(code);
		
		model.addAttribute("memberCode", memberCode);
		model.addAttribute("config", config);
		
		return "admin/mapperCategoryConfig/edit";
	}
	
	@PostMapping(value = "/admin/mapperCategoryConfig/edit")
	@ResponseBody
	public Boolean edit(MapperCategoryConfig mapperCategoryConfig) {
		
		mapperCategoryConfigService.update(mapperCategoryConfig);
		return true;
	}
	
	@GetMapping(value = "/admin/mapperCategoryConfig/delete")
	@Transactional
	public void delete(HttpServletResponse response, HttpSession session, @RequestParam Long code, @RequestParam Long mapperCode, @RequestParam Long memberCode) throws IOException {
		Mapper mapper 	= mapperService.issetMapper(mapperCode);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(mapper == null) {
			out.println("<script>alert('접근 권한이 업습니다.'); location.href='/app/login/index';</script>");
			out.flush();
		}else {
			MapperCategoryConfig config = mapperCategoryConfigService.getView(code);

			List<Mapping> mappingList = mappingService.findCategoryCodeList(config.getCode());
			
			for(Mapping item : mappingList) {
				Mapping mapping = new Mapping();
				
				mapping.setCode(item.getCode());
				mapping.setMapper(item.getMapper());
				mapping.setMapperCategoryConfig(null);
				mapping.setMarkerImg(null);
				
				mappingService.updateByCategoryDelete(mapping);
			}
			mapperCategoryConfigService.delete(code);
			
			out.println("<script>location.href='/admin/mapper/edit?mapperCode="+ mapper.getCode() +"&memberCode="+ memberCode +"';</script>");
			out.flush();
		}
	}
	
}
