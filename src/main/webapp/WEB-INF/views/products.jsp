<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pro.entity.Category" %>
<%@ page import="com.example.pro.entity.SubCategory" %>
<%@ page import="com.example.pro.entity.Product" %>

<html>
<head>
    <title>Products</title>
    <link rel="stylesheet" href="styles.css" />
    <style>
/* Modern CSS Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    /* Core Colors */
    --primary-color: #4f46e5;
    --primary-hover: #4338ca;
    --secondary-color: #0f172a;
    --success-color: #22c55e;
    --success-hover: #16a34a;
    --warning-color: #f59e0b;
    --warning-hover: #d97706;
    --background-color: #f8fafc;
    --card-background: #ffffff;
    
    /* Text Colors */
    --text-primary: #1e293b;
    --text-secondary: #64748b;
    --text-light: #94a3b8;
    
    /* Border & Shadow */
    --border-color: #e2e8f0;
    --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.12);
    --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
    --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
    --shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.1);
    
    /* Border Radius */
    --radius-sm: 0.375rem;
    --radius-md: 0.5rem;
    --radius-lg: 0.75rem;
    
    /* Transitions */
    --transition-base: all 0.3s ease;
}

/* Base Styles */
body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
    line-height: 1.6;
    background-color: var(--background-color);
    color: var(--text-primary);
}

/* Layout */
.container {
    display: flex;
    max-width: 1400px;
    margin: 2rem auto;
    padding: 0 2rem;
    gap: 2.5rem;
}

/* Sidebar Styles */
.sidebar {
    width: 300px;
    flex-shrink: 0;
}

.sidebar h3 {
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 1.5rem;
    color: var(--text-primary);
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.sidebar h3::before {
    content: "🏷️";
    font-size: 1.2em;
}

.sidebar h3 a {
    color: inherit;
    text-decoration: none;
    transition: var(--transition-base);
}

.sidebar h3 a:hover {
    color: var(--primary-color);
}

/* Search Bar */
.search-bar {
    width: 100%;
    padding: 0.75rem 1rem;
    padding-left: 2.5rem;
    font-size: 0.875rem;
    border: 1px solid var(--border-color);
    border-radius: var(--radius-sm);
    margin-bottom: 1.5rem;
    transition: var(--transition-base);
    background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%2364748b' viewBox='0 0 16 16'%3E%3Cpath d='M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z'/%3E%3C/svg%3E") no-repeat 12px center;
}

.search-bar:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
}

/* Category List and Dropdown Styles */
.sidebar ul {
    list-style: none;
    margin-bottom: 2rem;
}

.sidebar ul li {
    margin: 0.25rem 0;
    position: relative;
}

.sidebar ul li a {
    color: var(--text-secondary);
    text-decoration: none;
    font-size: 0.875rem;
    transition: var(--transition-base);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0.75rem 1rem;
    border-radius: var(--radius-sm);
    background: var(--card-background);
    border: 1px solid transparent;
}

.sidebar ul li a:hover {
    color: var(--primary-color);
    background-color: rgba(79, 70, 229, 0.05);
    border-color: var(--border-color);
}

/* Dropdown Container */
.dropdown {
    position: relative;
}

/* Add arrow indicator for dropdown */
.dropdown > a::after {
    content: "→";
    font-size: 1rem;
    opacity: 0.5;
    transition: var(--transition-base);
}

.dropdown:hover > a::after {
    opacity: 1;
    transform: translateX(3px);
}

/* Dropdown Content */
.dropdown-content {
    display: none;
    position: absolute;
    left: calc(100% + 0.5rem);
    top: 0;
    min-width: 240px;
    background: var(--card-background);
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-xl);
    z-index: 100;
    border: 1px solid var(--border-color);
    padding: 0.5rem;
}

/* Dropdown Links */
.dropdown-content a {
    padding: 0.75rem 1rem;
    color: var(--text-secondary);
    font-size: 0.875rem;
    display: block;
    transition: var(--transition-base);
    border-radius: var(--radius-sm);
    margin: 0.25rem 0;
}

.dropdown-content a:hover {
    color: var(--primary-color);
    background-color: rgba(79, 70, 229, 0.05);
    transform: translateX(3px);
}

/* Show dropdown on hover */
.dropdown:hover .dropdown-content {
    display: block;
    animation: slideIn 0.2s ease-out;
}

/* Filter Section */
.filter-section {
    background: var(--card-background);
    padding: 1.75rem;
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
    margin-bottom: 1.5rem;
    border: 1px solid var(--border-color);
}

.filter-section h4 {
    font-size: 1rem;
    margin-bottom: 1rem;
    color: var(--text-primary);
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.filter-section h4::before {
    content: "💰";
    font-size: 1.1em;
}

input[type="range"] {
    width: 100%;
    margin: 1rem 0;
    height: 6px;
    background: var(--primary-color);
    border-radius: var(--radius-lg);
    -webkit-appearance: none;
}

input[type="range"]::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: 18px;
    height: 18px;
    background: white;
    border: 2px solid var(--primary-color);
    border-radius: 50%;
    cursor: pointer;
    transition: var(--transition-base);
}

input[type="range"]::-webkit-slider-thumb:hover {
    transform: scale(1.1);
}

/* Product List */
.product-list {
    flex-grow: 1;
}

.product-list h3 {
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 2rem;
    color: var(--text-primary);
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.product-list h3::before {
    content: "🛍️";
    font-size: 1.2em;
}

.product-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 2rem;
}

/* Product Card */
.product-item {
    background: var(--card-background);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
    overflow: hidden;
    transition: var(--transition-base);
    border: 1px solid var(--border-color);
}

.product-item:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-xl);
}

.product-image {
    width: 100%;
    height: 240px;
    object-fit: cover;
    transition: var(--transition-base);
}

.product-item:hover .product-image {
    transform: scale(1.05);
}

.product-content {
    padding: 1.5rem;
}

.product-item h4 {
    font-size: 1.125rem;
    font-weight: 600;
    margin-bottom: 0.75rem;
    color: var(--text-primary);
}

.description {
    font-size: 0.875rem;
    color: var(--text-secondary);
    margin-bottom: 1rem;
    line-height: 1.5;
}

.price {
    font-size: 1.375rem;
    font-weight: 600;
    color: var(--primary-color);
    margin-bottom: 0.75rem;
    display: flex;
    align-items: center;
    gap: 0.25rem;
}

.price::before {
    content: "$";
    font-size: 0.875rem;
    color: var(--text-light);
}

.stock-status {
    font-size: 0.875rem;
    color: var(--success-color);
    margin-bottom: 1.25rem;
    display: flex;
    align-items: center;
    gap: 0.375rem;
}

.stock-status::before {
    content: "✓";
    font-weight: bold;
}

/* Button Styles */
.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.75rem 1.25rem;
    font-size: 0.875rem;
    font-weight: 500;
    text-decoration: none;
    border-radius: var(--radius-md);
    transition: var(--transition-base);
    border: none;
    cursor: pointer;
    gap: 0.5rem;
}

.view-details {
    background-color: var(--primary-color);
    color: white;
    width: 100%;
}

.view-details:hover {
    background-color: var(--primary-hover);
    transform: translateY(-1px);
}

.add-to-cart {
    background-color: var(--success-color);
    color: white;
}

.add-to-cart:hover {
    background-color: var(--success-hover);
    transform: translateY(-1px);
}

.add-to-wishlist {
    background-color: var(--warning-color);
    color: white;
}

.add-to-wishlist:hover {
    background-color: var(--warning-hover);
    transform: translateY(-1px);
}

/* Form Styles */
.btn-form {
    margin: 1rem 0;
    display: flex;
    gap: 0.5rem;
}

.btn-form input[type="number"] {
    width: 80px;
    padding: 0.5rem;
    border: 1px solid var(--border-color);
    border-radius: var(--radius-md);
    font-size: 0.875rem;
    transition: var(--transition-base);
}

.btn-form input[type="number"]:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
}

/* View Cart Link */
.view-cart-link {
    margin-top: 2rem;
    text-align: center;
}

.view-cart-link .btn {
    width: 100%;
    background-color: var(--secondary-color);
}

.view-cart-link .btn:hover {
    background-color: var(--text-primary);
}

/* Animations */
@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(-10px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

/* Responsive Design */
@media (max-width: 1024px) {
    .container {
        flex-direction: column;
        padding: 1rem;
    }
    
    .sidebar {
        width: 100%;
    }
    
    .dropdown-content {
        left: 0;
        top: 100%;
        width: 100%;
        margin-top: 0.5rem;
    }

    .dropdown > a::after {
        content: "↓";
    }

    .dropdown:hover > a::after {
        transform: translateY(3px);
    }

    .product-container {
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
}

@media (max-width: 640px) {
    .container {
        padding: 1rem;
        margin: 1rem auto;
    }
    
    .product-container {
        grid-template-columns: 1fr;
    }
    
    .product-item {
        max-width: 100%;
    }
    
    .btn-form {
        flex-direction: column;
    }
    
    .btn-form input[type="number"] {
        width: 100%;
    }
}
    </style>
</head>
<body>
    <div class="container">
        <!-- Left Side: Filters -->
        <div class="sidebar">
            <h3><a href="/products">Categories</a></h3>
            <input type="text" placeholder="Search Categories..." class="search-bar" id="categorySearch" oninput="filterCategories()" />
            <ul id="categoryList">
                <!-- Loop through categories passed from the model -->
                <%
                    List<Category> categories = (List<Category>) request.getAttribute("categories");
                    for (Category category : categories) {
                %>
                    <li class="dropdown">
                        <a href="/products?category=<%= category.getName() %>"><%= category.getName() %></a>
                        <div class="dropdown-content">
                        
                            <!-- Loop through subcategories for each category -->
                            <%
                                List<SubCategory> subcategories = (List<SubCategory>) request.getAttribute("subcategories");
                                for (SubCategory subcategory : subcategories) {
                                    if (subcategory.getCategory().getName().equals(category.getName())) {
                            %>
                                        <a href="/products?subcategory=<%= subcategory.getName() %>"><%= subcategory.getName() %></a>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </li>
                <%
                    }
                %>
            </ul>

            <!-- Price Range Filter -->
            <div class="filter-section">
                <h4>Filter by Price</h4>
                <input type="range" min="0" max="5000" value="5000" id="priceFilter" onchange="filterByPrice()" />
                <p>Max Price: $<span id="priceValue">5000</span></p>
            </div>

            <!-- View Cart Link -->
            <div class="view-cart-link">
                <a href="/cart/view" class="btn view-details">View Cart</a>
            </div>

        </div>

        <!-- Right Side: Products -->
        <div class="product-list">
            <h3>All Products</h3>
            <div class="product-container">
                <!-- Loop through products passed from the model -->
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    for (Product product : products) {
                %>
                    <div class="product-item">
    <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="product-image"/>
    <div class="product-content">
        <h4><%= product.getName() %></h4>
        <p class="description"><%= product.getDescription() %></p>
        <p class="price">Price: $<%= product.getPrice() %></p>
        <p class="stock-status">In stock: <%= product.getQuantity() > 0 ? "Yes" : "No" %></p>
        <a href="/products/product/<%= product.getId() %>" class="btn view-details">View Details</a>
        <form action="/cart/add" method="post" class="btn-form">
            <input type="hidden" name="productId" value="<%= product.getId() %>" />
            <input type="number" name="quantity" value="1" min="1" required />
            <button type="submit" class="btn add-to-cart">Add to Cart</button>
        </form>
        <form action="/products/<%= product.getId() %>/add-to-wishlist" method="post" class="btn-form">
            <button type="submit" class="btn add-to-wishlist">Add to Wishlist</button>
        </form>
    </div>
</div>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <script>
        function filterCategories() {
            var input = document.getElementById("categorySearch");
            var filter = input.value.toLowerCase();
            var ul = document.getElementById("categoryList");
            var li = ul.getElementsByTagName("li");

            for (var i = 0; i < li.length; i++) {
                var a = li[i].getElementsByTagName("a")[0];
                if (a.innerHTML.toLowerCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";
                }
            }
        }

        function filterByPrice() {
            var price = document.getElementById("priceFilter").value;
            document.getElementById("priceValue").innerHTML = price;
            // You can implement your product filtering logic here based on the price
        }
    </script>
</body>
</html>
