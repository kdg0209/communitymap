package com.kdg.community.app.Controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.google.gson.Gson;
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
	public String index(HttpServletResponse response, Model model, @RequestParam Long mapperCode) throws Exception {
		Mapper mapper = mapperService.issetMapper(mapperCode);
		
		if(mapper == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('잘못된 접근입니다.'); location.href='/';</script>");
			out.flush();
			return "";
		}else {
			double south_west_lng = 127.34119882365631;
			double north_east_lng = 127.43504419962248;
			double south_west_lat = 36.276630375631854;
			double north_east_lat = 36.420513558735344;
			
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
			
			model.addAttribute("mapper", mapper);
			model.addAttribute("categoryList", categoryMap);
			model.addAttribute("dataList", dataList);
			model.addAttribute("json", json);
			return "app/map/index";
		}
	}
	
	@PostMapping(value = "/app/map/data")
	public ModelAndView data(Model model, @RequestBody Map<String, String> params) throws Exception {
		double south_west_lng = Double.parseDouble((String) params.get("south_west_lng"));
		double north_east_lng = Double.parseDouble((String) params.get("north_east_lng"));
		double south_west_lat = Double.parseDouble((String) params.get("south_west_lat"));
		double north_east_lat = Double.parseDouble((String) params.get("north_east_lat"));
		Long mapperCode 	  = Long.parseLong((String) params.get("mapperCode"));
		
		List<Object[]> mappingList = mappingService.mappingMarkerListData(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat);
		List<Object> dataList = new ArrayList<Object>();
		String nameArray [] = {"code", "markerImg", "latitude", "longitude"};
		
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
		double south_west_lng = Double.parseDouble((String) params.get("south_west_lng"));
		double north_east_lng = Double.parseDouble((String) params.get("north_east_lng"));
		double south_west_lat = Double.parseDouble((String) params.get("south_west_lat"));
		double north_east_lat = Double.parseDouble((String) params.get("north_east_lat"));
		Long mapperCode 	  = Long.parseLong((String) params.get("mapperCode"));
		
		List<Object[]> mappingList = mappingService.mappingListByAllMap(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat);
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
		Long code = Long.parseLong((String) params.get("code"));
		
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
	public String slideDetail(Model model, @RequestBody Map<String, String> params) throws Exception {
		Long code = Long.parseLong((String) params.get("code"));
		Long mapperCode = Long.parseLong((String) params.get("mapperCode"));
		
		List<MapperCategoryConfig> categoryConfigList = mapperCategoryConfigService.getCategoryConfigList(mapperCode);
		List<MapperNameConfig> namesConfigList 		  = mapperNameConfigService.getNameConfigList(mapperCode);
		Mapping mapping 							  = mappingService.view(code, mapperCode);
		List<MappingFiles>    mappingFilesList        = mappingFilesService.getMappingFilesList(mapping.getTimestamp());
		List<MappingHasNames> mappingHasNamesList     = mappingHasNamesService.getMappingHasNamesList(mapping.getCode());
		
		model.addAttribute("categoryConfigList",categoryConfigList);
		model.addAttribute("namesConfigList",namesConfigList);
		model.addAttribute("mapping",mapping);
		model.addAttribute("mappingFilesList",mappingFilesList);
		model.addAttribute("mappingHasNamesList",mappingHasNamesList);
		
		return "app/map/slideDetail";
	}
}
