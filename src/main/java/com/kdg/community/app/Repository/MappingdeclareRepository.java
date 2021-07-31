package com.kdg.community.app.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.kdg.community.app.Domain.MappingDeclare;

public interface MappingdeclareRepository extends CrudRepository<MappingDeclare, Long>{

	@Query(value = "SELECT m FROM MappingDeclare m INNER JOIN m.mapping WHERE m.mapping.code = :mappingCode")
	Page<MappingDeclare> declareList(@Param("mappingCode") Long mappingCode, Pageable pageable);
}
