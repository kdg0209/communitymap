package com.kdg.community.admin.Controller;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

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
public class AdminMapperNameConfigController {

	private final MapperService mapperService;
	private final MapperNameConfigService mapperNameConfigService;
	private final MappingHasNamesService mappingHasNamesService;

	public AdminMapperNameConfigController(MapperService mapperService, MapperNameConfigService mapperNameConfigService,
			MappingHasNamesService mappingHasNamesService) {
		this.mapperService = mapperService;
		this.mapperNameConfigService = mapperNameConfigService;
		this.mappingHasNamesService = mappingHasNamesService;
	}

	@GetMapping(value = "/admin/mapperNameConfig/edit")
	public String edit(Model model, @RequestParam Long code, @RequestParam Long memberCode) {
		MapperNameConfig config = mapperNameConfigService.getView(code);
		
		model.addAttribute("memberCode", memberCode);
		model.addAttribute("config", config);
		return "admin/mapperNameConfig/edit";
	}
	
	@PostMapping(value = "/admin/mapperNameConfig/edit")
	@ResponseBody
	public Boolean edit(MapperNameConfig mapperNameConfig) {
		boolean result = mapperNameConfigService.update(mapperNameConfig);
		
		if(result) {
			return true;
		}else {
			return false;
		}
	}
	
	@GetMapping(value = "/admin/mapperNameConfig/delete")
	@Transactional
	public void delete(HttpServletResponse response, @RequestParam Long code, @RequestParam Long mapperCode, @RequestParam Long memberCode) throws IOException {
		Mapper mapper 	= mapperService.issetMapper(mapperCode);
		
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
					out.println("<script>location.href='/admin/mapper/edit?mapperCode="+ mapper.getCode() +"&memberCode="+ memberCode +"';</script>");
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
