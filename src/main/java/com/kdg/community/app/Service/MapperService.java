package com.kdg.community.app.Service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.Mapper;
import com.kdg.community.app.Repository.MapperRepository;

@Service
@Transactional
public class MapperService {
	
	private final MapperRepository mapperRepository;

	public MapperService(MapperRepository mapperRepository) {
		this.mapperRepository = mapperRepository;
	}
	
	public List<Mapper> mapperList (Long memberCode){
		return mapperRepository.findByMemberCodeOrderByWriteDateDesc(memberCode);
	}
	
	public Mapper insert(Mapper mapper) {
		return mapperRepository.save(mapper);
	}
	
	public Mapper view (Long code, Long memberCode) {
		return mapperRepository.view(code, memberCode);
	}

}
