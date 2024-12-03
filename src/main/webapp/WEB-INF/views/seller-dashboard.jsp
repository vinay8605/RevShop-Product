<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.pro.entity.Product"%>

<!DOCTYPE html>
<html>
<head>
    <title>Seller Dashboard</title>
</head>
<body>
    <h1>Welcome to Your Seller Dashboard</h1>
    
    <nav>
        <ul>
            <li><a href="/seller/dashboard/products/add">Add Product</a></li>
            <li><a href="/seller/dashboard">View My Products</a></li>
        </ul>
    </nav>
    
    <h2>Your Products</h2>
    
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Quantity</th>
             <th>image</th>
            <th>Actions</th>
        </tr>
        
        <%
            // Retrieve the products from session
            List<Product> products = (List<Product>) session.getAttribute("products");
            if (products != null) {
                for (Product product : products) {
        %>
            <tr>
                <td><%= product.getId() %></td>
                <td><%= product.getName() %></td>
                <td><%= product.getDescription() %></td>
                <td><%= product.getPrice() %></td>
                <td><%= product.getQuantity() %></td>
                <td><img src="<%= product.getImage() %>"></td>
                <td>
                    <a href="/seller/dashboard/products/edit/<%= product.getId() %>">Edit</a> |
                    <a href="/seller/dashboard/products/delete/<%= product.getId() %>" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                </td>
            </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
