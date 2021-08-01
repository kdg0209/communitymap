package com.kdg.community.app.Service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Domain.Mapping;
import com.kdg.community.app.Repository.MappingRepository;

@Service
@Transactional
public class MappingService {

	private final MappingRepository mappingRepository;

	public MappingService(MappingRepository mappingRepository) {
		this.mappingRepository = mappingRepository;
	}
	
	public Page<Mapping> mappingListByMapper(Long mapperCode, Pageable pageable){
		return mappingRepository.mappingListByMapper(mapperCode,  pageable);
	}
	
	public List<Object[]> mappingListByAllMap(Long mapperCode, Double south_west_lng, Double north_east_lng, Double south_west_lat, Double north_east_lat){
		return mappingRepository.mappingListByAllMap(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat);
	}
	
	public List<Object[]> mappingCategoryListByAllMap(Long mapperCode, Double south_west_lng, Double north_east_lng, Double south_west_lat, Double north_east_lat, List<Long> categoryCode){
		return mappingRepository.mappingCategoryListByAllMap(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat, categoryCode);
	}
	
	public List<Object[]> mappingMarkerListData(Long mapperCode, Double south_west_lng, Double north_east_lng, Double south_west_lat, Double north_east_lat){
		return mappingRepository.mappingMarkerListData(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat);
	}
	
	public List<Object[]> mappingMarkerCategoryListData(Long mapperCode, Double south_west_lng, Double north_east_lng, Double south_west_lat, Double north_east_lat, List<Long> categoryCode){
		return mappingRepository.mappingMarkerCategoryListData(mapperCode, south_west_lng, north_east_lng, south_west_lat, north_east_lat, categoryCode);
	}
	
	public List<Object[]> mappingSelectOneMarker(Long code){
		return mappingRepository.mappingSelectOneMarker(code);
	}
	
	public List<Mapping> mappingList(Long mapperCode){
		return mappingRepository.mappingList(mapperCode);
	}
	
	public List<Mapping> findCategoryCodeList(Long categoryCode){
		return mappingRepository.findCategoryCodeList(categoryCode);
	}
	
	public Mapping insert(Mapping mapping) {
		return mappingRepository.save(mapping);
	}
	
	public Mapping view (Long code, Long mapperCode) {
		return mappingRepository.view(code, mapperCode);
	}
	
	public boolean update(Mapping mapping, Mapper mapper,MapperCategoryConfig mapperCategoryConfig) {
		Mapping updateMapping = mappingRepository.view(mapping.getCode(), mapper.getCode());
		
		updateMapping.setStatus(mapping.getStatus());
		updateMapping.setIs_declare(mapping.getIs_declare());
		updateMapping.setMapperCategoryConfig(mapperCategoryConfig);
		updateMapping.setMarkerImg(mapping.getMarkerImg());
		updateMapping.setAddress(mapping.getAddress());
		updateMapping.setLatitude(mapping.getLatitude());
		updateMapping.setLongitude(mapping.getLongitude());

		if(mapping.getFileName() != null) {
			updateMapping.setFileName(mapping.getFileName());
		}
		return true;
	}
	public boolean DeclareUpdate(Long mappingCode, Long mapperCode) {
		Mapping updateMapping = mappingRepository.view(mappingCode, mapperCode);
		
		updateMapping.setIs_declare('Y');
		return true;
	}
	

	public boolean updateByCategoryDelete(Mapping mapping) {
		Mapping updateMapping = mappingRepository.view(mapping.getCode(), mapping.getMapper().getCode());
		
		updateMapping.setMapperCategoryConfig(null);
		updateMapping.setMarkerImg(null);

		return true;
	}
	
	public void delete (Long code) {
		mappingRepository.delete(code);
	}
}
