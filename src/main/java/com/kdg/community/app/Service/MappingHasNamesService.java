package com.kdg.community.app.Service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MappingHasNames;
import com.kdg.community.app.Repository.MappingHasNamesRepository;

@Service
@Transactional
public class MappingHasNamesService {

	private final MappingHasNamesRepository mappingHasNamesRepository;

	public MappingHasNamesService(MappingHasNamesRepository mappingHasNamesRepository) {
		this.mappingHasNamesRepository = mappingHasNamesRepository;
	}
	
	public MappingHasNames insert(MappingHasNames mappingHasNames) {
		return mappingHasNamesRepository.save(mappingHasNames);
	}
	
	public List<MappingHasNames> getMappingHasNamesList (Long mappingCode){
		return mappingHasNamesRepository.getMappingHasNamesList(mappingCode);
	}
	
	
	@Transactional
	public boolean update(MappingHasNames mappingHasNames) {
		MappingHasNames updateMappingHasNames = mappingHasNamesRepository.view(mappingHasNames.getCode());
		
		updateMappingHasNames.setCode(mappingHasNames.getCode());
		updateMappingHasNames.setFieldValues(mappingHasNames.getFieldValues());
		
		return true;
	}
	
	public void deleteByMapperNameConfig (Long mapperNameCode) {
		mappingHasNamesRepository.deleteByMapperNameConfig(mapperNameCode);
	}
	
	
	public void deleteByParent (Long mappingCode) {
		mappingHasNamesRepository.deleteByParent(mappingCode);
	}
	
}
