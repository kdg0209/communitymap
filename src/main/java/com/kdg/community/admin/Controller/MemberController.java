package com.kdg.community.admin.Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.kdg.community.app.Domain.Mapper;
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
public class MemberController {

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

	
	public MemberController(MemberService memberService, MapperService mapperService,
			MapperRecommendService mapperRecommendService, MapperNameConfigService mapperNameConfigService,
			MapperCategoryConfigService mapperCategoryConfigService, MappingService mappingService,
			MappingHasNamesService mappingHasNamesService, MappingFilesService mappingFilesService,
			MappingDeclareService mappingDeclareService) {
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

	@GetMapping(value = "/admin/member/index")
	public String index(Model model, @RequestParam(defaultValue = "1") int page) {
		page = page - 1;
		
		Pageable pageable = PageRequest.of(page, 6, Sort.by(Sort.Direction.DESC, "write_date"));
		Page<Member> memberList = memberService.memberList(pageable);
		

		model.addAttribute("getTotalElements", memberList.getTotalElements());  //전체 데이터 수
		model.addAttribute("getTotalPages", memberList.getTotalPages());        //전체 페이지 수
		model.addAttribute("hasNext", memberList.hasNext()); 					//이전 페이지 여부
		model.addAttribute("hasPrevious", memberList.hasPrevious());	        //다음 페이지 여부
		
		model.addAttribute("page", page + 1);
		model.addAttribute("memberList", memberList.getContent());
		return "admin/member/index";
	}
	
	@GetMapping(value = "/admin/member/edit")
	public String edit(Model model, @RequestParam Long memberCode) {
		Member member = memberService.findByCode(memberCode);
		
		Map<Character, String> isAdminConfigList = new HashMap<Character, String>();
		Map<Character, String> isDenieConfigList = new HashMap<Character, String>();
		
		isAdminConfigList.put('Y', "사용");	
		isAdminConfigList.put('N', "미사용");	
		
		isDenieConfigList.put('Y', "사용");	
		isDenieConfigList.put('N', "미사용");	
		
		model.addAttribute("member", member);
		model.addAttribute("isAdminConfigList", isAdminConfigList);
		model.addAttribute("isDenieConfigList", isDenieConfigList);
		return "admin/member/edit";
	}
	
	@PostMapping(value = "/admin/member/edit")
	public void edit(HttpServletResponse response, Member member) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out 			  = response.getWriter();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePassword 		  = encoder.encode(member.getPassword());
		
		member.setPassword(securePassword);
		
		boolean result =  memberService.update(member);
		
		if(result) {
			out.println("<script>location.href='/admin/member/index';</script>");
			out.flush();
		}else {
			out.println("<script>alert('다시 수정해주세요.'); location.href='/admin/member/edit?memberCode="+ member.getCode() +"';</script>");
			out.flush();
		}
	}
	
	@GetMapping(value = "/admin/member/delete")
	@Transactional
	public void delete(HttpServletResponse response, @RequestParam Long memberCode) throws IOException {
		Member member = memberService.findByCode(memberCode);
		
		PrintWriter out 		  = response.getWriter();
		List<Mapper> mapperList   = mapperService.selectOneByMember(member.getCode());
		List<Mapping> mappingList = null;
		boolean result            = true;
		
		try {
			for(Mapper mapper : mapperList) {
				mappingList =  mappingService.mappingList(mapper.getCode());
				
				for(Mapping mapping : mappingList) {
					List<MappingFiles> mappingFileList = mappingFilesService.getMappingFilesList(mapping.getTimestamp());
					
					for(MappingFiles mappingFile : mappingFileList) {
						if(mappingFile.getFileName() != null) {
							deleteFile(mappingFile.getFileName(), MAPPING_FILE_PATH);
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
				mapperService.delete(mapper.getCode());
				
			}
			mapperRecommendService.deleteByMember(member.getCode());
			
			memberService.delete(member.getCode());
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		
		if(result) {
			out.println("<script>location.href='/admin/member/index';</script>");
			out.flush();
		}else {
			out.println("<script>alert('다시 삭제해주세요.'); location.href='/admin/member/edit?memberCode="+ member.getCode() +"';</script>");
			out.flush();
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
