package com.example.pro.repository;
import com.example.pro.entity.SubCategory;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubCategoryRepository extends CrudRepository<SubCategory, Long> {
    // You can keep additional query methods if necessary
	  List<SubCategory> findAll();
}
