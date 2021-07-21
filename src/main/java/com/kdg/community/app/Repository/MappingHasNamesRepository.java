package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.kdg.community.app.Domain.MappingHasNames;

public interface MappingHasNamesRepository  extends CrudRepository<MappingHasNames, Long>{
	
	@Query(value = "SELECT m FROM MappingHasNames m WHERE m.mapping.code = :code")
	public List<MappingHasNames> getMappingHasNamesList(@Param("code") Long mappingCode);
	
	@Query(value = "SELECT m FROM MappingHasNames m JOIN FETCH m.mapping WHERE m.code = :code")
	public MappingHasNames view(@Param("code") Long code);

}
