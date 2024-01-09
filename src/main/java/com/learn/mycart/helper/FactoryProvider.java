/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.helper;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class FactoryProvider {
    private static SessionFactory factory;

    public static SessionFactory getFactory() {
        try {
            if (factory == null) {
                factory = new Configuration()
                        .configure("hibernate.cfg.xml")
                        .buildSessionFactory();
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception according to your application's logic
            // You might consider logging the error or throwing a custom exception
        }
        return factory;
    }
}
