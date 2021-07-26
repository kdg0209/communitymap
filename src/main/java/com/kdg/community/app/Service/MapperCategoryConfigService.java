package com.kdg.community.app.Service;

import java.util.List;

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
	
	public List<MapperCategoryConfig> getCategoryConfigList (Long mapperCode){
		return mapperCategoryConfigRepository.getCategoryConfigList(mapperCode);
	}
	
	
	public MapperCategoryConfig insert(MapperCategoryConfig mapperCategoryConfig) {
		return mapperCategoryConfigRepository.save(mapperCategoryConfig);
	}
	
	public MapperCategoryConfig getView (Long code) {
		return mapperCategoryConfigRepository.getView(code);
	}
	
	public boolean update (MapperCategoryConfig mapperCategoryConfig) {
		MapperCategoryConfig config = mapperCategoryConfigRepository.getView(mapperCategoryConfig.getCode());
		
		config.setName(mapperCategoryConfig.getName());
		config.setImgPath(mapperCategoryConfig.getImgPath());
		
		return true;
	}
	
	public void delete (Long code) {
		mapperCategoryConfigRepository.delete(code);
	}
	
	public void deleteByParent (Long mapperCode) {
		mapperCategoryConfigRepository.deleteByParent(mapperCode);
	}
}
