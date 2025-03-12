/*
 * package com.megacitycab.tests;
 * 
 * import dao.UserDAO; import model.User; import
 * org.junit.jupiter.api.BeforeEach; import org.junit.jupiter.api.Test; import
 * org.mockito.Mock; import org.mockito.MockitoAnnotations; import
 * java.sql.Connection;
 * 
 * import static org.mockito.Mockito.*; import static
 * org.junit.jupiter.api.Assertions.*;
 * 
 * class UserDAOTest {
 * 
 * @Mock private Connection mockConnection;
 * 
 * private UserDAO userDAO;
 * 
 * @BeforeEach void setUp() { MockitoAnnotations.openMocks(this); userDAO = new
 * UserDAO(mockConnection); }
 * 
 * @Test void testUserLoginSuccess() { User user = userDAO.loginUser("testUser",
 * "password123"); assertNotNull(user); } }
 */