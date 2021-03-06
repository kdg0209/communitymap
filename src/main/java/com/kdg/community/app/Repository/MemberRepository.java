package com.kdg.community.app.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.kdg.community.app.Domain.Member;

public interface MemberRepository extends CrudRepository<Member, Long>{

	@Query(value = "SELECT m FROM Member m")
	Page<Member> memberList(Pageable pageable);
	
	@Query(value = " SELECT *, " +
				   " (SELECT COUNT(*) FROM mapper WHERE mapper.memberCode = member.code) AS mapperCount" + 
				   " FROM member WHERE (SELECT COUNT(*) FROM mapper WHERE mapper.memberCode = member.code) > 0 ", nativeQuery = true)
	Page<Object[]> mapperCountOfmemberList(Pageable pageable);
	
	Member findByCode(Long code);
	
	@Query(value = "SELECT * FROM member WHERE id= :id", nativeQuery = true)
	Member findById(@Param("id") String id);
	
	Member findByIdAndPassword(String id, String password);
	
	@Modifying
	@Transactional
	@Query(value = "DELETE FROM Member WHERE code = :code")
	public int delete(@Param("code") Long code);
}
