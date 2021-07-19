package com.kdg.community.app.Domain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "mappinghasnames")
public class MappingHasNames {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	@OneToOne
	@MapsId
	@JoinColumn(name = "mapperNameCode")
	private MapperNameConfig mapperNameConfig;
	
	@ManyToOne
	@JoinColumn(name = "mappingCode")
	private Mapping mapping;
	
	public void setMapping(Mapping mapping) {
		this.mapping = mapping;
		
		if(mapping != null) {
			mapping.getMappingHasNamesList().add(this);
		}
	}
	
}
