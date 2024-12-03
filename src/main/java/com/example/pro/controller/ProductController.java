package com.example.pro.controller;

import com.example.pro.entity.*;

import com.example.pro.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/products")
public class ProductController {
	 @Autowired
	    private WishlistService wishlistService;

    @Autowired
    private ProductService productService;

    // Display products (non-RESTful for front-end)
    @GetMapping
    public String getAllProducts(@RequestParam(required = false) String category,
                                  @RequestParam(required = false) String subcategory,
                                  @RequestParam(required = false) String search,
                                  Model model) {
        List<Product> products = productService.getProducts(category, subcategory, search);
        model.addAttribute("products", products);
        model.addAttribute("categories", productService.getCategories());
        model.addAttribute("subcategories", productService.getSubCategories());

        return "products";  // Return the view name (products.html)
    }

    // View product details
    @GetMapping("/product/{id}")
    public String getProductDetails(@PathVariable("id") int productId, Model model) {
        Product product = productService.getProductDetails(productId);
        model.addAttribute("product", product);
        return "details";  // Return the view name (details.html)
    }

    // RESTful API to get product details (for Cart Service)
    @GetMapping("/api/product/{id}")
    @ResponseBody
    public Product getProductDetailsApi(@PathVariable("id") int productId) {
        return productService.getProductDetails(productId);  // Return product data in JSON format
    }
    
    @PostMapping("/{id}/add-to-wishlist")
    public String addToWishlist(@PathVariable("id") int productId, 
                                @CookieValue(value = "buyerId", required = false) String buyerId, 
                                Model model) {
        System.out.println("Buyer ID from cookie: " + buyerId);  // Log the buyerId value

        // Check if buyerId is present in the cookie
        if (buyerId == null || buyerId.isEmpty()) {
            model.addAttribute("errorMessage", "Please log in to add items to the wishlist.");
            return "redirect:/login"; // Redirect to login page if buyerId is not found
        }

        try {
            Long buyerLongId = Long.parseLong(buyerId);  // Parse buyerId to Long
            System.out.println("Buyer ID parsed: " + buyerLongId);  // Log the parsed ID
            
            // Add the product to the wishlist for the buyer
            wishlistService.addToWishlist(buyerLongId, productId);

            // Now, retrieve the updated wishlist products for this buyer
            List<Wishlist> wishlistProducts = wishlistService.getWishlistForBuyer(buyerLongId);
            System.out.println(wishlistProducts);

            // Add the updated wishlist products to the model
            model.addAttribute("wishlistProducts", wishlistProducts);

            return "wishlist";  // Return to the wishlist page with the updated wishlist
        } catch (NumberFormatException e) {
            model.addAttribute("errorMessage", "Invalid buyer ID format.");
            return "redirect:/login"; // Redirect to login if there's a format issue with buyerId
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Failed to add product to wishlist: " + e.getMessage());
            return "redirect:/product/" + productId; // Redirect back to product page on error
        }
    }
 

}
