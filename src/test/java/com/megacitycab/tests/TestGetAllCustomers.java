/*
 * package com.megacitycab.tests;
 * 
 * import dao.UserDAO; import model.User; import
 * org.junit.jupiter.api.BeforeEach; import org.junit.jupiter.api.Test; import
 * org.mockito.Mock; import org.mockito.MockitoAnnotations;
 * 
 * import java.sql.Connection; import java.util.Arrays; import java.util.List;
 * 
 * import static org.mockito.Mockito.*; import static
 * org.junit.jupiter.api.Assertions.*;
 * 
 * 
 * public class TestGetAllCustomers {
 * 
 * 
 * @Mock private Connection mockConnection;
 * 
 * private UserDAO userDAO;
 * 
 * @BeforeEach void setUp() { MockitoAnnotations.openMocks(this); userDAO = new
 * UserDAO(mockConnection); }
 * 
 * @Test void testGetAllCustomers() { UserDAO spyDAO = spy(userDAO); List<User>
 * mockCustomers = Arrays.asList( new User("USR002", "John Doe",
 * "john@megacitycab.com", "1234567890", "123456789V", "123 Street", null), new
 * User("USR003", "Jane Doe", "jane@megacitycab.com", "0987654321",
 * "987654321V", "456 Street", null) );
 * 
 * doReturn(mockCustomers).when(spyDAO).getAllCustomers();
 * 
 * List<User> customers = spyDAO.getAllCustomers(); assertNotNull(customers,
 * "Customer list should not be null."); assertEquals(2, customers.size(),
 * "Should return exactly 2 customers."); } }
 */