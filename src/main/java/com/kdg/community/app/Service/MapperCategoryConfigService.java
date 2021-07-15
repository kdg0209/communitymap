package com.kdg.community.app.Service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Repository.MapperCategoryConfigRepository;

@Service
@Transactional
public class MapperCategoryConfigService {

	private final MapperCategoryConfigRepository mapperCategoryConfigRepository;

	public MapperCategoryConfigService(MapperCategoryConfigRepository mapperCategoryConfigRepository) {
		this.mapperCategoryConfigRepository = mapperCategoryConfigRepository;
	}
	
	public List<MapperCategoryConfig> getCategoryConfigList (Long mapperCode){
		return mapperCategoryConfigRepository.getCategoryConfigList(mapperCode);
	}
	
	
	public MapperCategoryConfig insert(MapperCategoryConfig mapperCategoryConfig) {
		return mapperCategoryConfigRepository.save(mapperCategoryConfig);
	}
}
