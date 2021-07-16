package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.kdg.community.app.Domain.MapperNameConfig;

public interface MapperNameConfigRepository extends CrudRepository<MapperNameConfig, Long>{
	
	@Query(value = "SELECT m FROM MapperNameConfig m JOIN FETCH m.mapper  WHERE m.mapper.code = :code")
	public List<MapperNameConfig> getNameConfigList(@Param("code") Long mapperCode);
	
	@Query(value = "SELECT m FROM MapperNameConfig m JOIN FETCH m.mapper WHERE m.code = :code")
	public MapperNameConfig getView(@Param("code") Long code);
}
