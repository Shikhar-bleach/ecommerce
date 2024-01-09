package com.learn.mycart.servlets;
import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
@MultipartConfig
public class ProductOperationServlet extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
           String op = request.getParameter("operation");
            if (op != null && !op.isEmpty()) 
            {
                if (op.trim().equals("addcategory")) 
                {
                    // Adding a category
                    String title = request.getParameter("catTitle");
                    String description = request.getParameter("catDescription");

                    // Create a new Category instance and set values
                    Category category = new Category();
                    category.setCategoryTitle(title);
                    category.setCategoryDescription(description);

                    // Save the category to the database
                    try {
                        CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                        int catId = categoryDao.saveCategory(category);
                        if (catId > 0) {
                            HttpSession httpSession = request.getSession();
                            httpSession.setAttribute("message", "Category added successfully: " + catId);
                        } else {
                            HttpSession httpSession = request.getSession();
                            httpSession.setAttribute("message", "Category addition failed!");
                        }
                        response.sendRedirect("admin.jsp");
                        return;
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("message", "Error adding category: " + ex.getMessage());
                        response.sendRedirect("admin.jsp");
                        return;
                    }


                } 
                else if (op.trim().equals("addproduct")) 
                {
                    String pName = request.getParameter("pName");
                    String pDesc = request.getParameter("pDesc");
                    int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                    int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                    int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                    int catId = Integer.parseInt(request.getParameter("catId"));
                    Part part = request.getPart("pPhoto");
                    Product p = new Product();
                    p.setpName(pName);
                    p.setpDesc(pDesc);
                    p.setpPrice(pPrice);
                    p.setpDiscount(pDiscount);
                    p.setpQuantity(pQuantity);
                    p.setpPhoto(part.getSubmittedFileName());
                    // Get category by id
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    Category category = cdao.getCategoryById(catId);
                    p.setCategory(category);

                    // Save the product
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    pdao.saveProduct(p);
                    // Getting the path to upload the photo
                   String path = request.getRealPath("img") + File.separator + "products" + File.separator;

                   System.out.println(path);

                    // Uploading code
                    try
                    {
                   String fileName = part.getSubmittedFileName();

                    // Creating the complete file path
                    String filePath = path + File.separator + fileName;

                    // Creating a FileOutputStream with the correct file path
                    FileOutputStream fos = new FileOutputStream(filePath);

                    // Reading data from the part (file upload)
                    InputStream is = part.getInputStream();
                    // Reading data
                    byte[] data = new byte[is.available()];
                    is.read(data);                    
                    // Writing the data to the output stream
                    fos.write(data);
                    fos.close();
                    }
                    catch(Exception e)
                    {
                        e.printStackTrace();
                        
                    }
                    out.println("Product saved successfully.");
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("message", "Product is added successfully..");
                    response.sendRedirect("admin.jsp");
                    return;
    

                }
            }
        }
    }
}