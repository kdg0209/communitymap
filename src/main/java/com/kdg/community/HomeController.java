package com.kdg.community;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Service.MapperService;

@Controller
public class HomeController {
	
	private final MapperService mapperService;

	public HomeController(MapperService mapperService) {
		this.mapperService = mapperService;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		Pageable pageable = PageRequest.of(0, 8, Sort.by(Sort.Direction.DESC, "writeDate"));
		
		Page<Mapper> mapperList = mapperService.mainMapperList(pageable);
		Map<Integer, String> categoryMap = new HashMap<Integer, String>();
		
		categoryMap.put(1, "문화");	
		categoryMap.put(2, "음식");	
		categoryMap.put(3, "여행");	
		categoryMap.put(4, "조사");	
		categoryMap.put(5, "안전");	
		categoryMap.put(6, "기타");	
		
		model.addAttribute("categoryList", categoryMap);
		model.addAttribute("mapperList", mapperList.getContent());
		
		System.out.println(mapperList.getContent());
		
		return "index";
	}
	
}
