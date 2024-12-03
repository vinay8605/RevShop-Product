package com.example.pro.service;

import com.demo.entity.Buyer;
import com.example.pro.entity.Product;
import com.example.pro.entity.Wishlist;
import com.example.pro.repository.WishlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class WishlistService {

    @Autowired
    private WishlistRepository wishlistRepository;

    /**
     * Adds a product to the buyer's wishlist if it does not already exist.
     * 
     * @param buyerId   the ID of the buyer adding the product
     * @param productId the ID of the product to be added
     */
    public void addToWishlist(Long buyerId, int productId) {
        try {
            // Check if the product is already in the buyer's wishlist to prevent duplicates
            if (!wishlistRepository.existsByBuyerIdAndProductId(buyerId, productId)) {
                Wishlist wishlist = new Wishlist();
                Buyer buyer = new Buyer();
                buyer.setId(buyerId);  // set buyer ID

                Product product = new Product();
                product.setId(productId);  // set product ID
                wishlist.setBuyer(buyer);  // set the buyer in the wishlist
                wishlist.setProduct(product);  // set the product in the wishlist
                wishlistRepository.save(wishlist);
                System.out.println("Product added to wishlist for Buyer ID: " + buyerId + ", Product ID: " + productId);
            } else {
                System.out.println("Product already exists in the wishlist for Buyer ID: " + buyerId + ", Product ID: " + productId);
            }
        } catch (Exception e) {
            System.err.println("Error adding product to wishlist: " + e.getMessage());
            // Consider throwing a custom exception or handle it according to your application's needs
        }
    }

    /**
     * Retrieves all wishlist items for a specific buyer.
     * 
     * @param buyerId the ID of the buyer
     * @return a list of wishlist items belonging to the buyer
     */
    public List<Wishlist> getWishlistForBuyer(Long buyerId) {
        try {
            List<Wishlist> wishlistItems = wishlistRepository.findByBuyerId(buyerId);
            System.out.println("Retrieved " + wishlistItems.size() + " items for Buyer ID: " + buyerId);
            return wishlistItems;
        } catch (Exception e) {
            System.err.println("Error retrieving wishlist items for Buyer ID: " + buyerId + ". " + e.getMessage());
            return List.of();  // Return an empty list in case of error
        }
    }
}
