package com.kdg.community.db.config;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@ComponentScan(basePackages = "com.kdg.community")
@EnableTransactionManagement
@EnableJpaRepositories(basePackages = "com.kdg.community.app.Repository")
public class DatabaseConfiguration {

	@Bean
	public HibernateJpaVendorAdapter vendorAdapter() {
		HibernateJpaVendorAdapter adapter = new HibernateJpaVendorAdapter();
		
		return adapter;
	}
	
	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
		dataSource.setUrl("jdbc:mysql://localhost:3306/communitymap");
		dataSource.setUsername("root");
		dataSource.setPassword("dkdldb2260");
		
		return dataSource;
	}
	
	@Bean
	public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
		LocalContainerEntityManagerFactoryBean factoryBean = new LocalContainerEntityManagerFactoryBean();
		factoryBean.setJpaVendorAdapter(vendorAdapter());
		factoryBean.setDataSource(dataSource());
		
		Map<String, Object> properies = new HashMap<String, Object>();
		properies.put("hibernate.dialect", "org.hibernate.dialect.H2Dialect");
		properies.put("hibernate.show_sql", "true");
		properies.put("hibernate.format_sql", "true");
		
		factoryBean.setJpaPropertyMap(properies);
		return factoryBean;
	}
	
	@Bean
	public JpaTransactionManager transactionManager(EntityManagerFactory factory) {
		JpaTransactionManager manager = new JpaTransactionManager();
		manager.setEntityManagerFactory(factory);
		
		return manager;
	}
}
