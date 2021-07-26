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
