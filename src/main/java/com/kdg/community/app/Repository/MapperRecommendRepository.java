package com.kdg.community.app.Repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.MapperRecommend;

public interface MapperRecommendRepository extends CrudRepository<MapperRecommend, Long>{

	@Query(value = "SELECT * FROM mapper_recommend WHERE memberCode= :memberCode", nativeQuery = true)
	MapperRecommend findByMember(@Param("memberCode") Long memberCode);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM MapperRecommend WHERE memberCode = :memberCode")
	public void delete(@Param("memberCode") Long memberCode);
}
