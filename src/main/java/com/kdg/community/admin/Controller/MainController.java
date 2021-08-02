package com.kdg.community.admin.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	
	@GetMapping(value = "/admin/main/index")
	public String index() {
		return "admin/main/index";
	}
}
