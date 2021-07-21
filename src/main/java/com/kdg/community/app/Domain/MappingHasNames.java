package com.kdg.community.app.Domain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.transaction.annotation.Transactional;

import lombok.Data;

@Data
@Entity
@Table(name = "mappinghasnames")
public class MappingHasNames {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	private String fieldValues;
	
	@ManyToOne
	@JoinColumn(name = "mappingCode")
	private Mapping mapping;
	
	public void setMapping(Mapping mapping) {
		this.mapping = mapping;
		
		if(mapping != null) {
			mapping.getMappingHasNamesList().add(this);
		}
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "mapperNameCode")
	private MapperNameConfig mapperNameConfig;
	
	public void setMapperNameConfig(MapperNameConfig mapperNameConfig) {
		this.mapperNameConfig = mapperNameConfig;
		
		if(mapperNameConfig != null) {
			mapperNameConfig.getMappingHasNamesList().add(this);
		}
	}
}