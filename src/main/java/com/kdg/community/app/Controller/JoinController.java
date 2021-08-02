package com.kdg.community.app.Controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.kdg.community.app.Domain.EmailVerification;
import com.kdg.community.app.Domain.Member;
import com.kdg.community.app.Service.EmailVerificationService;
import com.kdg.community.app.Service.JoinService;

@Controller
@RequestMapping("/app/join/*")
public class JoinController {
	
	private final JoinService joinRepository;
	private final EmailVerificationService emailVerificationService;
	
	@Autowired
    protected JavaMailSender gmailMailSender;

	public JoinController(JoinService joinRepository, EmailVerificationService emailVerificationService) {
		this.joinRepository = joinRepository;
		this.emailVerificationService = emailVerificationService;
	}

	@GetMapping(value = "/app/join/index")
	public String join() {
		return "app/join/index";
	}
	
	@PostMapping(value = "/app/join/idverification")
	@ResponseBody
	public boolean idverification(@RequestBody Map<String, Object> param) {
		String value = (String) param.get("value");
	
		int count = joinRepository.idValidation(value);
		return count > 0 ? false:true;
	}
	
	@PostMapping(value = "/app/join/nicknameverification")
	@ResponseBody
	public boolean nicknameverification(@RequestBody Map<String, Object> param) {
		String value = (String) param.get("value");
	
		int count = joinRepository.nicknameValidation(value);
		return count > 0 ? false:true;
	}
	
	@PostMapping(value = "/app/join/phoneverification")
	@ResponseBody
	public boolean phoneverification(@RequestBody Map<String, Object> param) {
		String value = (String) param.get("value");
	
		int count = joinRepository.phoneverification(value);
		return count > 0 ? false:true;
	}
	
	@PostMapping(value = "/app/join/emailverification")
	@ResponseBody
	public boolean emailverification(@RequestBody Map<String, Object> param) {
		String value = (String) param.get("value");
	
		int count = joinRepository.emailverification(value);
		return count > 0 ? false:true;
	}
	
	@PostMapping(value = "/app/join/mailsend")
	@ResponseBody
	public boolean mailsend(@RequestBody Map<String, Object> param) {
		String email = (String) param.get("email");
		
		try{
        	MimeMessage mail = gmailMailSender.createMimeMessage();
        	MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");
        	
        	String value = UUID.randomUUID().toString();

			mailHelper.setTo(email);							// 받는 사람 셋팅
			mailHelper.setSubject("[나랑 공유해보지 않을래?]");		// 제목 셋팅
			mailHelper.setText("인증 번호는 " + value + " 입니다.");	// 내용 셋팅

			// 메일 전송
			gmailMailSender.send(mail);
			
			SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
			Date time = new Date();
			
			EmailVerification emailVerification = new EmailVerification();
			emailVerification.setMemberEmail(email);
			emailVerification.setValue(value);
			emailVerification.setWrite_date(format.format(time));
			
			emailVerificationService.insert(emailVerification);
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
		return true;
	}
	
	@PostMapping(value = "/app/join/mailsendcheck")
	@ResponseBody
	public String mailsendcheck(@RequestBody Map<String, Object> param) throws ParseException {
	String email = (String) param.get("email");
		String emailvalue = (String) param.get("emailvalue");
		
		EmailVerification validation = emailVerificationService.writeDateValidation(email);
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		Date date = format.parse(validation.getWrite_date());
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		
		calendar.add(Calendar.MINUTE, 3);// 3분 더하기
		
		Date sysDate = new Date();
		Calendar sysCalendar = Calendar.getInstance();
		sysCalendar.setTime(sysDate);
		
		
		if(sysCalendar.after(calendar)) { // 3분 초과일때는 pass
			return "pass"; 
		}else if(sysCalendar.before(calendar)) {
			if(emailvalue.equals(validation.getValue())) { //이메일 인증 번호 일치 여부
				return "true";
			} else {
				return "pass"; 
			}
		}
		else {
			return "true"; 
		}
	}
	
	@PostMapping(value = "/app/join/index")
	public String index(Member member) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePassword = encoder.encode(member.getPassword());

		member.setPassword(securePassword);
		member.setIs_certification('Y');
		member.setIsDenie('N');
		member.setIsAdmin('N');
		member.setWrite_date(format.format(time));
		member.setWrite_ip(getUserIp());
		
		joinRepository.insert(member);
		
		return "app/login/index";
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
}
