package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.kdg.community.app.Domain.MapperNameConfig;

public interface MapperNameConfigRepository extends CrudRepository<MapperNameConfig, Long>{

	@Query(value = "SELECT * FROM MapperNameConfig WHERE mapperCode = :mapperCode", nativeQuery = true)
	public List<MapperNameConfig> getNameConfigList(@Param("mapperCode") Long mapperCode);
	
	public MapperNameConfig findByCode(Long code);
}
