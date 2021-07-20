package com.kdg.community.app.Repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.kdg.community.app.Domain.Member;

public interface MemberRepository extends CrudRepository<Member, Long>{

	Member findByCode(Long code);
	
	@Query(value = "SELECT * FROM member WHERE id= :id", nativeQuery = true)
	Member findById(@Param("id") String id);
	
	Member findByIdAndPassword(String id, String password);
}
