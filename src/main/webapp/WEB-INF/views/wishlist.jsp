<%@ page import="java.util.List" %>
<%@ page import="com.example.pro.entity.Wishlist" %>
<%@ page import="com.example.pro.entity.Product" %>
<%@ page import="com.example.entity.Buyer" %>

<html>
<head>
    <title>Your Wishlist</title>
</head>
<body>
    <h1>Your Wishlist</h1>

    <%-- Check if the wishlist is empty --%>
    <%
        List<Wishlist> wishlistProducts = (List<Wishlist>) request.getAttribute("wishlistProducts");
        if (wishlistProducts == null || wishlistProducts.isEmpty()) {
    %>
        <p>Your wishlist is empty.</p>
    <%
        } else {
            // Loop through the wishlist items
            for (Wishlist wishlist : wishlistProducts) {
                Product product = wishlist.getProduct(); // Get the Product from the Wishlist
    %>
                <div class="wishlist-item">
                    <h3><%= product.getName() %></h3>
                    <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" width="100" height="100">
                    <p><%= product.getDescription() %></p>
                    <p>Price: $<%= product.getPrice() %></p>
                    <a href="/product/<%= product.getId() %>">View Product</a>
                </div>
    <%
            }
        }
    %>

</body>
</html>
