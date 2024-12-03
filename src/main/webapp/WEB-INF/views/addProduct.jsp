<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pro.entity.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
</head>
<body>
    <h2>Add New Product</h2>
    <form action="/seller/dashboard/products/add" method="post" enctype="multipart/form-data">
        <!-- Product Name -->
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name" required><br>

        <!-- Description -->
        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea><br>

        <!-- Color -->
        <label for="color">Color:</label>
        <input type="text" id="color" name="color"><br>

        <!-- Size -->
        <label for="size">Size:</label>
        <input type="text" id="size" name="size"><br>

        <!-- Price -->
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" required><br>

        <!-- Quantity -->
        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" required><br>

        <!-- Discount -->
        <label for="discount">Discount:</label>
        <input type="number" id="discount" name="discount" step="0.01"><br>

        <!-- Category -->
        <label for="category">Category:</label>
        <select id="category" name="categoryId" required>
            <option value="">Select Category</option>
            <% 
                List<Category> categories = (List<Category>) request.getAttribute("categories");
                for (Category category : categories) {
            %>
                <option value="<%= category.getId() %>"><%= category.getName() %></option>
            <% } %>
        </select><br>

        <!-- Subcategory -->
        <label for="subcategory">Subcategory:</label>
        <select id="subcategory" name="subcategoryId" required>
            <option value="">Select Subcategory</option>
            <% 
                List<SubCategory> subCategories = (List<SubCategory>) request.getAttribute("subCategories");
                for (SubCategory subCategory : subCategories) {
            %>
                <option value="<%= subCategory.getSubid() %>"><%= subCategory.getName() %></option>
            <% } %>
        </select><br>

        <!-- Product Image -->
        <label for="imageFile">Product Image:</label>
        <input type="file" id="imageFile" name="imageFile" accept="image/*"><br><br>

        <!-- Submit Button -->
        <input type="submit" value="Add Product">
    </form>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <div style="color: red;">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>
</body>
</html>
