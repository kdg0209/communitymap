package com.kdg.community.app.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Service.MapperCategoryConfigService;

@Controller
public class MapperCategoryConfigController {

	private final MapperCategoryConfigService mapperCategoryConfigService;

	public MapperCategoryConfigController(MapperCategoryConfigService mapperCategoryConfigService) {
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
}
