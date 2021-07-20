package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MapperCategoryConfig;

public interface MapperCategoryConfigRepository extends CrudRepository<MapperCategoryConfig, Long>{

	@Query(value = "SELECT m FROM MapperCategoryConfig m WHERE m.mapper.code = :mapperCode")
	public List<MapperCategoryConfig> getCategoryConfigList(@Param("mapperCode") Long mapperCode);
	
	@Query(value = "SELECT m FROM MapperCategoryConfig m JOIN FETCH m.mapper WHERE m.code = :code")
	public MapperCategoryConfig getView(@Param("code") Long code);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM MapperCategoryConfig WHERE mapperCode = :mapperCode")
	public void deleteByParent(@Param("mapperCode") Long mapperCode);
}
