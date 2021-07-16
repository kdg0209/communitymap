package com.kdg.community.app.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Service.MapperNameConfigService;

@Controller
public class MapperNameConfigController {

	private final MapperNameConfigService mapperNameConfigService;

	public MapperNameConfigController(MapperNameConfigService mapperNameConfigService) {
		this.mapperNameConfigService = mapperNameConfigService;
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
		
		mapperNameConfigService.update(mapperNameConfig);
		
		return true;
	}
}
