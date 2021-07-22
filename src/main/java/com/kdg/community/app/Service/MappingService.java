package com.kdg.community.app.Service;

import java.util.List;

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
	
	public List<Mapping> mappingList(Long mapperCode){
		return mappingRepository.findByMapperCodeOrderByWriteDateDesc(mapperCode);
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
	
	public void delete (Long code) {
		mappingRepository.delete(code);
	}
}
