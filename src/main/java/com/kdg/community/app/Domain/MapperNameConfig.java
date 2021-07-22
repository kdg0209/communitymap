package com.kdg.community.app.Domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(exclude = "mappingHasNamesList")
@Entity
@Table(name = "mappernameconfig")
public class MapperNameConfig {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;
	
	private String name;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "mapperCode")
	private Mapper mapper;
	
	public void setMapper(Mapper mapper) {
		this.mapper = mapper;
		
		if(mapper != null) {
			mapper.getMapperNameConfigList().add(this);
		}
	}
	
	@OneToMany(mappedBy = "mapperNameConfig", fetch = FetchType.LAZY)
	private List<MappingHasNames> mappingHasNamesList = new ArrayList<MappingHasNames>();
}
