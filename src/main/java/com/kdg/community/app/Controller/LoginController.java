package com.kdg.community.app.Controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.kdg.community.app.Domain.Member;
import com.kdg.community.app.Service.MemberService;

@Controller
public class LoginController {

	private final MemberService memberService;

	public LoginController(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@GetMapping(value = "/app/login/index")
	public String login() {
		return "app/login/index";
	}
	
	@PostMapping(value = "/app/login/index")
	public void login(HttpServletResponse response, HttpSession session,String id, String password) throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		Member member = memberService.findById(id);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		if(encoder.matches(password, member.getPassword())) {
			session.setAttribute("id", member.getId());
			session.setAttribute("name", member.getName());
			session.setAttribute("nickname", member.getNickname());
			
			out.println("<script>alert('반갑습니다.'); location.href='/';</script>");
			out.flush();
		}else {
			out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); location.href='/app/login/index';</script>");
			out.flush();
		}
	}
}
