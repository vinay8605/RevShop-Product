<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.pro.entity.Product"%>

<!DOCTYPE html>
<html>
<head>
    <title>Seller Dashboard</title>
    <style>
		:root {
		    --primary-color: #ff3f6c;
		    --secondary-color: #f5f5f5;
		    --text-color: #282c3f;
		    --background-color: #f8f9fa;
		    --hover-color: #ff1744;
		    --border-color: #e0e0e0;
		}

		* {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		}

		body {
		    font-family: 'Roboto', Arial, sans-serif;
		    background-color: var(--background-color);
		    color: var(--text-color);
		    line-height: 1.6;
		}

		h1, h2 {
		    text-align: center;
		    color: var(--primary-color);
		    margin: 30px 0;
		    font-weight: 700;
		}

		h1 {
		    font-size: 28px;
		}

		h2 {
		    font-size: 24px;
		}

		nav {
		    background-color: var(--primary-color);
		    padding: 15px 0;
		    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
		}

		nav ul {
		    list-style: none;
		    display: flex;
		    justify-content: center;
		    gap: 30px;
		}

		nav ul li a {
		    text-decoration: none;
		    color: white;
		    font-weight: 600;
		    padding: 10px 15px;
		    border-radius: 4px;
		    transition: background-color 0.3s ease;
		}

		nav ul li a:hover {
		    background-color: var(--hover-color);
		}

		table {
		    width: 90%;
		    max-width: 1200px;
		    margin: 30px auto;
		    border-collapse: separate;
		    border-spacing: 0;
		    background-color: white;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		    border-radius: 8px;
		    overflow: hidden;
		}

		table th, table td {
		    padding: 12px 15px;
		    text-align: center;
		    border-bottom: 1px solid var(--border-color);
		}

		table th {
		    background-color: var(--primary-color);
		    color: white;
		    font-weight: 600;
		    text-transform: uppercase;
		    letter-spacing: 0.5px;
		}

		table tr:last-child td {
		    border-bottom: none;
		}

		table tr:nth-child(even) {
		    background-color: #f9f9f9;
		}

		table tr:hover {
		    background-color: #f0f0f0;
		    transition: background-color 0.3s ease;
		}

		table td img {
		    width: 60px;
		    height: 60px;
		    object-fit: cover;
		    border-radius: 6px;
		    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
		}

		.actions {
		    display: flex;
		    justify-content: center;
		    gap: 15px;
		}

		.actions a {
		    text-decoration: none;
		    color: var(--primary-color);
		    font-weight: 600;
		    padding: 5px 10px;
		    border-radius: 4px;
		    transition: background-color 0.3s ease, color 0.3s ease;
		}

		.actions a:first-child {
		    color: var(--primary-color);
		}

		.actions a:last-child {
		    color: #dc3545;
		}

		.actions a:hover {
		    background-color: rgba(255, 63, 108, 0.1);
		}

		.actions a:last-child:hover {
		    background-color: rgba(220, 53, 69, 0.1);
		}

		@media (max-width: 768px) {
		    table {
		        width: 95%;
		        font-size: 14px;
		    }

		    nav ul {
		        flex-direction: column;
		        align-items: center;
		        gap: 10px;
		    }

		    table td img {
		        width: 40px;
		        height: 40px;
		    }
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
