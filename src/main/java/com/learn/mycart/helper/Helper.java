
package com.learn.mycart.helper;

public class Helper {
    public static String get10Words(String desc) 
    {
        String[] strs = desc.split(" ");
        if (strs.length > 10) {
            StringBuilder res = new StringBuilder();
            for (int i = 0; i < 10; i++) {
                res.append(strs[i]).append(" ");
            }
            return res.toString().trim() + "...";
        } else {
            return desc + "...";
        }
    }
    
}
