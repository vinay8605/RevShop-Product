package com.example.pro.service;



import com.example.pro.entity.SubCategory;
import com.example.pro.repository.SubCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SubCategoryService {

    @Autowired
    private SubCategoryRepository subCategoryRepository;

    // Find all subcategories
    public List<SubCategory> getAllSubCategories() {
        return subCategoryRepository.findAll();
    }

    // Find a subcategory by its ID
    public Optional<SubCategory> getSubCategoryById(Long id) {
        return subCategoryRepository.findById(id);
    }
}
