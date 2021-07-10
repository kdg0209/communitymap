package com.kdg.community.app.Controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdg.community.app.Domain.Member;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MemberService;

@Controller
public class MapperController {

	private final MapperService mapperService;
	private final MemberService memberService;
	
	public MapperController(MapperService mapperService, MemberService memberService) {
		this.mapperService = mapperService;
		this.memberService = memberService;
	}

	@GetMapping(value = "/app/mapper/write")
	public String write(HttpServletResponse response, HttpSession session, Model model) throws Exception {
		String memberID = (String)session.getAttribute("id");
		
		if(memberID == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('로그인 후 이용할 수 있습니다.'); location.href='/app/login/index';</script>");
			out.flush();
			
			return "app/login/index";
		}else {
			Map<Integer, String> categoryMap = new HashMap<Integer, String>();
			
			categoryMap.put(1, "문화");	
			categoryMap.put(2, "음식");	
			categoryMap.put(3, "여행");	
			categoryMap.put(4, "조사");	
			categoryMap.put(5, "안전");	
			categoryMap.put(6, "기타");	
			model.addAttribute("categoryList", categoryMap);
			
			Map<Integer, String> editAuth = new HashMap<Integer, String>();
			
			editAuth.put(1, "누구나 작성/수정 가능");	
			editAuth.put(2, "아는 사람끼리");	
			editAuth.put(3, "나만 가능");
			model.addAttribute("editAuth", editAuth);
			
			return "app/mapper/write";
		}
	}
	
	@PostMapping(value = "/app/mapper/write")
	@ResponseBody
	public void write(@RequestBody Map<String, Object> param, HttpServletRequest request) {
		System.out.println(param);
		System.out.println(request);
	}
}
