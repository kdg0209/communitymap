package com.kdg.community.app.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MapperRecommend;
import com.kdg.community.app.Repository.MapperRecommendRepository;

@Service
@Transactional
public class MapperRecommendService {

	private final MapperRecommendRepository mapperRecommendRepository;

	public MapperRecommendService(MapperRecommendRepository mapperRecommendRepository) {
		this.mapperRecommendRepository = mapperRecommendRepository;
	}
	
	public MapperRecommend findByMember(Long memberCode) {
		return mapperRecommendRepository.findByMember(memberCode);
	}
	
	public MapperRecommend insert(MapperRecommend mapperRecommend) {
		return mapperRecommendRepository.save(mapperRecommend);
	}
	
	public void deleteByMapper (Long mapperCode) {
		mapperRecommendRepository.deleteByMapper(mapperCode);
	}
	
	
	public void deleteByMember (Long memberCode) {
		mapperRecommendRepository.deleteByMember(memberCode);
	}
}
