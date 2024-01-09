<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in!! Login first to access checkout page");
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Checkout JSP Page</title>
    <%@ include file="components/common_css_js.jsp" %>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>

    <div class="container">
        <div class="row mt-5">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center mb-5">Your selected items</h3>
                        <div class="cart-body">
                            </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center mb-5">Your details for order</h3>
                        <form action="process_order.jsp"> <div class="form-group">
                                <label for="email">Email address</label>
                                <input type="email" class="form-control" id="email" aria-describedby="emailHelp">
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="name">Your name</label>
                                <input type="text" class="form-control" id="name" placeholder="">
                            </div>
                            <div class="form-group">
                                <label for="address">Your shipping address</label>
                                <textarea class="form-control" id="address" placeholder="Enter your shipping address"></textarea>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-success">Order Now</button>
                                <button class="btn btn-secondary">Continue Shopping</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="components/common_modals.jsp" %>
</body>
</html>
