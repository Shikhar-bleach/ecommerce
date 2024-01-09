package com.learn.mycart.dao;

import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryDao 
{

    private final SessionFactory factory;

    public CategoryDao(SessionFactory factory) 
    {
      this.factory = factory;
    }

   
    public int saveCategory(Category cat) 
    {
        Session session = this.factory.openSession();
        Transaction tx = null;
        int catId = 0;
        try 
        {
            tx = session.beginTransaction();
            catId = (int) session.save(cat);
            tx.commit();
        } 
        catch (Exception e) 
        {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } 
        finally 
        {
            session.close();
        }
        return catId;
    }
    public List<Category> getCategories() 
    {
        Session s = this.factory.openSession(); // Opens a session using Hibernate's SessionFactory
        Query query = s.createQuery("from Category"); // Creates a Hibernate Query to retrieve all Category objects
        List<Category> list = query.list(); // Executes the query and retrieves a list of Category objects
        return list; // Returns the list of Category objects fetched from the database
    } 
    public Category getCategoryById(int cid) 
    {
        Category cat = null;
        try {
            try (Session session = this.factory.openSession() // Opens a session using Hibernate's SessionFactory
            ) {
                cat = session.get(Category.class, cid); // Retrieves the Category object by its ID using session.get
                // Closes the session to release resources
            } // Retrieves the Category object by its ID using session.get
        } catch (Exception e) {
            e.printStackTrace(); // Prints the stack trace if an exception occurs (for debugging purposes)
        }
        return cat; // Returns the fetched Category object or null if not found or an exception occurred
    }
    // get all products of given category
    


}
