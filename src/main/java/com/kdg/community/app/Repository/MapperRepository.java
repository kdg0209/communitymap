package com.kdg.community.app.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.Mapper;

public interface MapperRepository extends CrudRepository<Mapper, Long>{

	@Query(value = "SELECT m FROM Mapper m")
	Page<Mapper> mainMapperList(Pageable pageable);
	
	@Query(value = "SELECT m FROM Mapper m INNER JOIN m.member WHERE m.member.code = :memberCode")
	Page<Mapper> mapperList(@Param("memberCode") Long memberCode, Pageable pageable);
	
	@Query(value = "SELECT m FROM Mapper m JOIN FETCH m.member WHERE m.code = :code AND m.member.code = :memberCode")
	public Mapper view(@Param("code") Long code, @Param("memberCode") Long memberCode);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM Mapper WHERE code = :code")
	public void delete(@Param("code") Long code);
}
