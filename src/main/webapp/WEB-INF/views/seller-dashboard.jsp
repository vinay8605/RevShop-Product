<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.pro.entity.Product"%>

<!DOCTYPE html>
<html>
<head>
    <title>Seller Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
        }
        h1, h2 {
            text-align: center;
            color: #555;
        }
        nav {
            background-color: #007bff;
            padding: 10px;
            text-align: center;
        }
        nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        nav ul li {
            display: inline;
        }
        nav ul li a {
            text-decoration: none;
            color: white;
            font-weight: bold;
            padding: 5px 10px;
        }
        nav ul li a:hover {
            background-color: #0056b3;
            border-radius: 5px;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table th, table td {
            padding: 10px;
            text-align: center;
        }
        table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        table tr:hover {
            background-color: #e9ecef;
        }
        table td img {
            width: 50px;
            height: auto;
            border-radius: 5px;
        }
        .actions a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .actions a:hover {
            text-decoration: underline;
        }
    </style>
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
            <th>Image</th>
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
                <td><img src="<%= product.getImage() %>" alt="Product Image"></td>
                <td class="actions">
                    <a href="/seller/dashboard/products/edit/<%= product.getId() %>">Edit</a> |
                    <a href="/seller/dashboard/products/delete/<%= product.getId() %>" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="7">No products available</td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>
