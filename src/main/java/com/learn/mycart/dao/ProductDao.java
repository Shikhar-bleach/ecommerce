package com.learn.mycart.dao;
import com.learn.mycart.entities.Product;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveProduct(Product product) {
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(product);
            tx.commit();
            session.close();
            return true; // Return true to indicate successful save
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false to indicate failure due to an exception
        }
    }
    // Get all products
        public List<Product> getAllProducts() {
            try (Session session = this.factory.openSession()) {
                Query<Product> query = session.createQuery("FROM Product", Product.class);
                return query.list();
            } catch (HibernateException e) {
                e.printStackTrace();
                return null;
            }
        }
        public List<Product> getAllProductsById(int cid) 
    {
        // Open a session using the factory
        Session s = this.factory.openSession();

        // Create a query to fetch products of the provided category ID
        Query query = s.createQuery("from Product as p where p.category.categoryId=:id");
        query.setParameter("id", cid);

        // Execute the query and retrieve the list of products
        List<Product> list = query.list();

        // Close the session
        s.close();

        return list; // Return the list of products
    }

}
