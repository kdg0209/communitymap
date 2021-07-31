package com.kdg.community.app.Service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MappingDeclare;
import com.kdg.community.app.Repository.MappingdeclareRepository;

@Service
@Transactional
public class MappingDeclareService {

	private final MappingdeclareRepository mappingdeclareRepository;

	public MappingDeclareService(MappingdeclareRepository mappingdeclareRepository) {
		this.mappingdeclareRepository = mappingdeclareRepository;
	}
	
	public Page<MappingDeclare> declareList(Long mappingCode, Pageable pageable){
		return mappingdeclareRepository.declareList(mappingCode,  pageable);
	}
	
	public MappingDeclare insert(MappingDeclare mappingdeclare) {
		return mappingdeclareRepository.save(mappingdeclare);
	}
}
