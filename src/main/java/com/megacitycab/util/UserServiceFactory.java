package com.megacitycab.util;

import com.megacitycab.dao.UserDAO;

public class UserServiceFactory {
    private static UserDAO userDAO;

    public static UserDAO getUserDAO() {
        if (userDAO == null) {
            userDAO = new UserDAO();
        }
        return userDAO;
    }
}