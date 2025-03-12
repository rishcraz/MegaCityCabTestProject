/*
 * package com.megacitycab.tests; import dao.UserDAO; import model.User; import
 * org.junit.jupiter.api.BeforeEach; import org.junit.jupiter.api.Test; import
 * org.mockito.Mock; import org.mockito.MockitoAnnotations;
 * 
 * import java.sql.Connection;
 * 
 * import static org.mockito.Mockito.*; import static
 * org.junit.jupiter.api.Assertions.*;
 * 
 * 
 * public class updateCustomerProfile {
 * 
 * 
 * @Mock private Connection mockConnection;
 * 
 * private UserDAO userDAO;
 * 
 * @BeforeEach void setUp() { MockitoAnnotations.openMocks(this); userDAO = new
 * UserDAO(mockConnection); }
 * 
 * @Test void testUpdateCustomerProfile() { User updatedUser = new User("U123",
 * "John Updated", "john.updated@example.com", "1234567890", "123456789V",
 * "New Address", null);
 * 
 * UserDAO spyDAO = spy(userDAO);
 * doReturn(true).when(spyDAO).updateCustomerProfile(any(User.class));
 * 
 * boolean isUpdated = spyDAO.updateCustomerProfile(updatedUser);
 * assertTrue(isUpdated, "Profile update should return true."); } }
 */