package com.kdg.community.admin.Controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.Mapping;
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
		
		model.addAttribute("getTotalElements", mappingList.getTotalElements()); //전체 데이터 수
		model.addAttribute("getTotalPages", mappingList.getTotalPages());       //전체 페이지 수
		model.addAttribute("hasNext", mappingList.hasNext()); 					//이전 페이지 여부
		model.addAttribute("hasPrevious", mappingList.hasPrevious());	        //다음 페이지 여부
		
		model.addAttribute("mappingList", mappingList.getContent());
		model.addAttribute("page", page + 1);
		model.addAttribute("mapper", mapper);
		model.addAttribute("memberCode", memberCode);
		
		return "admin/mapping/index";
	}
}
