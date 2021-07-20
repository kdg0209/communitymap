package com.kdg.community.app.Domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "mappinghasnames")
public class MappingHasNames {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	private Long mapperNameCode;
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
}