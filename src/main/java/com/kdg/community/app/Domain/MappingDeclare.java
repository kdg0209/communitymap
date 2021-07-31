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
@Table(name = "mappingdeclare")
public class MappingDeclare {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	private String memo;
	private String writeDate;
	private String writeIp; 
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "mappingCode")
	private Mapping mapping;
	
	public void setMapping(Mapping mapping) {
		this.mapping = mapping;
		
		if(mapping != null) {
			mapping.getMappingdeclareList().add(this);
		}
	}
	
}
