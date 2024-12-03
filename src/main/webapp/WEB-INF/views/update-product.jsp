<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.pro.entity.Product"%>
<%@ page import="com.example.pro.entity.Category"%>
<%@ page import="com.example.pro.entity.SubCategory"%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
</head>
<body>
    <h1>Seller Dashboard - Update Product</h1>

    <nav>
        <ul>
            <li><a href="/seller/dashboard/products/add">Add Product</a></li>
            <li><a href="/seller/dashboard">View My Products</a></li>
        </ul>
    </nav>
    
    <h2>Update Product</h2>
    
    <form action="/seller/dashboard/products/update" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= ((Product) request.getAttribute("productToUpdate")).getId() %>">

        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name" value="<%= ((Product) request.getAttribute("productToUpdate")).getName() %>" required><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required><%= ((Product) request.getAttribute("productToUpdate")).getDescription() %></textarea><br>

        <label for="color">Color:</label>
        <input type="text" id="color" name="color" value="<%= ((Product) request.getAttribute("productToUpdate")).getColor() %>"><br>

        <label for="size">Size:</label>
        <input type="text" id="size" name="size" value="<%= ((Product) request.getAttribute("productToUpdate")).getSize() %>"><br>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" value="<%= ((Product) request.getAttribute("productToUpdate")).getPrice() %>" required><br>

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" value="<%= ((Product) request.getAttribute("productToUpdate")).getQuantity() %>" required><br>

        <label for="discount">Discount:</label>
        <input type="number" id="discount" name="discount" step="0.01" value="<%= ((Product) request.getAttribute("productToUpdate")).getDiscount() %>"><br>

        <!-- Category Dropdown -->
        <!-- Category Dropdown -->
<label for="category">Category:</label>
<select id="category" name="categoryId" required>
    <option value="">Select Category</option>
    <%
        List<Category> categories = (List<Category>) request.getAttribute("categories");
        long currentCategoryId = ((Product) request.getAttribute("productToUpdate")).getCategory().getId();
        for (Category category : categories) {
            boolean isSelected = category.getId() == currentCategoryId; // Use == instead of .equals()
    %>
        <option value="<%= category.getId() %>" <%= isSelected ? "selected" : "" %>><%= category.getName() %></option>
    <%
        }
    %>
</select><br>


        <!-- Subcategory Dropdown -->
       <label for="subcategory">Subcategory:</label>
<select id="subcategory" name="subcategoryId" required>
    <option value="">Select Subcategory</option>
    <%
        List<SubCategory> subCategories = (List<SubCategory>) request.getAttribute("subCategories");
        long currentSubCategoryId = ((Product) request.getAttribute("productToUpdate")).getSubCategory().getSubid(); // Use primitive long if Subid is long
        for (SubCategory subCategory : subCategories) {
            boolean isSelected = subCategory.getSubid() == currentSubCategoryId; // Use == for primitive comparison
    %>
        <option value="<%= subCategory.getSubid() %>" <%= isSelected ? "selected" : "" %>><%= subCategory.getName() %></option>
    <%
        }
    %>
</select><br>


        <label for="imageFile">Product Image:</label>
        <input type="file" id="imageFile" name="imageFile" accept="image/*"><br><br>

        <input type="submit" value="Update Product">
    </form>
</body>
</html>
