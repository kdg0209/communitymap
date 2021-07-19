package com.kdg.community.app.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MappingFiles;
import com.kdg.community.app.Repository.MappingFilesRepository;

@Service
@Transactional
public class MappingFilesService {

	private final MappingFilesRepository mappingFilesRepository;

	public MappingFilesService(MappingFilesRepository mappingFilesRepository) {
		this.mappingFilesRepository = mappingFilesRepository;
	}
	
	public MappingFiles insert(MappingFiles mappingFiles) {
		return mappingFilesRepository.save(mappingFiles);
	}
	
	public MappingFiles getView(Long code) {
		return mappingFilesRepository.getView(code);
	}
	
	public void delete(Long code) {
		mappingFilesRepository.delete(code);
	}
}
