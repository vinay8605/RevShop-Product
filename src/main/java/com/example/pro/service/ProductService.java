package com.example.pro.service;

import com.example.pro.entity.*;

import com.example.pro.repository.*;
import com.seller.entity.Seller;
import com.seller.service.SellerService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private SellerService sellerService;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private SubCategoryRepository subCategoryRepository;

    @Autowired
    private RestTemplate restTemplate;  // Inject RestTemplate


    // Seller service URL (update to match the actual Seller service URL)
    private final String SELLER_SERVICE_URL = "http://localhost:8081/api/sellers";  // Change this as needed

    // Get all products or filter by category, subcategory, and search term
    public List<Product> getProducts(String category, String subcategory, String search) {
        if (category != null && subcategory != null) {
            return productRepository.findByCategory_NameAndSubCategory_Name(category, subcategory);
        } else if (category != null) {
            return productRepository.findByCategory_Name(category);
        } else if (subcategory != null) {
            return productRepository.findBySubCategory_Name(subcategory);
        } else if (search != null) {
            return productRepository.findByNameContainingIgnoreCaseOrDescriptionContainingIgnoreCase(search, search);
        } else {
            return productRepository.findAll();
        }
    }

    // Get a specific product by ID and fetch associated Seller data
    public Product getProductDetails(int id) {
        Product product = productRepository.findById(id).orElse(null);
        if (product != null && product.getSeller() == null) { // If no seller is set
            Seller seller = getSellerById(product.getSeller().getId());
            product.setSeller(seller);  // Set Seller in Product
        }
        return product;
    }

    // Fetch Seller data from Seller Service using RestTemplate
    private Seller getSellerById(int sellerId) {
        String url = SELLER_SERVICE_URL + "/" + sellerId;
        return restTemplate.getForObject(url, Seller.class);  // Fetch Seller from Seller Service
    }

    // Get all categories
    public List<Category> getCategories() {
        return categoryRepository.findAll();
    }

    // Get all subcategories
    public List<SubCategory> getSubCategories() {
        return subCategoryRepository.findAll();
    }

    public Product addProduct(Product product) {
        return productRepository.save(product);
    }

    public Product updateProduct(Product product) {
        return productRepository.save(product);
    }

    public void deleteProduct(int productId) {
        productRepository.deleteById(productId);
    }

    public Optional<Product> getProductById(int productId) {
        return productRepository.findById(productId);
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public List<Product> findProductsBySellerId(int sellerId) {
        // Fetch the Seller entity based on the sellerId
        Seller seller = sellerService.getSellerById(sellerId);
        
        // Return products for the seller
        if (seller != null) {
            return productRepository.findBySeller(seller);
        }
        return List.of();  // Return an empty list if seller not found
    }

    // Placeholder methods for cart and wishlist (you can implement actual functionality)
   }
