package com.kdg.community.app.Domain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "mapper_recommend")
public class MapperRecommend {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "memberCode")
	private Member member;
	
	public void setMember(Member member) {
		this.member = member;
	
		if(member != null) {
			member.getMapperRecommendList().add(this);
		}
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mapperCode")
	private Mapper mapper;
	
	public void setMapper(Mapper mapper) {
		this.mapper = mapper;
		
		if(mapper != null) {
			mapper.getMapperRecommendList().add(this);
		}
	}
}
