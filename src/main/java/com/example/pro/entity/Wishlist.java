package com.example.pro.entity;



import com.demo.entity.*;

import jakarta.persistence.*;


@Entity
public class Wishlist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Relationship with Buyer
    @ManyToOne
    @JoinColumn(name = "buyer_id", referencedColumnName = "id", nullable = false) // Assuming 'id' is the primary key of the buyers table
    private Buyer buyer;

    // Relationship with Product
    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "id", nullable = false) // Assuming 'id' is the primary key of the products table
    private Product product;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Buyer getBuyer() {
        return buyer;
    }

    public void setBuyer(Buyer buyer) {
        this.buyer = buyer;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
