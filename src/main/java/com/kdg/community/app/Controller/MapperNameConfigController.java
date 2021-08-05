package com.kdg.community.app.Controller;

import java.io.IOException;
import java.io.PrintWriter;

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
import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Service.MapperNameConfigService;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MappingHasNamesService;

@Controller
public class MapperNameConfigController {

	private final MapperService mapperService;
	private final MapperNameConfigService mapperNameConfigService;
	private final MappingHasNamesService mappingHasNamesService;

	public MapperNameConfigController(MapperService mapperService, MapperNameConfigService mapperNameConfigService,
			MappingHasNamesService mappingHasNamesService) {
		this.mapperService = mapperService;
		this.mapperNameConfigService = mapperNameConfigService;
		this.mappingHasNamesService = mappingHasNamesService;
	}

	@GetMapping(value = "/app/mapperNameConfig/edit")
	public String edit(HttpSession session, Model model, @RequestParam Long code) {
		
		MapperNameConfig config = mapperNameConfigService.getView(code);
		
		model.addAttribute("config", config);
		
		return "app/mapperNameConfig/edit";
	}
	
	@PostMapping(value = "/app/mapperNameConfig/edit")
	@ResponseBody
	public Boolean edit(MapperNameConfig mapperNameConfig) {
		
		boolean result = mapperNameConfigService.update(mapperNameConfig);
		
		if(result) {
			return true;
		}else {
			return false;
		}
	}
	
	@GetMapping(value = "/app/mapperNameConfig/delete")
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
			try {
				MapperNameConfig config = mapperNameConfigService.getView(code);
				mappingHasNamesService.deleteByMapperNameConfig(config.getCode());
				int result = mapperNameConfigService.delete(code);
				
				if(result > 0) {
					out.println("<script>location.href='/app/mapper/edit?code="+ mapper.getCode() +"';</script>");
					out.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
				out.println("<script>alert('잘못된 접근입니다..'); location.href='/';</script>");
				out.flush();
			}
		}
	}
}
