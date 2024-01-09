
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
         <%@include file="components/navbar.jsp" %>
         <div class="container-fluid">
             <div class="row mt-5">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <%@include file="components/message.jsp"%>
                    <div class="card-body px-5">
                           <h3 class="text-center my-3">
                            <i class="fas fa-user-plus text-primary"></i> 
                            Sign up Here!
                            </h3>
                <form action="RegisterServlet" method="post">
                    <div class="form-group">
                        <label for="name">User Name</label>
                        <input type="text" name="user_name" class="form-control" id="name" placeholder="Enter username" aria-label="Enter username" aria-describedby="nameHelp">

                    </div>

                    <div class="form-group">
                        <label for="email">User Email</label>
                        <input type="email" name="user_email" class="form-control" id="email" placeholder="Enter email" aria-label="Enter email" aria-describedby="emailHelp2">

                    </div>

                    <div class="form-group">
                        <label for="password">User Password</label>
                        <input type="password" name="user_password" class="form-control" id="password" placeholder="Enter password" aria-label="Enter password" aria-describedby="passwordHelp">

                    </div>
                    <div class="form-group">
                        <label for="phone">User Phone Number</label>
                        <input type="tel" name="user_phone" class="form-control" id="phone" placeholder="Enter Phone Number" aria-label="Enter Phone" aria-describedby="phoneHelp">

                    </div>
                     <div class="form-group">
                        <label for="userAddress">User Address</label>
                        <textarea name="user_address" class="form-control" id="userAddress" placeholder="Enter address" rows="3"></textarea>           
                    </div>
                    <div class="container text-center">
                        <button class="btn btn-outline-success">Register</button>
                        <button class="btn btn-outline-warning">Reset</button>
                    </div>

                </form>
                    </div>
                </div>
            </div>
        </div>
         </div>
    </body>
</html>
