<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Details</title>
    <link rel="stylesheet" href="styles.css" />
    <style>
        /* Modern CSS Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: #FAFBFC;
            color: #1A1A1A;
            line-height: 1.5;
        }

        /* Container Layout */
        .container {
            display: grid;
            grid-template-columns: 1fr 1.2fr;
            gap: 48px;
            max-width: 1280px;
            margin: 40px auto;
            padding: 32px;
            background-color: #FFFFFF;
            border-radius: 16px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        /* Product Image Styling */
        .product-image-container {
            position: relative;
        }

        .product-image {
            width: 100%;
            height: auto;
            border-radius: 12px;
            object-fit: cover;
            aspect-ratio: 1/1;
            background-color: #F5F5F5;
        }

        /* Product Information */
        .product-info {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .product-info h3 {
            font-size: 32px;
            font-weight: 600;
            color: #111827;
            letter-spacing: -0.02em;
            line-height: 1.2;
        }

        .product-info .description {
            font-size: 16px;
            color: #4B5563;
            line-height: 1.6;
        }

        .product-info .price {
            font-size: 28px;
            font-weight: 700;
            color: #111827;
        }

        .stock-status {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            font-weight: 500;
            padding: 6px 12px;
            border-radius: 8px;
            background-color: #ECFDF5;
            color: #065F46;
        }

        .stock-status::before {
            content: "•";
            color: #059669;
        }

        /* Button Styling */
        .button-container {
            display: flex;
            gap: 16px;
            margin-top: 8px;
        }

        .btn {
            flex: 1;
            padding: 14px 24px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
            text-align: center;
        }

        .btn.add-to-cart {
            background-color: #4F46E5;
            color: white;
        }

        .btn.add-to-cart:hover {
            background-color: #4338CA;
            transform: translateY(-1px);
        }

        .btn.add-to-wishlist {
            background-color: #F3F4F6;
            color: #111827;
            border: 1px solid #E5E7EB;
        }

        .btn.add-to-wishlist:hover {
            background-color: #E5E7EB;
            transform: translateY(-1px);
        }

        /* Enhanced Responsive Design */
        @media (max-width: 1024px) {
            .container {
                max-width: 95%;
                padding: 24px;
                gap: 32px;
            }
        }

        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
                padding: 20px;
            }

            .product-info h3 {
                font-size: 28px;
            }

            .product-image {
                aspect-ratio: 4/3;
            }

            .button-container {
                flex-direction: column;
            }
        }

        @media (max-width: 480px) {
            .container {
                margin: 0;
                border-radius: 0;
            }

            .product-info h3 {
                font-size: 24px;
            }

            .product-info .price {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Left Side: Product Image -->
        <div class="product-image-container">
            <img src="${product.image}" alt="${product.name}" class="product-image" />
        </div>

        <!-- Right Side: Product Info -->
        <div class="product-info">
            <h3>${product.name}</h3>
            <p class="description">${product.description}</p>
            <p class="price">$${product.price}</p>
            <p class="stock-status">${product.quantity > 0 ? 'In Stock' : 'Out of Stock'}</p>

            <div class="button-container">
                <!-- Add to Cart Button -->
                <form action="/product/${product.id}/add-to-cart" method="post">
                    <button type="submit" class="btn add-to-cart">Add to Cart</button>
                </form>

                <!-- Add to Wishlist Button -->
                <form action="/product/${product.id}/add-to-wishlist" method="post">
                    <button type="submit" class="btn add-to-wishlist">Add to Wishlist</button>
                </form>
            </div>
        </div>
    </div>

</body>
</html>