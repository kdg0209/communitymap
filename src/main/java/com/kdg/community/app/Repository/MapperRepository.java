package com.kdg.community.app.Repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.kdg.community.app.Domain.Mapper;

public interface MapperRepository extends CrudRepository<Mapper, Long>{

	public List<Mapper> findByMemberCode(Long memberCode);
}
