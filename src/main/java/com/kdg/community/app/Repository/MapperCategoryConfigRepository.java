package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.kdg.community.app.Domain.MapperCategoryConfig;

public interface MapperCategoryConfigRepository extends CrudRepository<MapperCategoryConfig, Long>{

	@Query(value = "SELECT m FROM MapperCategoryConfig m JOIN FETCH m.mapper WHERE m.mapper.code = :mapperCode")
	public List<MapperCategoryConfig> getCategoryConfigList(@Param("mapperCode") Long mapperCode);
}
