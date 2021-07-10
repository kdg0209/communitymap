package com.kdg.community.app.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Repository.MapperNameConfigRepository;

@Service
@Transactional
public class MapperNameConfigService {

	private final MapperNameConfigRepository mapperNameConfigRepository;

	public MapperNameConfigService(MapperNameConfigRepository mapperNameConfigRepository) {
		this.mapperNameConfigRepository = mapperNameConfigRepository;
	}
}
