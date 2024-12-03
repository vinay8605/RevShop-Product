package com.example.pro.entity;

import org.springframework.web.multipart.MultipartFile;

import com.seller.entity.Seller;
import jakarta.persistence.*;

@Entity
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private String description;
    private String color;
    private String size;
    private double price;
    private int quantity;
    
    @Lob
    private byte[] image; // Changed to byte[] for storing BLOB data
    
    @Transient
    private MultipartFile imageFile;
    
    private double discount_price; // Added new field for discount

    @ManyToOne
    private Category category;

    @ManyToOne
    @JoinColumn(name = "subcategory_id")
    private SubCategory subCategory;

    @ManyToOne
    @JoinColumn(name = "seller_id")  // Foreign key column in the Product table
    private Seller seller;

    // Getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public double getDiscount() {
        return discount_price;
    }

    public void setDiscount(double discount_price) {
        this.discount_price = discount_price;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public SubCategory getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(SubCategory subCategory) {
        this.subCategory = subCategory;
    }

    public Seller getSeller() {
        return seller;
    }

    public void setSeller(Seller seller) {
        this.seller = seller;
    }

    public MultipartFile getImageFile() {
		return imageFile;
	}

	public void setImageFile(MultipartFile imageFile) {
		this.imageFile = imageFile;
	}

	// Overridden toString() method to return meaningful product information
    @Override
    public String toString() {
        return "Product{" +
               "id=" + id +
               ", name='" + name + '\'' +
               ", description='" + description + '\'' +
               ", color='" + color + '\'' +
               ", size='" + size + '\'' +
               ", price=" + price +
               ", quantity=" + quantity +
               ", discount_price=" + discount_price + // Added discount in toString
               ", category=" + (category != null ? category.getName() : "N/A") +
               ", subCategory=" + (subCategory != null ? subCategory.getName() : "N/A") +
               ", seller=" + (seller != null ? seller.getName() : "N/A") +
               '}';
    }
}
