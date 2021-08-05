package com.kdg.community.admin.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Domain.Mapping;
import com.kdg.community.app.Domain.MappingFiles;
import com.kdg.community.app.Domain.MappingHasNames;
import com.kdg.community.app.Service.MapperCategoryConfigService;
import com.kdg.community.app.Service.MapperNameConfigService;
import com.kdg.community.app.Service.MapperService;
import com.kdg.community.app.Service.MappingFilesService;
import com.kdg.community.app.Service.MappingHasNamesService;
import com.kdg.community.app.Service.MappingService;

@Controller
public class AdminMappingController {

	private final MappingService mappingService;
	private final MapperService mapperService;
	private final MapperNameConfigService mapperNameConfigService;
	private final MapperCategoryConfigService mapperCategoryConfigService;
	private final MappingHasNamesService mappingHasNamesService;
	private final MappingFilesService mappingFilesService;
	
	private static final String UPLOAD_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mappingCover\\"; //파일 경로
	private static final String MAPPING_FILE_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mappingFiles\\"; //파일 경로
	
	public AdminMappingController(MappingService mappingService, MapperService mapperService,
			MapperNameConfigService mapperNameConfigService, MapperCategoryConfigService mapperCategoryConfigService,
			MappingHasNamesService mappingHasNamesService, MappingFilesService mappingFilesService) {
		this.mappingService = mappingService;
		this.mapperService = mapperService;
		this.mapperNameConfigService = mapperNameConfigService;
		this.mapperCategoryConfigService = mapperCategoryConfigService;
		this.mappingHasNamesService = mappingHasNamesService;
		this.mappingFilesService = mappingFilesService;
	}
	
	@GetMapping(value = "/admin/mapping/index")
	@Transactional
	public String index(Model model, @RequestParam Long mapperCode, @RequestParam Long memberCode, @RequestParam(defaultValue = "1") int page) {
		page = page - 1;
		
		Pageable pageable = PageRequest.of(page, 8, Sort.by(Sort.Direction.DESC, "is_declare", "writeDate"));
		Page<Mapping> mappingList = mappingService.mappingListByMapper(mapperCode, pageable);
		Mapper mapper 			  = mapperService.issetMapper(mapperCode);
		List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapper.getCode());
		
		model.addAttribute("getTotalElements", mappingList.getTotalElements()); //전체 데이터 수
		model.addAttribute("getTotalPages", mappingList.getTotalPages());       //전체 페이지 수
		model.addAttribute("hasNext", mappingList.hasNext()); 					//이전 페이지 여부
		model.addAttribute("hasPrevious", mappingList.hasPrevious());	        //다음 페이지 여부
		
		model.addAttribute("categoryConfigList", categoryConfigList);
		model.addAttribute("mappingList", mappingList.getContent());
		model.addAttribute("page", page + 1);
		model.addAttribute("mapper", mapper);
		model.addAttribute("memberCode", memberCode);
		
		return "admin/mapping/index";
	}
	
	@GetMapping(value = "/admin/mapping/edit")
	@Transactional
	public String edit(HttpServletResponse response, Model model, @RequestParam Long code, @RequestParam Long memberCode) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		Mapping mapping = mappingService.issetMapping(code);
		
		if(mapping == null) {
			out.println("<script>alert('접근 권한이 없습니다.'); location.href='/app/login/index';</script>");
			out.flush();
			
			return "app/login/index";
		}else {
			List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapping.getMapper().getCode());
			List<MapperNameConfig> namesConfigList 		  = mapperNameConfigService.getNameConfigList(mapping.getMapper().getCode());
			List<MappingFiles>    mappingFilesList        = mappingFilesService.getMappingFilesList(mapping.getTimestamp());
			List<MappingHasNames> mappingHasNamesList     = mappingHasNamesService.getMappingHasNamesList(mapping.getCode());
			
			model.addAttribute("categoryConfigList",categoryConfigList);
			model.addAttribute("namesConfigList",namesConfigList);
			model.addAttribute("mapping",mapping);
			model.addAttribute("mappingFilesList",mappingFilesList);
			model.addAttribute("mappingHasNamesList",mappingHasNamesList);
			
			Map<Character, String> statusConfig = new HashMap<Character, String>();
			Map<Character, String> declareConfig = new HashMap<Character, String>();
			
			statusConfig.put('C', "공개");	
			statusConfig.put('S', "비공개");	
			
			declareConfig.put('N', "해결됨");	
			declareConfig.put('Y', "해결안됨");	
		
			model.addAttribute("memberCode", memberCode);
			model.addAttribute("declareConfig", declareConfig);
			model.addAttribute("statusConfig", statusConfig);
			
			return "admin/mapping/edit";
		}
	}
	
	@PostMapping(value = "/admin/mapping/edit")
	@ResponseBody
	@Transactional 
	public boolean edit(Mapping mapping, HttpSession session, @RequestBody Map<String, String> param) throws Exception {
		Long code		    	= Long.parseLong(param.get("code"));
		Long mapperCode			= Long.parseLong(param.get("mapperCode"));
		Long categoryCode   	= Long.parseLong(param.get("categoryCode"));
		Double latitude     	= Double.parseDouble(param.get("latitude"));  
		Double longitude    	= Double.parseDouble(param.get("longitude")); 
		String file	 	   		= param.get("cover");
		String filename    		= param.get("filename");
		String newFileName		= null;
		char is_declare	 		= (param.get("is_declare")).charAt(0);
		char status 	    	= (param.get("status")).charAt(0);
		String nameValues   	= param.get("NameValues").toString();
		Mapper mapper 			= mapperService.issetMapper(mapperCode);
		Mapping view 			= mappingService.view(code, mapper.getCode());
		MapperCategoryConfig categoryConfig = mapperCategoryConfigService.getView(categoryCode);
		
		try {
			List<Map<String, Object>> nameValuesMap = new Gson().fromJson(
					nameValues, new TypeToken<List<Map<String,Object>>>() {}.getType()
			);
			
			if(file != "") {
				UUID uuid = UUID.randomUUID();
				newFileName = uuid + "_" +filename;
				
				mapping.setFileName(newFileName);
				makeFileWithString(file, newFileName);
				deleteFile(view.getFileName(), UPLOAD_PATH);
			}
			
			mapping.setCode(code);
			mapping.setStatus(status);
			mapping.setIs_declare(is_declare);
			mapping.setMapperCategoryConfig(categoryConfig);
			mapping.setMarkerImg(categoryConfig.getImgPath());
			mapping.setAddress(param.get("address"));
			mapping.setLatitude(latitude);
			mapping.setLongitude(longitude);
			
			boolean result =  mappingService.update(mapping, mapper, categoryConfig);
			
			if(!result) {
				throw new Exception();
			}
			
			String replaceCode;
			String replaceConfigCode;
			String values;
			for (int i = 0; i < nameValuesMap.size(); i++) {
				values 			    = String.valueOf(nameValuesMap.get(i).get("values"));
				replaceCode 	    = String.valueOf(nameValuesMap.get(i).get("code")).replace(".0", "");
				replaceConfigCode   = String.valueOf(nameValuesMap.get(i).get("configCode")).replace(".0", "");
				Long hasNamesCode   = Long.parseLong(replaceCode);
				Long nameConfigCode = Long.parseLong(replaceConfigCode);
				
				MapperNameConfig MapperNameConfig = mapperNameConfigService.getView(nameConfigCode);
				
				MappingHasNames mappingHasNames = mappingHasNamesService.getView(hasNamesCode);
				
				if(mappingHasNames != null) {
					MappingHasNames hasNames = new MappingHasNames();
					hasNames.setCode(hasNamesCode);
					hasNames.setFieldValues(values);
					
					mappingHasNamesService.update(hasNames);
				}
				
				if(mappingHasNames == null && MapperNameConfig != null) {
					MapperNameConfig config = mapperNameConfigService.getView(MapperNameConfig.getCode());
					
					MappingHasNames hasNames = new MappingHasNames();
					hasNames.setMapping(mapping);
					hasNames.setMapperNameConfig(config);
					hasNames.setFieldValues(values);
					
					mappingHasNamesService.insert(hasNames);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@GetMapping(value = "/admin/mapping/delete")
	@Transactional
	public void delete(HttpServletResponse response, @RequestParam Long code, @RequestParam Long mapperCode) throws IOException {
		Mapper mapper   = mapperService.issetMapper(mapperCode);
		Mapping mapping = mappingService.issetMapping(code);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(mapping == null) {
			out.println("<script>alert('잘못된 접근입니다..'); location.href='/';</script>");
			out.flush();
		}else {
			
			try {
				if(mapping.getFileName() != null) {
					deleteFile(mapping.getFileName(), UPLOAD_PATH);
				}
				
				List<MappingFiles> mappingFileList = mappingFilesService.getMappingFilesList(mapping.getTimestamp());

				for(MappingFiles item : mappingFileList) {
					if(item.getFileName() != null) {
						deleteFile(item.getFileName(), MAPPING_FILE_PATH);
					}
				}
				
				mappingFilesService.deleteByParent(mapping.getTimestamp());
				mappingHasNamesService.deleteByParent(mapping.getCode());
				int result = mappingService.delete(mapping.getCode());
				
				if(result > 0) {
					out.println("<script>location.href='/admin/mapping/index?mapperCode="+mapper.getCode()+"&memberCode="+ mapper.getMember().getCode() +"';</script>");
					out.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
				out.println("<script>alert('잘못된 접근입니다..'); location.href='/';</script>");
				out.flush();
			}
		}
	}
	
	private static void makeFileWithString(String base64, String newFileName){
		byte decode[] = Base64.decodeBase64(base64);
		FileOutputStream fos;
		
		try{
			File target = new File(UPLOAD_PATH + "" + newFileName);
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
