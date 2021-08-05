package com.kdg.community.app.Service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MapperNameConfig;
import com.kdg.community.app.Domain.MappingHasNames;
import com.kdg.community.app.Repository.MappingHasNamesRepository;

@Service
@Transactional
public class MappingHasNamesService {

	private final MappingHasNamesRepository mappingHasNamesRepository;

	public MappingHasNamesService(MappingHasNamesRepository mappingHasNamesRepository) {
		this.mappingHasNamesRepository = mappingHasNamesRepository;
	}
	
	public List<MappingHasNames> getMappingHasNamesList (Long mappingCode){
		return mappingHasNamesRepository.getMappingHasNamesList(mappingCode);
	}
	
	public MappingHasNames insert(MappingHasNames mappingHasNames) {
		return mappingHasNamesRepository.save(mappingHasNames);
	}
	
	public MappingHasNames getView (Long code) {
		return mappingHasNamesRepository.getView(code);
	}
	
	@Transactional
	public boolean update(MappingHasNames mappingHasNames) {
		MappingHasNames updateMappingHasNames = mappingHasNamesRepository.getView(mappingHasNames.getCode());
		
		updateMappingHasNames.setCode(mappingHasNames.getCode());
		updateMappingHasNames.setFieldValues(mappingHasNames.getFieldValues());
		
		return true;
	}
	
	public int deleteByMapperNameConfig (Long mapperNameCode) {
		return mappingHasNamesRepository.deleteByMapperNameConfig(mapperNameCode);
	}
	
	public void deleteByParent (Long mappingCode) {
		mappingHasNamesRepository.deleteByParent(mappingCode);
	}
	
}
