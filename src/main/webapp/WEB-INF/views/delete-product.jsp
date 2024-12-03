<!DOCTYPE html>
<html>
<head>
    <title>Delete Product</title>
</head>
<body>
    <h2>Delete Product</h2>
    <form action="/seller/dashboard/products/delete" method="post">
        <input type="hidden" id="id" name="id" value="<%= request.getParameter("id") %>">
        
        <p>Are you sure you want to delete this product?</p>
        
        <input type="submit" value="Yes, Delete Product">
        <a href="/seller/dashboard/products">Cancel</a>
    </form>
</body>
</html>
