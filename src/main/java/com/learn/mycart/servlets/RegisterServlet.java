
package com.learn.mycart.servlets;
import javax.servlet.http.*;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try{
                String userName=request.getParameter("user_name");
                String userPassword=request.getParameter("user_password");
                String userPhone=request.getParameter("user_phone");
                String userAddress=request.getParameter("user_address");
                String userEmail=request.getParameter("user_email");
                User user=new User(userName,userEmail,userPassword,userPhone,"default.jpg",userAddress,"normal");
                Session hibernateSession = FactoryProvider.getFactory().openSession();
                Transaction tx = hibernateSession.beginTransaction();
                int userId = (int) hibernateSession.save(user);
                tx.commit();
                hibernateSession.close();
//                out.println("successfully saved");
//                out.println("<br>User id is: " + userId);
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Registration Successful !! User ID: " + userId);
                response.sendRedirect("register.jsp");
                return;

            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        }
    }


}
