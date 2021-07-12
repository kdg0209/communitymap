package com.kdg.community.app.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Domain.Member;
import com.kdg.community.app.Service.MapperCategoryConfigService;
import com.kdg.community.app.Service.MapperNameConfigService;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MemberService;

@Controller
public class MapperController {

	private final MapperService mapperService;
	private final MapperNameConfigService mapperNameConfigService;
	private final MapperCategoryConfigService mapperCategoryConfigService;
	private final MemberService memberService;
	 
    private static final String UPLOAD_PATH = "C:\\upload\\tmp"; //파일 경로
	
	public MapperController(MapperService mapperService, MapperNameConfigService mapperNameConfigService,
			MapperCategoryConfigService mapperCategoryConfigService, MemberService memberService) {
		this.mapperService = mapperService;
		this.mapperNameConfigService = mapperNameConfigService;
		this.mapperCategoryConfigService = mapperCategoryConfigService;
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
	public void write(Mapper mapper, HttpSession session, @RequestBody Map<String, Object> param) throws Exception {
		Long memberCode = (Long) session.getAttribute("code");
		int categoryCode = Integer.parseInt((String) param.get("categoryCode"));
		int editAuth = Integer.parseInt((String) param.get("editAuth"));
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePassword = encoder.encode((String)param.get("editPassword"));
		
		mapper.setStatus('C');
		mapper.setName((String)param.get("name"));
		mapper.setContents((String)param.get("contents"));
		mapper.setMemberCode(memberCode);
		mapper.setCategoryCode(categoryCode);
		mapper.setEditAuth(editAuth);
		mapper.setEditPassword(securePassword);
		mapper.setWriteDate(format.format(time));
		mapper.setWriteIp(getUserIp());
		
		mapperService.insert(mapper);
		
		int mapperNameCount = Integer.parseInt((String) param.get("mapperNameCount"));
		for (int i = 0; i < mapperNameCount; i++) {
			MapperNameConfig config = new MapperNameConfig();
			config.setMapper(mapper);
			config.setName((String)param.get("mapperName["+ i +"][name]"));
			mapperNameConfigService.insert(config);
		}
		
//		String img = (String) param.get("data");

	}
	
	private String getUserIp() throws Exception {
		
        String ip = null;
        HttpServletRequest request = 
        ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

        ip = request.getHeader("X-Forwarded-For");
        
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("WL-Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_CLIENT_IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-Real-IP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-RealIP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getRemoteAddr(); 
        }
		
		return ip;
	}
	
//	private static void makeFileWithString(String base64){
//		byte decode[] = Base64.decodeBase64(base64);
//		System.out.println(decode);
//		FileOutputStream fos;
//		String IMGNAME = "sunfish.jpg";
//		try{
//			File target = new File(UPLOAD_PATH  + "Copy of " + IMGNAME);
//			target.createNewFile();
//			System.out.println(target.exists());
//			fos = new FileOutputStream(target);
//			fos.write(decode);
//			fos.close();
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		System.out.println("DONE");
//	}

}
