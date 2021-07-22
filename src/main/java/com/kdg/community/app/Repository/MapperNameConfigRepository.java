package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MapperNameConfig;

public interface MapperNameConfigRepository extends CrudRepository<MapperNameConfig, Long>{
	
	@Query(value = "SELECT m FROM MapperNameConfig m WHERE m.mapper.code = :code")
	public List<MapperNameConfig> getNameConfigList(@Param("code") Long mapperCode);
	
	@Query(value = "SELECT m FROM MapperNameConfig m JOIN FETCH m.mapper WHERE m.code = :code")
	public MapperNameConfig getView(@Param("code") Long code);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM MapperNameConfig WHERE code = :code")
	public void delete(@Param("code") Long code);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM MapperNameConfig WHERE mapperCode = :mapperCode")
	public void deleteByParent(@Param("mapperCode") Long mapperCode);
}
