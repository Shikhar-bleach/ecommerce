<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@ page import="com.learn.mycart.entities.User" %>
<%

    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("message", "You are not logged in !! Login first");
        response.sendRedirect("login.jsp");
        return;

    } else {

        if (user.getUserType().equals("normal")) {

            session.setAttribute("message", "You are not admin ! Do not access this page");
            response.sendRedirect("login.jsp");
            return;

        }

    }


%>





<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>


    <div class="container admin">
        <div class="container-fluid">
         
        </div>               
        <div class="row mt-3">
            <!-- First col -->
            <div class="col-md-4">
                <!-- First box -->
                <div class="card">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/users.png" alt="">
                        </div>
                        <h1>2342</h1>
                        <h1 class="text-muted text-uppercase">Users</h1>
                    </div>
                </div>
            </div>
            <!-- Second col -->
            <div class="col-md-4">
                <!-- Second box -->
                <div class="card">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/category.png" alt="">
                        </div>
                        <h1>234</h1>
                        <h1 class="text-muted text-uppercase">Categories</h1>
                    </div>
                </div>
            </div>
            <!-- Third col -->
            <div class="col-md-4">
                <!-- Third box -->
                <div class="card">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/product.png" alt="">
                        </div>
                        <h1>7017</h1>
                        <h1 class="text-muted text-uppercase">Products</h1>
                    </div>
                </div>
            </div>
        </div>
        <!-- Second row -->
        <div class="row mt-3">
            <!-- First col -->
            <div class="col-md-6">
                <!-- Fourth box -->
                <div class="card" data-toggle="modal" data-target="#add-category-modal">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/addcategory.png" alt="Category Image">
                        </div>
                        <p>Click here to add a new category</p>
                        <h1 class="text-uppercase text-muted">Add Category</h1>
                    </div>
                </div>
            </div>
            <!-- Second col -->
            <div class="col-md-6">
                <!-- Fifth box -->
                <div class="card" data-toggle="modal" data-target="#add-product-modal">
                    <div class="card-body text-center">
                        <div class="container">
                            <img style="max-width: 125px;" src="img/addproduct.png" alt="addproductimage">
                        </div>
                       <p>Click here to add a new product</p>
                        <h1 class="text-uppercase text-muted">Add Product</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Category Modal -->
    <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header custom-bg text-white">
            <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <form action="ProductOperationServlet" method="post">
                  <input type="hidden" name="operation" value="addcategory">
                <div class="form-group">
                    <input type="text" class="form-control" name="catTitle" placeholder="Category Title">
                </div>
                <div class="form-group">
                    <textarea style="height: 300px;" name="catDescription" class="form-control" placeholder="Category Description"></textarea>
                </div>
                <div class="container text-center">
                    <button class="btn btn-outline-success">Add Category</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </form>
          </div>             
          </div>
        </div>
      </div>
    
   
    <!-- Add Product Modal -->
    <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                  <input type="hidden" name="operation" value="addproduct"/>
                <!-- Product title -->
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Enter title of product" name="pName">
                </div>
                <!-- Product price -->
                <div class="form-group">
                    <input type="number" class="form-control" placeholder="Enter product price" name="pPrice">
                </div>
                <!-- Product description -->
                <div class="form-group">
                    <textarea class="form-control" placeholder="Enter product description" name="pDesc"></textarea>
                </div>
                <!-- Product discount -->
                <div class="form-group">
                    <input type="number" class="form-control" placeholder="Enter product discount" name="pDiscount">
                </div>
                <!-- Product quantity -->
                <div class="form-group">
                    <input type="number" class="form-control" placeholder="Enter product quantity" name="pQuantity">
                </div>
                <!-- Product category -->
                <%                      
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> list = cdao.getCategories();
                %>
                <div class="form-group">
                    <select name="catId" class="form-control" id="">
                        <!-- Loop through the list of Category objects -->
                        <% for (Category c: list) { %>
                            <option value="<%= c.getCategoryId() %>"> <%= c.getCategoryTitle() %> </option>
                        <% } %>
                    </select>
                </div>
                <!-- Product file -->
                <div class="form-group">
                    <label for="pPic">Select Picture of product</label>
                    <input type="file" id="pPic" name="pPhoto" required />
                </div>
                <!-- Submit button -->
                <div class="container text-center">
                    <button class="btn btn-outline-success">Add product</button>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
          </div>          
        </div>
      </div>
    </div>
    
<%@include file="components/common_modals.jsp" %>
        
    </body>
</html>