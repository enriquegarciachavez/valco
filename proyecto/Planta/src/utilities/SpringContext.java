/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

/**
 *
 * @author Administrador
 */
public class SpringContext {

    private static ApplicationContext context;

    private SpringContext() {

    }

    public static ApplicationContext getContext() {
        if (context == null) {
             context = new ClassPathXmlApplicationContext("context.xml");
            

        }
        return context;
    }

}
