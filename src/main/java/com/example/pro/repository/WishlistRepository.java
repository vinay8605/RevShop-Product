package com.example.pro.repository;

import com.example.pro.entity.Wishlist;


import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
    
    // Find all wishlist items by buyer ID
    List<Wishlist> findByBuyerId(Long buyerId);

   
    boolean existsByBuyerIdAndProductId(Long buyerId, int productId);
}
