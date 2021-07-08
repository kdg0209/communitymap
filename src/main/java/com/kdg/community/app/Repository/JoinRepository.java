package com.kdg.community.app.Repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.kdg.community.app.Domain.Member;


public interface JoinRepository extends CrudRepository<Member, Long>{

	@Query(value = "SELECT COUNT(*) FROM member WHERE id = :value", nativeQuery = true)
	int idValidation(@Param("value") String value);
	
	@Query(value = "SELECT COUNT(*) FROM member WHERE nickname = :value", nativeQuery = true)
	int nicknameValidation(@Param("value") String value);
	
	@Query(value = "SELECT COUNT(*) FROM member WHERE phone = :value", nativeQuery = true)
	int phoneverification(@Param("value") String value);
	
	@Query(value = "SELECT COUNT(*) FROM member WHERE email = :value", nativeQuery = true)
	int emailverification(@Param("value") String value);
}
