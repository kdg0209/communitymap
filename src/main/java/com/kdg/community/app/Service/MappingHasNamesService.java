package com.kdg.community.app.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Repository.MappingHasNamesRepository;

@Service
@Transactional
public class MappingHasNamesService {

	private final MappingHasNamesRepository mappingHasNamesRepository;

	public MappingHasNamesService(MappingHasNamesRepository mappingHasNamesRepository) {
		this.mappingHasNamesRepository = mappingHasNamesRepository;
	}
	
	
}
