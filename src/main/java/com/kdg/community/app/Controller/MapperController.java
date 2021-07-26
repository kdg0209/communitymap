package com.kdg.community.app.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.codec.binary.Base64;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdg.community.app.Common.GetUserIp;
import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Domain.Mapping;
import com.kdg.community.app.Domain.MappingFiles;
import com.kdg.community.app.Domain.Member;
import com.kdg.community.app.Service.MapperCategoryConfigService;
import com.kdg.community.app.Service.MapperNameConfigService;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MappingFilesService;
import com.kdg.community.app.Service.MappingHasNamesService;
import com.kdg.community.app.Service.MappingService;
import com.kdg.community.app.Service.MemberService;

@Controller
public class MapperController {

	private final MapperService mapperService;
	private final MapperNameConfigService mapperNameConfigService;
	private final MapperCategoryConfigService mapperCategoryConfigService;
	private final MemberService memberService;
	private final MappingService mappingService;
	private final MappingHasNamesService mappingHasNamesService;
	private final MappingFilesService mappingFilesService;
	 
    private static final String MAPPER_UPLOAD_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mapperCover\\"; //파일 경로
    private static final String MAPPING_UPLOAD_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mappingCover\\"; //파일 경로
	private static final String MAPPING_FILE_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mappingFiles\\"; //파일 경로
	
	public MapperController(MapperService mapperService, MapperNameConfigService mapperNameConfigService,
			MapperCategoryConfigService mapperCategoryConfigService, MemberService memberService,
			MappingService mappingService, MappingHasNamesService mappingHasNamesService,
			MappingFilesService mappingFilesService) {
		this.mapperService = mapperService;
		this.mapperNameConfigService = mapperNameConfigService;
		this.mapperCategoryConfigService = mapperCategoryConfigService;
		this.memberService = memberService;
		this.mappingService = mappingService;
		this.mappingHasNamesService = mappingHasNamesService;
		this.mappingFilesService = mappingFilesService;
	}

	@GetMapping(value = "/app/mapper/index")
	public String index(HttpServletResponse response, HttpSession session, Model model, @RequestParam int page) throws Exception {
		Long memberCode = (Long)session.getAttribute("code");
		
		if(memberCode == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('로그인 후 이용할 수 있습니다.'); location.href='/app/login/index';</script>");
			out.flush();
			
			return "app/login/index";
		}else {
			page = page - 1;
			
			Pageable pageable = PageRequest.of(page, 6, Sort.by(Sort.Direction.DESC, "writeDate"));
			
			Page<Mapper> mapperList = mapperService.mapperList(memberCode, pageable);
				
			model.addAttribute("getTotalElements", mapperList.getTotalElements());  //전체 데이터 수
			model.addAttribute("getTotalPages", mapperList.getTotalPages());        //전체 페이지 수
			model.addAttribute("hasNext", mapperList.hasNext()); 					//이전 페이지 여부
			model.addAttribute("hasPrevious", mapperList.hasPrevious());	        //다음 페이지 여부
			model.addAttribute("page", page + 1);
			
			model.addAttribute("mapperList", mapperList.getContent());
			
			return "app/mapper/index";
		}
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
	public boolean write(Mapper mapper, HttpSession session, @RequestBody Map<String, Object> param) throws Exception {
		
		try {
			String file	 	   = (String) param.get("cover");
			String filename    = (String) param.get("filename");
			String newFileName = null;
			int categoryCode   = Integer.parseInt((String) param.get("categoryCode"));
			int editAuth 	   = Integer.parseInt((String) param.get("editAuth"));
			Long memberCode    = (Long) session.getAttribute("code");
			Member member 	   = memberService.findByCode(memberCode);
			
			GetUserIp getUserIp 		  = new GetUserIp();
			SimpleDateFormat format 	  = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
			Date time 				      = new Date();
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String securePassword		  = null;
			
			if(file != "") {
				UUID uuid = UUID.randomUUID();
				
				newFileName = uuid + "_" +filename;
				makeFileWithString(file, newFileName);
			}
			
			if(param.get("editPassword") != "") {
				securePassword = encoder.encode((String)param.get("editPassword"));
			}
			
			mapper.setMember(member);
			mapper.setStatus('C');
			mapper.setFileName(newFileName);
			mapper.setName((String)param.get("name"));
			mapper.setContents((String)param.get("contents"));
			mapper.setCategoryCode(categoryCode);
			mapper.setEditAuth(editAuth);
			mapper.setEditPassword(securePassword);
			mapper.setWriteDate(format.format(time));
			mapper.setWriteIp(getUserIp.returnIP());
			mapperService.insert(mapper);
			
			int mapperNameCount = Integer.parseInt((String) param.get("mapperNameCount"));
			for (int i = 0; i < mapperNameCount; i++) {
				MapperNameConfig config = new MapperNameConfig();
				config.setName((String)param.get("mapperName["+ i +"][name]"));
				config.setMapper(mapper);
				mapperNameConfigService.insert(config);
			}
			
			int mapperCategoryCount = Integer.parseInt((String) param.get("mapperCategoryCount"));
			for (int i = 0; i < mapperCategoryCount; i++) {
				MapperCategoryConfig config = new MapperCategoryConfig();
				config.setName((String)param.get("mapperCategory["+ i +"][name]"));
				config.setImgPath((String)param.get("mapperCategoryImgPath["+ i +"][name]"));
				config.setMapper(mapper);
				mapperCategoryConfigService.insert(config);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			return false;
		}
		return true;
	}
	
	@GetMapping(value = "/app/mapper/edit")
	public String edit(HttpServletResponse response, HttpSession session, Model model, @RequestParam Long code) throws Exception {
		Long memberCode = (Long)session.getAttribute("code");
		Mapper mapper 	= mapperService.view(code, memberCode);
		
		if(mapper.getCode() == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('로그인 후 이용할 수 있습니다.'); location.href='/app/login/index';</script>");
			out.flush();
			
			return "app/login/index";
		}else {
			List<MapperNameConfig> nameConfigList = mapperNameConfigService.getNameConfigList(code);
			List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(code);
			
			model.addAttribute("mapper", mapper);
			model.addAttribute("nameConfigList", nameConfigList);
			model.addAttribute("categoryConfigList", categoryConfigList);
			
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
			
			return "app/mapper/edit";
		}
	}
	
	@PostMapping(value = "/app/mapper/edit")
	@ResponseBody
	public boolean edit(Mapper mapper, HttpSession session, @RequestBody Map<String, Object> param) throws Exception {
		Long memberCode    		      = (Long)session.getAttribute("code");
		Long code		   			  = Long.parseLong((String) param.get("code"));
		int categoryCode   			  = Integer.parseInt((String) param.get("categoryCode"));
		int editAuth 	   			  = Integer.parseInt((String) param.get("editAuth"));
		String file	 	   			  = (String) param.get("cover");
		String filename    			  = (String) param.get("filename");
		String newFileName			  = null;
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePassword		  = null;
		
		Mapper isMapper = mapperService.view(code, memberCode);
		
		if(isMapper.getCode() != null) {
			if(param.get("editPassword") != "") {
				securePassword = encoder.encode((String)param.get("editPassword"));
				mapper.setEditPassword(securePassword);
			}
			
			if(file != "") {
				UUID uuid = UUID.randomUUID();
				newFileName = uuid + "_" +filename;
				
				mapper.setFileName(newFileName);
				makeFileWithString(file, newFileName);
				deleteFile(isMapper.getFileName(), MAPPER_UPLOAD_PATH);
			}
			
			mapper.setCode(code);
			mapper.setName((String) param.get("name"));
			mapper.setContents((String) param.get("contents"));
			mapper.setCategoryCode(categoryCode);
			mapper.setEditAuth(editAuth);

			mapperService.update(memberCode, mapper);
			
			int mapperNameCount = Integer.parseInt((String) param.get("mapperNameCount"));
			for (int i = 0; i < mapperNameCount; i++) {
				MapperNameConfig config = new MapperNameConfig();
				config.setName((String)param.get("mapperName["+ i +"][name]"));
				config.setMapper(mapper);
				mapperNameConfigService.insert(config);
			}
			
			int mapperCategoryCount = Integer.parseInt((String) param.get("mapperCategoryCount"));
			for (int i = 0; i < mapperCategoryCount; i++) {
				MapperCategoryConfig config = new MapperCategoryConfig();
				config.setName((String)param.get("mapperCategory["+ i +"][name]"));
				config.setImgPath((String)param.get("mapperCategoryImgPath["+ i +"][name]"));
				config.setMapper(mapper);
				mapperCategoryConfigService.insert(config);
			}
			
			return true;
		}else {
			return false;
		}
	}
	
	@GetMapping(value = "/app/mapper/delete")
	@Transactional
	public void delete(HttpServletResponse response, HttpSession session, @RequestParam Long code) throws IOException {
		Long memberCode = (Long)session.getAttribute("code");
		Mapper mapper 	= mapperService.view(code, memberCode);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(mapper == null) {
			out.println("<script>alert('잘못된 접근입니다..'); location.href='/';</script>");
			out.flush();
		}else {
			List<Mapping> mappingList =  mappingService.mappingList(mapper.getCode());
		
			for(Mapping mapping : mappingList) {
				List<MappingFiles> mappingFileList = mappingFilesService.getMappingFilesList(mapping.getTimestamp());
				
				for(MappingFiles item : mappingFileList) {
					if(item.getFileName() != null) {
						deleteFile(item.getFileName(), MAPPING_FILE_PATH);
					}
				}
				
				if(mapping.getFileName() != null) {
					deleteFile(mapping.getFileName(), MAPPING_UPLOAD_PATH);
				}
				
				mappingFilesService.deleteByParent(mapping.getTimestamp());
				mappingHasNamesService.deleteByParent(mapping.getCode());
				mappingService.delete(mapping.getCode());
			}
			
			if(mapper.getFileName() != null) {
				deleteFile(mapper.getFileName(), MAPPER_UPLOAD_PATH);
			}
			
			mapperCategoryConfigService.deleteByParent(mapper.getCode());
			mapperNameConfigService.deleteByParent(mapper.getCode());
			mapperService.delete(mapper.getCode());
			
			out.println("<script>location.href='/app/mapper/index?page=1';</script>");
			out.flush();
		}
	}
	
	private static void makeFileWithString(String base64, String newFileName){
		byte decode[] = Base64.decodeBase64(base64);
		FileOutputStream fos;
		
		try{
			File target = new File(MAPPER_UPLOAD_PATH + "" + newFileName);
			fos = new FileOutputStream(target);
			fos.write(decode);
			fos.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	private static boolean deleteFile(String fileName, String path) {
		File file = new File(path + "" + fileName);
		
		if( file.exists() ){
			if(file.delete()){
				return true;
			}else{ 
				return false;
			} 
		}else{
			return false;
		}
	}
}
