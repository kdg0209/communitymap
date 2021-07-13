package com.kdg.community.app.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MapperCategoryConfig;
import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Repository.MapperCategoryConfigRepository;

@Service
@Transactional
public class MapperCategoryConfigService {

	private final MapperCategoryConfigRepository mapperCategoryConfigRepository;

	public MapperCategoryConfigService(MapperCategoryConfigRepository mapperCategoryConfigRepository) {
		this.mapperCategoryConfigRepository = mapperCategoryConfigRepository;
	}
	
	public MapperCategoryConfig insert(MapperCategoryConfig mapperCategoryConfig) {
		return mapperCategoryConfigRepository.save(mapperCategoryConfig);
	}
}
