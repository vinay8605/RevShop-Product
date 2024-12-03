package com.example.pro;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = "com.example.pro")
@ComponentScan(basePackages = {"com.example.pro", "com.seller"})
@EntityScan(basePackages = {"com.example.pro.entity","com.demo.entity"})
@EnableJpaRepositories(basePackages = "com.example.pro.repository")  
public class ProductApplication {

    public static void main(String[] args) {
        SpringApplication.run(ProductApplication.class, args);
    }
}
