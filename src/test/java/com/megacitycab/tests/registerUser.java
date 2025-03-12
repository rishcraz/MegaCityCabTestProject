/*
 * package com.megacitycab.tests;
 * 
 * import dao.UserDAO; import model.User; import
 * org.junit.jupiter.api.BeforeEach; import org.junit.jupiter.api.Test; import
 * org.mockito.Mock; import org.mockito.MockitoAnnotations;
 * 
 * import java.sql.Connection;
 * 
 * import static org.mockito.Mockito.*; import static
 * org.junit.jupiter.api.Assertions.*;
 * 
 * public class registerUser {
 * 
 * 
 * @Mock private Connection mockConnection;
 * 
 * private UserDAO userDAO;
 * 
 * @BeforeEach void setUp() { MockitoAnnotations.openMocks(this); userDAO = new
 * UserDAO(mockConnection); }
 * 
 * @Test void testRegisterUser() { User user = new User("U123", "John Doe",
 * "john@example.com", "1234567890", "123456789V", "123 Street", "password123");
 * 
 * UserDAO spyDAO = spy(userDAO);
 * doReturn(true).when(spyDAO).registerUser(any(User.class));
 * 
 * boolean isRegistered = spyDAO.registerUser(user); assertTrue(isRegistered,
 * "User registration should return true."); } }
 */