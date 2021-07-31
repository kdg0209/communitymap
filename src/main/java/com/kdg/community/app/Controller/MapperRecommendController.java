package com.kdg.community.app.Controller;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MapperRecommend;
import com.kdg.community.app.Domain.Member;
import com.kdg.community.app.Service.MapperRecommendService;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MemberService;

@Controller
public class MapperRecommendController {

	private final MapperRecommendService mapperRecommendService;
	private final MapperService mapperService;
	private final MemberService memberService;
	
	public MapperRecommendController(MapperRecommendService mapperRecommendService, MapperService mapperService,
			MemberService memberService) {
		this.mapperRecommendService = mapperRecommendService;
		this.mapperService = mapperService;
		this.memberService = memberService;
	}
	
	@PostMapping(value = "/app/mapperRecommend/like")
	@ResponseBody
	@Transactional
	public boolean like(HttpServletResponse response, HttpSession session, @RequestBody Map<String, Object> param) throws Exception {
		String memberId = (String)session.getAttribute("id");
		Long mapperCode = Long.parseLong((String) param.get("mapperCode"));
		
		Member member = memberService.findById(memberId);
		Mapper mapper = mapperService.issetMapper(mapperCode);
		
		if(member == null || mapper == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('잘못된 접근입니다..'); location.href='/';</script>");
			out.flush();
			
			return false;
		}else {
			MapperRecommend isMapperRecommend = mapperRecommendService.findByMember(member.getCode());
			
			if(isMapperRecommend == null) {
				MapperRecommend mapperRecommend = new MapperRecommend();
				mapperRecommend.setMapper(mapper);
				mapperRecommend.setMember(member);
				mapperRecommendService.insert(mapperRecommend);
			}else {
				mapperRecommendService.delete(isMapperRecommend.getMember().getCode());
			}
			
			return true;
		}
	}
}
