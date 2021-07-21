package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MappingFiles;

public interface MappingFilesRepository extends CrudRepository<MappingFiles, Long>{

	@Query(value = "SELECT * FROM mappingfiles WHERE code = :code", nativeQuery = true)
	public MappingFiles getView(@Param("code") Long code);

	@Query(value = "SELECT * FROM mappingfiles WHERE timestamp = :timestamp", nativeQuery = true)
	public List<MappingFiles> getMappingFilesList(@Param("timestamp") Long timestamp);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM mappingfiles WHERE code = :code", nativeQuery = true)
	public void delete(@Param("code") Long code);
}
