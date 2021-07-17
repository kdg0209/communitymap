package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.kdg.community.app.Domain.Mapping;

public interface MappingRepository extends CrudRepository<Mapping, Long>{

	List<Mapping> findByMapperCodeOrderByWriteDateDesc(Long mapperCode);
}
