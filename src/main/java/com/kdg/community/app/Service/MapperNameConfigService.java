package com.kdg.community.app.Service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Repository.MapperNameConfigRepository;

@Service
@Transactional
public class MapperNameConfigService {

	private final MapperNameConfigRepository mapperNameConfigRepository;

	public MapperNameConfigService(MapperNameConfigRepository mapperNameConfigRepository) {
		this.mapperNameConfigRepository = mapperNameConfigRepository;
	}
	
	public List<MapperNameConfig> getNameConfigList (Long mapperCode){
		return mapperNameConfigRepository.getNameConfigList(mapperCode);
	}
	
	public MapperNameConfig insert(MapperNameConfig mapperNameConfig) {
		return mapperNameConfigRepository.save(mapperNameConfig);
	}
	
	public MapperNameConfig getView (Long code) {
		return mapperNameConfigRepository.getView(code);
	}
	
	public boolean update (MapperNameConfig mapperNameConfig) {
		MapperNameConfig config = mapperNameConfigRepository.getView(mapperNameConfig.getCode());
		
		config.setName(mapperNameConfig.getName());
		
		return true;
	}
	
	public void deleteByParent (Long mapperCode) {
		mapperNameConfigRepository.deleteByParent(mapperCode);
	}
}
