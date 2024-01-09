package com.learn.mycart.servlets;

import com.learn.mycart.dao.UserDao;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       processRequest(request, response);
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       processRequest(request, response);
   }

   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       response.setContentType("text/html;charset=UTF-8");

       try (PrintWriter out = response.getWriter()) {
           String email = request.getParameter("email");
           String password = request.getParameter("password");

           // Authentication logic
           UserDao userDao = new UserDao(FactoryProvider.getFactory());
           User user = userDao.getUserByEmailAndPassword(email, password);

           HttpSession httpSession = request.getSession();
           if (user == null) {
               httpSession.setAttribute("message", "Invalid Details !! Try with another one");
               response.sendRedirect("login.jsp");
               return;
           } else {
               httpSession.setAttribute("current-user", user);
               if (user.getUserType().equals("admin")) {
                   response.sendRedirect("admin.jsp");
               } else if (user.getUserType().equals("normal")) {
                   response.sendRedirect("normal.jsp");
               } else {
                   out.println("Not Identified User Type");
               }
           }
       }
   }
}
