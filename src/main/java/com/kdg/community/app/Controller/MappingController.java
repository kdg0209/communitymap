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
import java.util.Optional;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.kdg.community.app.Common.GetUserIp;
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
public class MappingController {

	private final MappingService mappingService;
	private final MapperService mapperService;
	private final MapperNameConfigService mapperNameConfigService;
	private final MapperCategoryConfigService mapperCategoryConfigService;
	private final MappingHasNamesService mappingHasNamesService;
	private final MappingFilesService mappingFilesService;
	
	private static final String UPLOAD_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mappingCover\\"; //?????? ??????
	private static final String MAPPING_FILE_PATH = "C:\\Users\\cova7\\eclipse-workspace\\communitymap\\src\\main\\webapp\\resources\\files\\mappingFiles\\"; //?????? ??????
	
	public MappingController(MappingService mappingService, MapperService mapperService,
			MapperNameConfigService mapperNameConfigService, MapperCategoryConfigService mapperCategoryConfigService,
			MappingHasNamesService mappingHasNamesService, MappingFilesService mappingFilesService) {
		this.mappingService = mappingService;
		this.mapperService = mapperService;
		this.mapperNameConfigService = mapperNameConfigService;
		this.mapperCategoryConfigService = mapperCategoryConfigService;
		this.mappingHasNamesService = mappingHasNamesService;
		this.mappingFilesService = mappingFilesService;
	}

	@GetMapping(value = "/app/mapping/index")
	@Transactional
	public String index(Model model, @RequestParam Long mapperCode, @RequestParam(defaultValue = "1") int page) {
		page = page - 1;
		
		Pageable pageable		  = PageRequest.of(page, 6, Sort.by(Sort.Direction.DESC, "is_declare", "writeDate"));
		Mapper mapper 			  = mapperService.issetMapper(mapperCode);
		Page<Mapping> mappingList = mappingService.mappingListByMapper(mapperCode, pageable);
		List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapper.getCode());
		
		model.addAttribute("getTotalElements", mappingList.getTotalElements()); //?????? ????????? ???
		model.addAttribute("getTotalPages", mappingList.getTotalPages());       //?????? ????????? ???
		model.addAttribute("hasNext", mappingList.hasNext()); 					//?????? ????????? ??????
		model.addAttribute("hasPrevious", mappingList.hasPrevious());	        //?????? ????????? ??????
		
		model.addAttribute("categoryConfigList", categoryConfigList);
		model.addAttribute("mappingList", mappingList.getContent());
		model.addAttribute("page", page + 1);
		model.addAttribute("mapperCode", mapperCode);
		
		return "app/mapping/index";
	}
	
	@GetMapping(value = "/app/mapping/write")
	@Transactional
	public String write(HttpServletResponse response, HttpSession session, Model model, @RequestParam Long mapperCode, @RequestParam(defaultValue = "") String key) throws IOException {
		Long memberCode = (Long)session.getAttribute("code");
		Mapper mapper 	= mapperService.issetMapper(mapperCode);
		
		List<String> userWriteAuthorityList = (List)session.getAttribute("userWriteAuthorityList");
		
		if(mapper == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('????????? ???????????????.'); location.href='/';</script>");
			out.flush();
			return "/";
		}else {
			
			if(mapper.getEditAuth() == 2) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out   = response.getWriter();
				boolean isContain = userKeyCheck(userWriteAuthorityList, key); 
				
				if(!isContain) {
					out.println("<script>alert('????????? ???????????????.'); location.href='/';</script>");
					out.flush();
					return "index";
				}
			}
			if(mapper.getEditAuth() == 3) {
				Mapper isMapper = mapperService.view(mapper.getCode(), memberCode);
				
				if(isMapper == null) {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					
					out.println("<script>alert('????????? ???????????????.'); location.href='/';</script>");
					out.flush();
					return "index";
				}
			}
			
			long timestamp 								  = System.currentTimeMillis();
			List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapper.getCode());
			List<MapperNameConfig> namesConfigList 		  = mapperNameConfigService.getNameConfigList(mapper.getCode());
			
			model.addAttribute("key", key);
			model.addAttribute("isMe",isMe(mapper, memberCode));
			model.addAttribute("timestamp", timestamp);
			model.addAttribute("mapperCode", mapperCode);
			model.addAttribute("editAuth", mapper.getEditAuth());
			model.addAttribute("categoryConfigList", categoryConfigList);
			model.addAttribute("namesConfigList", namesConfigList);
			
			Map<Character, String> statusConfig = new HashMap<Character, String>();
			
			statusConfig.put('C', "??????");	
			statusConfig.put('S', "?????????");	
		
			model.addAttribute("statusConfig", statusConfig);
			
			return "app/mapping/write";
		}
	}
	
	@PostMapping(value = "/app/mapping/write")
	@ResponseBody
	@Transactional
	public Long write(Mapping mapping, HttpSession session, Model model, @RequestBody Map<String, String> param) throws Exception {
		List<String> userAuthorityList = (List)session.getAttribute("userAuthorityList");
		GetUserIp getUserIp 	= new GetUserIp();
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		Date time 				= new Date();
		String nameValues       = param.get("NameValues").toString();
		String key	 	   		= param.get("key");
		String file	 	   		= param.get("cover");
		String filename    		= param.get("filename");
		String newFileName 		= null;
		
		List<Map<String, Object>> nameValuesMap = new Gson().fromJson(
				nameValues, new TypeToken<List<Map<String,Object>>>() {}.getType()
		);
		
		Long mapperCode   = Long.parseLong(param.get("mapperCode")); 
		Long categoryCode = Long.parseLong(param.get("categoryCode"));  
		Long timestamp 	  = Long.parseLong(param.get("timestamp"));  
		Double latitude   = Double.parseDouble(param.get("latitude"));  
		Double longitude  = Double.parseDouble(param.get("longitude"));  
		char status 	  = (param.get("status")).charAt(0);
		MapperCategoryConfig categoryConfig = mapperCategoryConfigService.getView(categoryCode);
		Mapper mapper 	  = mapperService.issetMapper(mapperCode);
		
		if(file != "") {
			UUID uuid = UUID.randomUUID();
			
			newFileName = uuid + "_" +filename;
			makeFileWithString(file, newFileName);
		}
		
		mapping.setMd_type("mapping");
		mapping.setMd_id("mapping");
		mapping.setMd_id("mapping");
		mapping.setIs_declare('N');
		mapping.setFileName(newFileName);
		mapping.setStatus(status);
		mapping.setTimestamp(timestamp);
		mapping.setMapper(mapper);
		mapping.setMapperCategoryConfig(categoryConfig);
		mapping.setMarkerImg(categoryConfig.getImgPath());
		mapping.setAddress(param.get("address"));
		mapping.setLatitude(latitude);
		mapping.setLongitude(longitude);
		mapping.setWriteDate(format.format(time));
		mapping.setWriteIp(getUserIp.returnIP());
		
		mappingService.insert(mapping);
		
		String replaceCode;
		String values;
		for (int i = 0; i < nameValuesMap.size(); i++) {
			values 			= String.valueOf(nameValuesMap.get(i).get("values"));
			replaceCode 	= String.valueOf(nameValuesMap.get(i).get("code")).replace(".0", "");
			Long configCode = Long.parseLong(replaceCode);
		
			MapperNameConfig config = mapperNameConfigService.getView(configCode);
			
			MappingHasNames hasNames = new MappingHasNames();
			hasNames.setMapping(mapping);
			hasNames.setMapperNameConfig(config);
			hasNames.setFieldValues(values);
			
			mappingHasNamesService.insert(hasNames);
		}
		
		if(userAuthorityList != null) {
			userAuthorityList.remove(key);
			session.setAttribute("userWriteAuthorityList", userAuthorityList);
		}
		
		return mapperCode;
	}
	
	@GetMapping(value = "/app/mapping/edit")
	@Transactional
	public String edit(HttpServletResponse response, HttpSession session, Model model, @RequestParam Long code, @RequestParam Long mapperCode, @RequestParam(defaultValue = "") String key) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		Long memberCode = (Long)session.getAttribute("code");
		Mapper mapper 	= mapperService.issetMapper(mapperCode);
		
		List<String> userEditAuthorityList = (List)session.getAttribute("userEditAuthorityList");
		
		if(mapper == null) {
			out.println("<script>alert('?????? ????????? ????????????.'); location.href='/app/login/index';</script>");
			out.flush();
			
			return "app/login/index";
		}else {
			
			if(mapper.getEditAuth() == 2) {
				Mapper isMapper   = mapperService.view(mapper.getCode(), memberCode);
				boolean isContain = userKeyCheck(userEditAuthorityList, key); 
				
				if(isMapper == null && !isContain) {
					out.println("<script>alert('????????? ???????????????.'); location.href='/';</script>");
					out.flush();
					return "index";
				}
			}
			if(mapper.getEditAuth() == 3) {
				Mapper isMapper = mapperService.view(mapper.getCode(), memberCode);
				
				if(isMapper == null) {
					out.println("<script>alert('????????? ???????????????.'); location.href='/';</script>");
					out.flush();
					return "index";
				}
			}
			
			List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapper.getCode());
			List<MapperNameConfig> namesConfigList 		  = mapperNameConfigService.getNameConfigList(mapper.getCode());
			Mapping mapping 							  = mappingService.view(code, mapper.getCode());
			List<MappingFiles>    mappingFilesList        = mappingFilesService.getMappingFilesList(mapping.getTimestamp());
			List<MappingHasNames> mappingHasNamesList     = mappingHasNamesService.getMappingHasNamesList(mapping.getCode());
			
			model.addAttribute("isMe",isMe(mapper, memberCode));
			model.addAttribute("categoryConfigList",categoryConfigList);
			model.addAttribute("namesConfigList",namesConfigList);
			model.addAttribute("mapping",mapping);
			model.addAttribute("mappingFilesList",mappingFilesList);
			model.addAttribute("mappingHasNamesList",mappingHasNamesList);
			
			Map<Character, String> statusConfig = new HashMap<Character, String>();
			Map<Character, String> declareConfig = new HashMap<Character, String>();
			
			statusConfig.put('C', "??????");	
			statusConfig.put('S', "?????????");	
			
			declareConfig.put('N', "?????????");	
			declareConfig.put('Y', "????????????");	
		
			model.addAttribute("declareConfig", declareConfig);
			model.addAttribute("statusConfig", statusConfig);
			
			if(userEditAuthorityList != null) {
				userEditAuthorityList.remove(key);
				session.setAttribute("userEditAuthorityList", userEditAuthorityList);
			}

			return "app/mapping/edit";
		}
	}
	
	@PostMapping(value = "/app/mapping/edit")
	@ResponseBody
	@Transactional // MapperCategoryConfig Lazy???????????? ?????? ??????
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
	
	@GetMapping(value = "/app/mapping/delete")
	@Transactional
	public void delete(HttpServletResponse response, HttpSession session, @RequestParam Long code, @RequestParam Long mapperCode) throws IOException {
		Long memberCode = (Long) session.getAttribute("code");
		Mapper mapper 	= mapperService.view(mapperCode, memberCode);
		Mapping mapping = mappingService.view(code, mapper.getCode());
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(mapping == null) {
			out.println("<script>alert('????????? ???????????????..'); location.href='/';</script>");
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
					out.println("<script>location.href='/app/mapping/index?mapperCode="+ mapper.getCode() +"';</script>");
					out.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
				out.println("<script>alert('????????? ???????????????..'); location.href='/';</script>");
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
	
	private boolean userKeyCheck(List<String> userKeyAuthorityList, String key) {
		try {
			boolean isContain = userKeyAuthorityList.contains(key);
			
			if(!isContain) {
				return false;
			}
		} catch (Exception e) {
			return false;
		}
		return true;
	}
	
	
	private boolean isMe(Mapper mapper, Long memberCode) {
		try {
			if(mapper.getMember().getCode().equals(memberCode)) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
