package com.kdg.community.app.Controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Service.MapperNameConfigService;

@Controller
public class MapperNameConfigController {

	private final MapperNameConfigService mapperNameConfigService;

	public MapperNameConfigController(MapperNameConfigService mapperNameConfigService) {
		this.mapperNameConfigService = mapperNameConfigService;
	}
	
	@GetMapping(value = "/app/mapperNameConfig/edit")
	public String edit(HttpServletResponse response, HttpSession session, Model model, @RequestParam Long code) throws Exception {
		
		MapperNameConfig config = mapperNameConfigService.findByCode(code);
		
		System.out.println(config);
		
		return "app/mapperNameConfig/edit";
	}
}
