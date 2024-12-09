<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pro.entity.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
	<style>
		:root {
		    --primary-color: #ff3f6c;
		    --secondary-color: #f5f5f5;
		    --text-color: #282c3f;
		    --border-color: #e0e0e0;
		    --accent-color: #4a4a4a;
		    --hover-color: #ff1744;
		}

		* {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		}

		body {
		    font-family: 'Roboto', Arial, sans-serif;
		    background-color: var(--secondary-color);
		    color: var(--text-color);
		    line-height: 1.6;
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    padding: 40px 20px;
		}

		h2 {
		    text-align: center;
		    color: var(--primary-color);
		    margin-bottom: 30px;
		    font-size: 24px;
		    font-weight: 700;
		    position: relative;
		    width: 100%;
		}

		h2::before,
		h2::after {
		    content: '';
		    position: absolute;
		    top: 50%;
		    width: 30px;
		    height: 2px;
		    background-color: var(--primary-color);
		    transform: translateY(-50%);
		}

		h2::before {
		    left: calc(50% - 100px);
		}

		h2::after {
		    right: calc(50% - 100px);
		}

		form {
		    background-color: white;
		    max-width: 500px;
		    width: 100%;
		    padding: 30px;
		    border-radius: 8px;
		    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
		    border: 1px solid var(--border-color);
		    position: relative;
		}

		form::before {
		    content: '✦';
		    position: absolute;
		    top: -15px;
		    left: 50%;
		    transform: translateX(-50%);
		    background-color: white;
		    color: var(--primary-color);
		    padding: 0 10px;
		    font-size: 20px;
		}

		label {
		    display: block;
		    margin-bottom: 8px;
		    font-weight: 500;
		    color: var(--accent-color);
		    position: relative;
		    padding-left: 15px;
		}

		label::before {
		    content: '•';
		    position: absolute;
		    left: 0;
		    color: var(--primary-color);
		    font-weight: bold;
		}

		input[type="text"], 
		input[type="number"], 
		input[type="file"], 
		textarea, 
		select {
		    width: 100%;
		    padding: 10px 15px;
		    margin-bottom: 15px;
		    border: 1px solid var(--border-color);
		    border-radius: 4px;
		    font-size: 14px;
		    transition: all 0.3s ease;
		}

		input[type="text"]:focus, 
		input[type="number"]:focus, 
		textarea:focus, 
		select:focus {
		    outline: none;
		    border-color: var(--primary-color);
		    box-shadow: 0 0 0 2px rgba(255, 63, 108, 0.1);
		}

		select {
		    appearance: none;
		    background-image: url('data:image/svg+xml;utf8,<svg fill="%23494d5f" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
		    background-repeat: no-repeat;
		    background-position: right 10px center;
		    padding-right: 35px;
		}

		input[type="submit"] {
		    width: 100%;
		    padding: 12px;
		    background-color: var(--primary-color);
		    color: white;
		    border: none;
		    border-radius: 4px;
		    font-size: 16px;
		    font-weight: 700;
		    cursor: pointer;
		    transition: all 0.3s ease;
		    position: relative;
		    overflow: hidden;
		}

		input[type="submit"]:hover {
		    background-color: var(--hover-color);
		}

		input[type="submit"]::before {
		    content: '➤';
		    position: absolute;
		    right: 20px;
		    opacity: 0;
		    transition: opacity 0.3s ease;
		}

		input[type="submit"]:hover::before {
		    opacity: 1;
		}

		textarea {
		    resize: vertical;
		    min-height: 100px;
		}

		div[style="color: red;"] {
		    background-color: #ffebee;
		    color: #ff1744;
		    padding: 10px;
		    margin-top: 15px;
		    border-radius: 4px;
		    text-align: center;
		    border: 1px solid #ff1744;
		}

		@media (max-width: 600px) {
		    form {
		        padding: 20px;
		        margin: 0 10px;
		    }

		    h2::before,
		    h2::after {
		        width: 20px;
		    }
		}
	</style>

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
