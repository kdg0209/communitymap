package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.Mapper;

public interface MapperRepository extends CrudRepository<Mapper, Long>{

	public List<Mapper> findByMemberCodeOrderByWriteDateDesc(Long memberCode);
	
	@Query(value = "SELECT * FROM Mapper WHERE code = :code AND memberCode = :memberCode", nativeQuery = true)
	public Mapper view(@Param("code") Long code, @Param("memberCode") Long memberCode);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM Mapper WHERE code = :code")
	public void delete(@Param("code") Long code);
}
