package com.kdg.community.app.Controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

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
public class MapController {
	
	private static List<String> userWriteAuthorityList = new ArrayList<String>(); // 사용자 작성 key array
	private static List<String> userEditAuthorityList = new ArrayList<String>(); // 사용자 수정 key array

	private final MapperService mapperService;
	private final MapperNameConfigService mapperNameConfigService;
	private final MapperCategoryConfigService mapperCategoryConfigService;
	private final MappingService mappingService;
	private final MappingHasNamesService mappingHasNamesService;
	private final MappingFilesService mappingFilesService;
	
	public MapController(MapperService mapperService, MapperNameConfigService mapperNameConfigService,
			MapperCategoryConfigService mapperCategoryConfigService, MappingService mappingService,
			MappingHasNamesService mappingHasNamesService, MappingFilesService mappingFilesService) {
		this.mapperService = mapperService;
		this.mapperNameConfigService = mapperNameConfigService;
		this.mapperCategoryConfigService = mapperCategoryConfigService;
		this.mappingService = mappingService;
		this.mappingHasNamesService = mappingHasNamesService;
		this.mappingFilesService = mappingFilesService;
	}
	
	@GetMapping(value = "/app/map/index")
	@Transactional
	public String index(HttpServletResponse response, Model model, @RequestParam Long mapperCode) throws Exception {
		Mapper mapper = mapperService.issetMapper(mapperCode);
		
		if(mapper == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('잘못된 접근입니다.'); location.href='/';</script>");
			out.flush();
			return "";
		}else {
			String userAuthority  = userAuthority(mapper); // 유저 권한 체크
			double south_west_lng = 127.34119882365631;
			double north_east_lng = 127.43504419962248;
			double south_west_lat = 36.276630375631854;
			double north_east_lat = 36.420513558735344;
			
			List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapper.getCode());
			List<Object[]> mappingList = mappingService.mappingListByAllMap(mapper.getCode(), south_west_lng, north_east_lng, south_west_lat, north_east_lat);
			List<Object> dataList = new ArrayList<Object>();
			String nameArray [] = {"code", "md_type", "md_id", "status", "timestamp", "is_declare", "mapperCode", 
								   "categoryCode", "markerImg", "fileName", "address", "latitude",
								   "longitude", "writeDate", "writeIp", "categoryName", "fieldValues"};
			
			for(Object[] item : mappingList) {
				int loop = 0;
				Map<String, Object> data = new HashMap<String, Object>();
				for(Object deppItem : item) {
					data.put(nameArray[loop++], deppItem);
				}
				dataList.add(data);
			}
			
			String json = new Gson().toJson(dataList);
			Map<Integer, String> categoryMap = new HashMap<Integer, String>();
			
			categoryMap.put(1, "문화");	
			categoryMap.put(2, "음식");	
			categoryMap.put(3, "여행");	
			categoryMap.put(4, "조사");	
			categoryMap.put(5, "안전");	
			categoryMap.put(6, "기타");	
			
			model.addAttribute("userAuthority", userAuthority);
			model.addAttribute("mapper", mapper);
			model.addAttribute("categoryList", categoryMap);
			model.addAttribute("categoryConfigList", categoryConfigList);
			model.addAttribute("dataList", dataList);
			model.addAttribute("json", json);
			return "app/map/index";
		}
	}
	
	@PostMapping(value = "/app/map/data")
	public ModelAndView data(Model model, @RequestBody Map<String, String> params) throws Exception {
		Long mapperCode 	  = Long.parseLong(params.get("mapperCode"));
		double south_west_lng = Double.parseDouble(params.get("south_west_lng"));
		double north_east_lng = Double.parseDouble(params.get("north_east_lng"));
		double south_west_lat = Double.parseDouble(params.get("south_west_lat"));
		double north_east_lat = Double.parseDouble(params.get("north_east_lat"));
		String categoryList   = params.get("categoryList").toString();
		List<Map<String, Object>> categoryMap = null;
		List<Long> categoryCodeValues = new ArrayList<Long>();
		List<Object[]> mappingList	  = new ArrayList<Object[]>();
		
		if(categoryList != null) {
			categoryMap = new Gson().fromJson(categoryList, new TypeToken<List<Map<String,Object>>>() {}.getType());
		}
		
		for (int i = 0; i < categoryMap.size(); i++) {
			String values 	  = String.valueOf(categoryMap.get(i).get("values"));
			Long categoryCode = Long.parseLong(values);
			categoryCodeValues.add(categoryCode);
		}
		
		if(categoryCodeValues.size() > 0) {
			mappingList = mappingService.mappingMarkerCategoryListData(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat, categoryCodeValues);
		}else {
			mappingList = mappingService.mappingMarkerListData(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat);
		}
		
		List<Object> dataList 	   = new ArrayList<Object>();
		String nameArray [] 	   = {"code", "markerImg", "latitude", "longitude"};
		
		for(Object[] item : mappingList) {
			int loop = 0;
			Map<String, Object> data = new HashMap<String, Object>();
			for(Object deppItem : item) {
				data.put(nameArray[loop++], deppItem);
			}
			dataList.add(data);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView(); // 자바 객체를 JSON 형식으로 변환
		modelAndView.setView(jsonView);
		
		model.addAttribute("dataList", dataList);
		return modelAndView;
	}
	
	@PostMapping(value = "/app/map/dataList")
	public ModelAndView dataList(Model model, @RequestBody Map<String, String> params) throws Exception {
		Long mapperCode 	  = Long.parseLong(params.get("mapperCode"));
		double south_west_lng = Double.parseDouble(params.get("south_west_lng"));
		double north_east_lng = Double.parseDouble(params.get("north_east_lng"));
		double south_west_lat = Double.parseDouble(params.get("south_west_lat"));
		double north_east_lat = Double.parseDouble(params.get("north_east_lat"));
		String categoryList   = params.get("categoryList").toString();
		List<Map<String, Object>> categoryMap = null;
		List<Long> categoryCodeValues = new ArrayList<Long>();
		List<Object[]> mappingList	  = new ArrayList<Object[]>();
		
		if(categoryList != null) {
			categoryMap = new Gson().fromJson(categoryList, new TypeToken<List<Map<String,Object>>>() {}.getType());
		}
		
		for (int i = 0; i < categoryMap.size(); i++) {
			String values 	  = String.valueOf(categoryMap.get(i).get("values"));
			Long categoryCode = Long.parseLong(values);
			categoryCodeValues.add(categoryCode);
		}
		
		if(categoryCodeValues.size() > 0) {
			mappingList = mappingService.mappingCategoryListByAllMap(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat, categoryCodeValues);
		}else {
			mappingList = mappingService.mappingListByAllMap(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat);
		}
		
		List<Object> dataList = new ArrayList<Object>();
		String nameArray [] = {"code", "md_type", "md_id", "status", "timestamp", "is_declare", "mapperCode", 
				   "categoryCode", "markerImg", "fileName", "address", "latitude",
				   "longitude", "writeDate", "writeIp", "categoryName", "fieldValues"};
		
		for(Object[] item : mappingList) {
			int loop = 0;
			Map<String, Object> data = new HashMap<String, Object>();
			for(Object deppItem : item) {
				data.put(nameArray[loop++], deppItem);
			}
			dataList.add(data);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView(); // 자바 객체를 JSON 형식으로 변환
		modelAndView.setView(jsonView);
		
		model.addAttribute("dataList", dataList);
		return modelAndView;
	}
	
	@PostMapping(value = "/app/map/selectMarker")
	public ModelAndView selectMarker(Model model, @RequestBody Map<String, String> params) throws Exception {
		Long code = Long.parseLong(params.get("code"));
		
		List<Object[]> mappingList = mappingService.mappingSelectOneMarker(code);
		List<Object> dataSelectOne = new ArrayList<Object>();
		String nameArray [] = {"code", "md_type", "md_id", "status", "timestamp", "is_declare", "mapperCode", 
				   "categoryCode", "markerImg", "fileName", "address", "latitude",
				   "longitude", "writeDate", "writeIp", "categoryName", "fieldValues"};
		
		for(Object[] item : mappingList) {
			int loop = 0;
			Map<String, Object> data = new HashMap<String, Object>();
			for(Object deppItem : item) {
				data.put(nameArray[loop++], deppItem);
			}
			dataSelectOne.add(data);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView(); // 자바 객체를 JSON 형식으로 변환
		modelAndView.setView(jsonView);
		
		model.addAttribute("dataSelectOne", dataSelectOne);
		return modelAndView;
	}
	
	@PostMapping(value = "/app/map/slideDetail")
	@Transactional
	public String slideDetail(HttpSession session, Model model, @RequestBody Map<String, String> params) throws Exception {
		Long memberCode = (Long)session.getAttribute("code");
		Long code 		= Long.parseLong(params.get("code"));
		Long mapperCode = Long.parseLong(params.get("mapperCode"));
		
		Mapper mapper 								  = mapperService.issetMapper(mapperCode);
		List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapperCode);
		List<MapperNameConfig> namesConfigList 		  = mapperNameConfigService.getNameConfigList(mapperCode);
		Mapping mapping 							  = mappingService.view(code, mapperCode);
		List<MappingFiles>    mappingFilesList        = mappingFilesService.getMappingFilesList(mapping.getTimestamp());
		List<MappingHasNames> mappingHasNamesList     = mappingHasNamesService.getMappingHasNamesList(mapping.getCode());
		String userAuthority 						  = userAuthority(mapper); // 유저 권한 체크
		
		model.addAttribute("memberCode", memberCode);
		model.addAttribute("userAuthority", userAuthority);
		model.addAttribute("categoryConfigList",categoryConfigList);
		model.addAttribute("namesConfigList",namesConfigList);
		model.addAttribute("mapperMemberCode",mapper.getMember().getCode());
		model.addAttribute("mapping",mapping);
		model.addAttribute("mappingFilesList",mappingFilesList);
		model.addAttribute("mappingHasNamesList",mappingHasNamesList);
		
		return "app/map/slideDetail";
	}
	
	@GetMapping(value = "/app/map/editPasswordConfirm")
	public String editPasswordConfirm(HttpServletResponse response, Model model, @RequestParam Long mappingCode, @RequestParam Long mapperCode) throws Exception {
		Mapping mapping = mappingService.view(mappingCode, mapperCode);
		
		if(mapping == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('잘못된 접근입니다.'); location.href='/';</script>");
			out.flush();
			return "";
		}else {
			model.addAttribute("mappingCode", mappingCode);
			model.addAttribute("mapperCode", mapperCode);
			return "app/map/editPasswordConfirm";
		}
	}
	
	@PostMapping(value = "/app/map/editPasswordConfirm")
	@ResponseBody
	public ModelAndView editPasswordConfirm(HttpSession session, Model model, @RequestBody Map<String, String> params) throws Exception {
		Long mappingCode 	= Long.parseLong(params.get("mappingCode"));
		Long mapperCode 	= Long.parseLong(params.get("mapperCode"));
		String editPassword = params.get("editPassword");
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		Mapper mapper		= mapperService.issetMapper(mapperCode);
		
		
		ModelAndView modelAndView = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView(); // 자바 객체를 JSON 형식으로 변환
		modelAndView.setView(jsonView);
		
		if(mapper == null) {
			model.addAttribute("result", false);
		}else {
			if(encoder.matches(editPassword, mapper.getEditPassword())) {
				
				String key = getUUID();
				userEditAuthorityList.add(key);
				
				session.setAttribute("userEditAuthorityList", userEditAuthorityList);
				
				model.addAttribute("key", key);
				model.addAttribute("mappingCode", mappingCode);
				model.addAttribute("mapperCode", mapperCode);
				model.addAttribute("result", true);
			}else {
				model.addAttribute("result", false);
			}
		}
		
		return modelAndView;
	}
	
	@GetMapping(value = "/app/map/passwordConfirm")
	public String passwordConfirm(HttpServletResponse response, Model model, @RequestParam Long mapperCode) throws Exception {
		Mapper mapper = mapperService.issetMapper(mapperCode);
		
		if(mapper == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('잘못된 접근입니다.'); location.href='/';</script>");
			out.flush();
			return "";
		}else {
			model.addAttribute("mapperCode", mapper.getCode());
			return "app/map/passwordConfirm";
		}
	}
	
	@PostMapping(value = "/app/map/passwordConfirm")
	@ResponseBody
	public ModelAndView passwordConfirm(HttpSession session, Model model, @RequestBody Map<String, String> params) throws Exception {
		Long mapperCode 	= Long.parseLong(params.get("mapperCode"));
		String editPassword = params.get("editPassword");
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		Mapper mapper 		= mapperService.issetMapper(mapperCode);
		
		ModelAndView modelAndView 		 = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView(); // 자바 객체를 JSON 형식으로 변환
		modelAndView.setView(jsonView);
		
		if(mapper == null) {
			model.addAttribute("result", false);
		}else {
			if(encoder.matches(editPassword, mapper.getEditPassword())) {
				
				String key = getUUID();
				userWriteAuthorityList.add(key);
				
				session.setAttribute("userWriteAuthorityList", userWriteAuthorityList);
				
				model.addAttribute("key", key);
				model.addAttribute("result", true);
			}else {
				model.addAttribute("result", false);
			}
		}
		
		return modelAndView;
	}
	
	private String userAuthority(Mapper mapper) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpSession session		   = request.getSession(true);
		Long memberCode 		   = (Long)session.getAttribute("code");
		
		if(mapper.getEditAuth() == 1) {	//누구나 접근 가능
			return "all";
		}else if(mapper.getEditAuth() == 2){ //friend만 접근 가능
			return "friend";
		}else if(mapper.getEditAuth() == 3){ //본인만 접근 가능
			if(memberCode != null && mapper.getMember().getCode().equals(memberCode)) {
				return "me";
			}
		}
		return "nothing";
	}
	
    private  String getUUID() {
	    String uuid = UUID.randomUUID().toString();
	    
	    // "-" 하이픈 제외
	    uuid = uuid.replace("-", "");
	    return uuid;
    }
}
