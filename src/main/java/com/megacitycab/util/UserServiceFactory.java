package util;

import dao.UserDAO;

public class UserServiceFactory {
    private static UserDAO userDAO;

    public static UserDAO getUserDAO() {
        if (userDAO == null) {
            userDAO = new UserDAO();
        }
        return userDAO;
    }
}