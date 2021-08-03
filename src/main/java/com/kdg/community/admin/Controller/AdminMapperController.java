package com.kdg.community.admin.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
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

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Domain.Mapping;
import com.kdg.community.app.Domain.MappingFiles;
import com.kdg.community.app.Domain.Member;
import com.kdg.community.app.Service.MapperCategoryConfigService;
import com.kdg.community.app.Service.MapperNameConfigService;
import com.kdg.community.app.Service.MapperRecommendService;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MappingDeclareService;
import com.kdg.community.app.Service.MappingFilesService;
import com.kdg.community.app.Service.MappingHasNamesService;
import com.kdg.community.app.Service.MappingService;
import com.kdg.community.app.Service.MemberService;

@Controller
public class AdminMapperController {

	private final MemberService memberService;
	private final MapperService mapperService;
	private final MapperRecommendService mapperRecommendService;
	private final MapperNameConfigService mapperNameConfigService;
	private final MapperCategoryConfigService mapperCategoryConfigService;
	private final MappingService mappingService;
	private final MappingHasNamesService mappingHasNamesService;
	private final MappingFilesService mappingFilesService;
	private final MappingDeclareService mappingDeclareService;
	
	private static final String MAPPER_UPLOAD_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mapperCover\\"; //파일 경로
    private static final String MAPPING_UPLOAD_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mappingCover\\"; //파일 경로
	private static final String MAPPING_FILE_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mappingFiles\\"; //파일 경로
	
	public AdminMapperController(MemberService memberService, MapperService mapperService,
			MapperRecommendService mapperRecommendService, MapperNameConfigService mapperNameConfigService,
			MapperCategoryConfigService mapperCategoryConfigService, MappingService mappingService,
			MappingHasNamesService mappingHasNamesService, MappingFilesService mappingFilesService,
			MappingDeclareService mappingDeclareService) {
		super();
		this.memberService = memberService;
		this.mapperService = mapperService;
		this.mapperRecommendService = mapperRecommendService;
		this.mapperNameConfigService = mapperNameConfigService;
		this.mapperCategoryConfigService = mapperCategoryConfigService;
		this.mappingService = mappingService;
		this.mappingHasNamesService = mappingHasNamesService;
		this.mappingFilesService = mappingFilesService;
		this.mappingDeclareService = mappingDeclareService;
	}

	@GetMapping(value = "/admin/mapper/index")
	public String index(Model model, @RequestParam(defaultValue = "1") int page) {
		page = page - 1;
		
		Pageable pageable 		  = PageRequest.of(page, 6, Sort.by(Sort.Direction.DESC, "write_date"));
		Page<Object[]> memberList = memberService.mapperCountOfmemberList(pageable);
		List<Object> dataList 	  = new ArrayList<Object>();
		String nameArray []		  = {"code", "isAdmin", "isDenie", "is_certification", "id", "password", "name", 
								     "nickname", "phone", "email", "write_date", "write_ip", "mapperCount"};
			
		for(Object[] item : memberList) {
			int loop = 0;
			Map<String, Object> data = new HashMap<String, Object>();
			for(Object deppItem : item) {
				data.put(nameArray[loop++], deppItem);
			}
			dataList.add(data);
		}

		model.addAttribute("getTotalElements", memberList.getTotalElements());  //전체 데이터 수
		model.addAttribute("getTotalPages", memberList.getTotalPages());        //전체 페이지 수
		model.addAttribute("hasNext", memberList.hasNext()); 					//이전 페이지 여부
		model.addAttribute("hasPrevious", memberList.hasPrevious());	        //다음 페이지 여부
		
		model.addAttribute("page", page + 1);
		model.addAttribute("memberList", dataList);
		
		return "admin/mapper/index";
	}
	
	@GetMapping(value = "/admin/mapper/detailIndex")
	public String detailIndex(HttpServletResponse response, Model model, @RequestParam(defaultValue = "1") int page, @RequestParam Long memberCode) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		Member member   = memberService.findByCode(memberCode);
		
		if(member == null) {
			out.println("<script>alert('잘못된 접근입니다.'); location.href='/admin/mapper/index';</script>");
			out.flush();
			return "admin/mapper/index";
		}else {
			page = page - 1;
			
			Pageable pageable 		= PageRequest.of(page, 8, Sort.by(Sort.Direction.DESC, "countOfMapping"));
			Page<Mapper> mapperList = mapperService.mapperList(member.getCode(), pageable);
			Map<Integer, String> categoryMap = new HashMap<Integer, String>();
			
			model.addAttribute("getTotalElements", mapperList.getTotalElements());  //전체 데이터 수
			model.addAttribute("getTotalPages", mapperList.getTotalPages());        //전체 페이지 수
			model.addAttribute("hasNext", mapperList.hasNext()); 					//이전 페이지 여부
			model.addAttribute("hasPrevious", mapperList.hasPrevious());	        //다음 페이지 여부
			model.addAttribute("page", page + 1);
			
			model.addAttribute("member", member);
			model.addAttribute("mapperList", mapperList.getContent());
			
			categoryMap.put(1, "문화");	
			categoryMap.put(2, "음식");	
			categoryMap.put(3, "여행");	
			categoryMap.put(4, "조사");	
			categoryMap.put(5, "안전");	
			categoryMap.put(6, "기타");	
			
			model.addAttribute("categoryList", categoryMap);
			
			return "admin/mapper/detailIndex";
		}
	}
	
	@GetMapping(value = "/admin/mapper/edit")
	public String edit(HttpServletResponse response, Model model, @RequestParam Long mapperCode, @RequestParam Long memberCode) throws Exception {
		Mapper mapper 	= mapperService.issetMapper(mapperCode);
		
		if(mapper == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('잘못된 접근입니다.'); location.href='/app/login/index';</script>");
			out.flush();
			
			return "app/login/index";
		}else {
			List<MapperNameConfig> nameConfigList = mapperNameConfigService.getNameConfigList(mapper.getCode());
			List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapper.getCode());
			
			model.addAttribute("memberCode", memberCode);
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
			
			return "admin/mapper/edit";
		}
	}
	
	@PostMapping(value = "/admin/mapper/edit")
	@ResponseBody
	public boolean edit(Mapper mapper, @RequestBody Map<String, String> param) throws Exception {
		Long memberCode		   		  = Long.parseLong(param.get("memberCode"));
		Long code		   			  = Long.parseLong(param.get("code"));
		int categoryCode   			  = Integer.parseInt(param.get("categoryCode"));
		int editAuth 	   			  = Integer.parseInt(param.get("editAuth"));
		String file	 	   			  = param.get("cover");
		String filename    			  = param.get("filename");
		String newFileName			  = null;
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePassword		  = null;
		
		Mapper isMapper = mapperService.view(code, memberCode);
		
		if(isMapper.getCode() != null) {
			if(param.get("editPassword") != "") {
				securePassword = encoder.encode(param.get("editPassword"));
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
			mapper.setName(param.get("name"));
			mapper.setContents(param.get("contents"));
			mapper.setCategoryCode(categoryCode);
			mapper.setEditAuth(editAuth);

			mapperService.update(memberCode, mapper);
			
			int mapperNameCount = Integer.parseInt(param.get("mapperNameCount"));
			for (int i = 0; i < mapperNameCount; i++) {
				MapperNameConfig config = new MapperNameConfig();
				config.setName(param.get("mapperName["+ i +"][name]"));
				config.setMapper(mapper);
				mapperNameConfigService.insert(config);
			}
			
			int mapperCategoryCount = Integer.parseInt(param.get("mapperCategoryCount"));
			for (int i = 0; i < mapperCategoryCount; i++) {
				MapperCategoryConfig config = new MapperCategoryConfig();
				config.setName(param.get("mapperCategory["+ i +"][name]"));
				config.setImgPath(param.get("mapperCategoryImgPath["+ i +"][name]"));
				config.setMapper(mapper);
				mapperCategoryConfigService.insert(config);
			}
			
			return true;
		}else {
			return false;
		}
	}
	
	@GetMapping(value = "/admin/mapper/delete")
	@Transactional
	public void delete(HttpServletResponse response, @RequestParam Long mapperCode, @RequestParam Long memberCode) throws IOException {
		Mapper mapper 	= mapperService.view(mapperCode, memberCode);
		
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
				mappingDeclareService.deleteByParent(mapping.getCode());
				mappingService.delete(mapping.getCode());
			}
			
			if(mapper.getFileName() != null) {
				deleteFile(mapper.getFileName(), MAPPER_UPLOAD_PATH);
			}
			
			mapperCategoryConfigService.deleteByParent(mapper.getCode());
			mapperNameConfigService.deleteByParent(mapper.getCode());
			mapperRecommendService.deleteByMember(mapper.getCode());
			mapperService.delete(mapper.getCode());
			
			out.println("<script>location.href='/admin/mapper/detailIndex?memberCode="+ memberCode +"';</script>");
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
