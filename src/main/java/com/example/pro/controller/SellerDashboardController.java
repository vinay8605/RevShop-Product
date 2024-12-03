package com.example.pro.controller;

import com.example.pro.entity.Category;

import com.example.pro.entity.Product;
import com.example.pro.entity.SubCategory;
import com.example.pro.service.CategoryService;
import com.example.pro.service.ProductService;
import com.example.pro.service.SubCategoryService;
import com.seller.entity.Seller;
import com.seller.service.SellerService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/seller/dashboard")
public class SellerDashboardController {

    @Autowired
    private ProductService productService;
    
    @Autowired
    private SellerService sellerService;
    
    @Autowired
    private CategoryService categoryService;
    

    
    @Autowired
    private SubCategoryService subCategoryService;
    // Display products added by seller based on sellerId retrieved from cookie
    @GetMapping("/products")
    public String viewSellerProducts(Model model, HttpServletRequest request) {
        int sellerId = getSellerIdFromCookie(request);
        if (sellerId != -1) {
            List<Product> products = productService.findProductsBySellerId(sellerId);
            model.addAttribute("products", products);
        }
        return "sellerProducts";
    }
    
 // Show seller dashboard with products list
    @GetMapping
    public String showSellerDashboard(Model model, HttpServletRequest request) {
        int sellerId = getSellerIdFromCookie(request); // Retrieve seller ID from cookie

        if (sellerId != -1) {
            List<Product> products = productService.findProductsBySellerId(sellerId); // Get products for this seller
            // Store products list in session
            HttpSession session = request.getSession();
            session.setAttribute("products", products); // Store the products in the session
        }
        return "seller-dashboard"; // Render the seller dashboard view
    }




    @GetMapping("/products/add")
    public String showAddProductForm(Model model) {
        // Fetch all categories
        List<Category> categories = categoryService.getAllCategories();
        
        // Fetch all subcategories (or based on the selected category)
        List<SubCategory> subCategories = subCategoryService.getAllSubCategories();
        
        // Add categories and subcategories to the model
        model.addAttribute("categories", categories);
        model.addAttribute("subCategories", subCategories);
        
        // Return to the add product form view
        return "addProduct";
    }

    @PostMapping("/products/add")
    public String addProduct(@ModelAttribute("product") Product product,
                             @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                             @RequestParam(value = "categoryId", required = true) Long categoryId,  // Changed to categoryId
                             @RequestParam(value = "subcategoryId", required = true) Long subCategoryId,
                             HttpServletRequest request,
                             Model model) {

        // Retrieve sellerId from cookie
        int sellerId = getSellerIdFromCookie(request);

        // If sellerId is -1, then the seller is not logged in or cookie is not found
        if (sellerId != -1) {
            try {
                // Fetch Seller entity by sellerId
                Seller seller = sellerService.getSellerById(sellerId);
                product.setSeller(seller);  // Set seller object instead of sellerId

                // Fetch Category and SubCategory entities using their respective services
                Category category = categoryService.getCategoryById(categoryId).orElse(null); // Fetch Category
                SubCategory subCategory = subCategoryService.getSubCategoryById(subCategoryId).orElse(null); // Fetch SubCategory

                if (category != null) {
                    product.setCategory(category);  // Set category for the product
                } else {
                    model.addAttribute("errorMessage", "Invalid category selected.");
                    return "addProduct";  // Return to the add product form if category is invalid
                }

                if (subCategory != null) {
                    product.setSubCategory(subCategory);  // Set the subCategory for the product
                } else {
                    model.addAttribute("errorMessage", "Invalid subcategory selected.");
                    return "addProduct";  // Return to the add product form if subcategory is invalid
                }

                // Handle image file upload
                if (imageFile != null && !imageFile.isEmpty()) {
                    product.setImage(imageFile.getBytes());  // Convert image to byte[] and set to the product
                }

                // Save product with associated seller, category, and subcategory
                productService.addProduct(product);
            } catch (IOException e) {
                model.addAttribute("errorMessage", "Error processing image file");
                return "addProduct";  // Return to the add product form if there's an error with the image
            } catch (Exception e) {
                model.addAttribute("errorMessage", "An error occurred during product addition: " + e.getMessage());
                return "addProduct";  // Return to the add product form if there's any other exception
            }
        } else {
            // If no sellerId is found in the cookie, redirect to login page
            model.addAttribute("errorMessage", "Seller not logged in.");
            return "redirect:http://localhost:8099/api/sellers/login";  // Redirect to login page if seller is not logged in
        }

        return "seller-dashboard";  // Redirect to the product listing page if product is added successfully
    }

    private int getSellerIdFromCookie(HttpServletRequest request) {
        // Retrieve the cookies from the request
        Cookie[] cookies = request.getCookies();
        
        // If no cookies exist, return -1 (indicating that seller is not logged in)
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("sellerId".equals(cookie.getName())) {
                    try {
                        return Integer.parseInt(cookie.getValue());  // Return sellerId from the cookie
                    } catch (NumberFormatException e) {
                        return -1;  // If parsing fails, return -1
                    }
                }
            }
        }
        return -1;  // If no "sellerId" cookie is found, return -1
    }


 // Show update product form
    @GetMapping("/products/edit/{productId}")
    public String showUpdateProductForm(@PathVariable int productId, Model model) {
        // Retrieve the product by ID
        Optional<Product> productOptional = productService.getProductById(productId);
        
        if (productOptional.isPresent()) {
            // Retrieve all categories and subcategories
            List<Category> categories = categoryService.getAllCategories();
            List<SubCategory> subCategories = subCategoryService.getAllSubCategories();

            // Add product, categories, and subcategories to the model
            model.addAttribute("productToUpdate", productOptional.get());
            model.addAttribute("categories", categories);
            model.addAttribute("subCategories", subCategories);

            return "update-product"; // Return the view for updating the product
        }

        // Redirect to dashboard if the product is not found
        return "redirect:/seller/dashboard";
    }


    // Handle update product
    @PostMapping("/products/update")
    public String updateProduct(@ModelAttribute("product") Product product,
                                 @RequestParam(value = "imageFile", required = false) MultipartFile imageFile, // Image upload
                                 @RequestParam(value = "categoryId", required = true) Long categoryId,  // Category validation
                                 @RequestParam(value = "subcategoryId", required = true) Long subCategoryId,
                                 HttpServletRequest request,
                                 Model model) {

        // Retrieve sellerId from cookie
        int sellerId = getSellerIdFromCookie(request);

        // If sellerId is -1, then the seller is not logged in or cookie is not found
        if (sellerId != -1) {
            try {
                // Fetch Seller entity by sellerId
                Seller seller = sellerService.getSellerById(sellerId);
                product.setSeller(seller);  // Set seller object instead of sellerId

                // Fetch Category and SubCategory entities using their respective services
                Category category = categoryService.getCategoryById(categoryId).orElse(null); // Fetch Category
                SubCategory subCategory = subCategoryService.getSubCategoryById(subCategoryId).orElse(null); // Fetch SubCategory

                if (category != null) {
                    product.setCategory(category);  // Set category for the product
                } else {
                    model.addAttribute("errorMessage", "Invalid category selected.");
                    return "updateProduct";  // Return to the update product form if category is invalid
                }

                if (subCategory != null) {
                    product.setSubCategory(subCategory);  // Set the subCategory for the product
                } else {
                    model.addAttribute("errorMessage", "Invalid subcategory selected.");
                    return "updateProduct";  // Return to the update product form if subcategory is invalid
                }

                // Handle image file upload if it is present
                if (imageFile != null && !imageFile.isEmpty()) {
                    product.setImage(imageFile.getBytes());  // Convert image to byte[] and set to the product
                }

                // Update the product with the new details
                productService.updateProduct(product);
            } catch (IOException e) {
                model.addAttribute("errorMessage", "Error processing image file");
                return "updateProduct";  // Return to the update product form if there's an error with the image
            } catch (Exception e) {
                model.addAttribute("errorMessage", "An error occurred during product update: " + e.getMessage());
                return "updateProduct";  // Return to the update product form if there's any other exception
            }
        } else {
            // If no sellerId is found in the cookie, redirect to login page
            model.addAttribute("errorMessage", "Seller not logged in.");
            return "login";  // Redirect to login page if seller is not logged in
        }

        return "redirect:http://localhost:8099/seller/dashboard";  // Redirect to the seller dashboard if product is updated successfully
    }

    // Handle delete product
    @GetMapping("/products/delete/{productId}")
    public String deleteProduct(@PathVariable int productId) {
        productService.deleteProduct(productId);
        return "redirect:http://localhost:8099/seller/dashboard";
    }

    
}
