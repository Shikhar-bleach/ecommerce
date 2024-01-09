<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@ page import="com.learn.mycart.entities.User" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MyCart - Home </title>
    <script type="text/javascript">
        function add_to_cart(pid, pname, price) {
            let cart = localStorage.getItem("cart");
            if (cart === null) {
                // No cart yet
                let products = [];
                let product = { productId: pid, productName: pname, productQuantity: 1, productPrice: price };
                products.push(product);
                localStorage.setItem("cart", JSON.stringify(products));
                console.log("Product is added for the first time");
            } else {
                // Cart is already present
                let pcart = JSON.parse(cart);
                let oldProduct = pcart.find((item) => item.productId === pid);
                console.log(oldProduct);
                if (oldProduct) {
                    // We have to increase the quantity
                    oldProduct.productQuantity += 1;
                    pcart = pcart.map((item) => {
                        if (item.productId === oldProduct.productId) {
                            item.productQuantity = oldProduct.productQuantity;
                        }
                        return item;
                    });
                    localStorage.setItem("cart", JSON.stringify(pcart));
                    console.log("Product quantity is increased");
                } else {
                    // We have to add the product
                    let product = { productId: pid, productName: pname, productQuantity: 1, productPrice: price };
                    pcart.push(product);
                    localStorage.setItem("cart", JSON.stringify(pcart));
                    console.log("Product is added");
                }
            }
        }
    </script>
    <%@include file="components/common_css_js.jsp" %>       
</head>
<body>
    <%@include file="components/navbar.jsp" %>
    <div class="container-fluid">
        <div class="row mt-3 mx-2">
            <%
                String cat = request.getParameter("category");
                ProductDao dao = new ProductDao(FactoryProvider.getFactory());
                List<Product> list = null;

                if (cat == null || cat.trim().equals("all")) {
                    list = dao.getAllProducts();
                } else {
                    int cid = Integer.parseInt(cat.trim());
                    list = dao.getAllProductsById(cid);
                }

                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                List<Category> clist = cdao.getCategories();
            %>

            <!-- show categories -->
            <div class="col-md-2">
                <div class="list-group mt-4">
                    <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                        All Products
                    </a>
                    <% for (Category c : clist) { %>
                        <a href="index.jsp?category=<%=c.getCategoryId()%>" class="list-group-item list-group-item-action">
                            <%= c.getCategoryTitle() %>
                        </a>
                    <% } %>
                </div>
            </div>
            <!-- Show products -->
            <div class="col-md-10">
                <!-- Row -->
                <div class="row mt-4">
                    <!-- Column: 12 -->
                    <div class="col-md-12">
                        <div class="card-columns">
                            <!-- Traversing products -->
                            <% for (Product p : list) { %>
                                <div class="card product-card ">
                                    <div class="container text-center">                    
                                        <img src="img/products/<%= p.getpPhoto() %>" style="max-height: 200px; max-width: 100%; width: auto;" class="card-img-top m-2" alt="Product Image">
                                    </div>

                                    <div class="card-body">
                                        <h5 class="card-title"><%= p.getpName() %></h5>
                                        <p class="card-text">
                                            <%= Helper.get10Words(p.getpDesc()) %>
                                        </p>
                                    </div>
                                    <div class="card-footer text-center">
                                        <button class="btn custom-bg text-white" onclick="add_to_cart('<%= p.getpId() %>', '<%= p.getpName() %>', <%= p.getPriceAfterApplyingDiscount() %>)">Add to Cart</button>
                                        <button class="btn btn-outline-success">
                                            &#x20b9;<%= p.getPriceAfterApplyingDiscount() %>/-
                                            <span class="discount-label text-secondary" style="font-size: 10px !important;
                                                                                        font-style: italic !important;
                                                                                        text-decoration: line-through !important;
                                                                                        display: inline-block;" >
                                                <%= p.getpPrice() %> <%= p.getpDiscount() %>% off
                                            </span>
                                        </button>
                                    </div>
                                </div>
                            <% } %>
                            <% if(list.size()==0) { %>
                                <h2>No items in this Category</h2>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="components/common_modals.jsp" %>          
</body>
</html>
