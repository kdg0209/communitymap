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
	
	public boolean update(Long memberCode, Mapper mapper) {
		Mapper updateMapper = mapperRepository.view(mapper.getCode(), memberCode);
		
		updateMapper.setName(mapper.getName());
		updateMapper.setContents(mapper.getContents());
		updateMapper.setCategoryCode(mapper.getCategoryCode());
		updateMapper.setEditAuth(mapper.getEditAuth());
		updateMapper.setEditPassword(mapper.getEditPassword());
		if(mapper.getFileName() != null) {
			updateMapper.setFileName(mapper.getFileName());
		}
		return true;
	}
	
	public void delete(Long code) {
		mapperRepository.delete(code);
	}

}
