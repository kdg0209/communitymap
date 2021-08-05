package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MappingHasNames;

public interface MappingHasNamesRepository  extends CrudRepository<MappingHasNames, Long>{
	
	@Query(value = "SELECT m FROM MappingHasNames m WHERE m.mapping.code = :code")
	public List<MappingHasNames> getMappingHasNamesList(@Param("code") Long mappingCode);
	
	@Query(value = "SELECT m FROM MappingHasNames m JOIN FETCH m.mapping WHERE m.code = :code")
	public MappingHasNames getView(@Param("code") Long code);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM MappingHasNames WHERE mapperNameCode = :mapperNameCode", nativeQuery = true)
	public int deleteByMapperNameConfig(@Param("mapperNameCode") Long mapperNameCode);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM MappingHasNames m WHERE m.mapping.code = :mappingCode")
	public void deleteByParent(@Param("mappingCode") Long mappingCode);

}
