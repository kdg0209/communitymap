package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.Mapping;

public interface MappingRepository extends CrudRepository<Mapping, Long>{

	@Query(value = "SELECT m FROM Mapping m JOIN FETCH m.mapper WHERE m.mapper.code = :mapperCode")
	List<Mapping> findByMapperCodeOrderByWriteDateDesc(@Param("mapperCode") Long mapperCode);
	
	@Query(value = "SELECT m FROM Mapping m JOIN FETCH m.mapper WHERE m.code = :code AND m.mapper.code = :mapperCode")
	public Mapping view(@Param("code") Long code, @Param("mapperCode") Long mapperCode);

	@Modifying
	@Transactional
	@Query(value = "DELETE FROM Mapping WHERE code = :code")
	public void delete(@Param("code") Long code);
}
