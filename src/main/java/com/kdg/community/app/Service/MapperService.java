package com.kdg.community.app.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Repository.MapperRepository;

@Service
@Transactional
public class MapperService {

	private final MapperRepository mapperRepository;

	public MapperService(MapperRepository mapperRepository) {
		this.mapperRepository = mapperRepository;
	}
	
}
