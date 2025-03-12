package test.dao;

import org.junit.jupiter.api.*;

import com.megacitycab.dao.admin.EmployeeDAO;
import com.megacitycab.model.admin.Employee;
import com.megacitycab.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class EmployeeDAOTest {

    private static EmployeeDAO employeeDAO;

    @BeforeAll
    static void setUp() {
        employeeDAO = new EmployeeDAO();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(
                     "INSERT INTO employees (employee_id, username, password, email, phone, role, availability) " +
                             "VALUES ('EMP001', 'testdriver', 'password', 'test@megacitycab.com', '1234567890', 'Driver', 'Available')"
             )) {
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @AfterAll
    static void tearDown() {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement("DELETE FROM employees WHERE employee_id = 'EMP001'")) {
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    @Order(1)
    void testUpdateDriverAvailability() {
        assertTrue(employeeDAO.updateDriverAvailability("EMP001", "On a Ride"));
        Employee driver = employeeDAO.getDriverById("EMP001");
        assertEquals("Driver", driver.getRole());
    }

    @Test
    @Order(2)
    void testGetAvailableDrivers() {
        employeeDAO.updateDriverAvailability("EMP001", "Available");
        List<Employee> drivers = employeeDAO.getAvailableDrivers();
        assertFalse(drivers.isEmpty());
        assertEquals("EMP001", drivers.get(0).getEmployeeID());
    }

    @Test
    @Order(3)
    void testGetAllEmployees() {
        List<Employee> employees = employeeDAO.getAllEmployees();
        assertFalse(employees.isEmpty());
    }

    @Test
    @Order(4)
    void testGenerateNextEmployeeID() {
        String nextID = employeeDAO.generateNextEmployeeID();
        assertNotNull(nextID);
        assertTrue(nextID.startsWith("EMP"));
    }

	/*
	 * @Test
	 * 
	 * @Order(5) void testAddEmployee() {
	 * assertTrue(employeeDAO.addEmployee("EMP002", "newuser", "password",
	 * "newuser@megacitycab.com", "Manager")); Employee employee =
	 * employeeDAO.getEmployeeById("EMP002"); assertNotNull(employee);
	 * assertEquals("newuser", employee.getUsername()); }
	 */
    @Test
    @Order(6)
    void testGetEmployeeById() {
        Employee employee = employeeDAO.getEmployeeById("EMP001");
        assertNotNull(employee);
        assertEquals("testdriver", employee.getUsername());
    }

    @Test
    @Order(7)
    void testUpdateEmployee() {
        assertTrue(employeeDAO.updateEmployee("EMP001", "updateduser", "password", "updated@megacitycab.com", "Driver"));
        Employee updatedEmployee = employeeDAO.getEmployeeById("EMP001");
        assertEquals("updateduser", updatedEmployee.getUsername());
    }

	/*
	 * @Test
	 * 
	 * @Order(8) void testDeleteEmployee() {
	 * assertTrue(employeeDAO.deleteEmployee("EMP002"));
	 * assertNull(employeeDAO.getEmployeeById("EMP002")); }
	 */

    @Test
    @Order(9)
    void testFindEmployeeById() {
        Employee employee = employeeDAO.findEmployeeById("EMP001");
        assertNotNull(employee);
        assertEquals("EMP001", employee.getEmployeeID());
    }

    @Test
    @Order(10)
    void testUpdateDriverProfile() {
        Employee driver = new Employee("EMP001", "updatedDriver", "password", "driver@megacitycab.com", "1234567890", "Driver");
        assertTrue(employeeDAO.updateDriverProfile(driver));
        Employee updatedDriver = employeeDAO.findEmployeeById("EMP001");
        assertEquals("updatedDriver", updatedDriver.getUsername());
    }

    @Test
    @Order(11)
    void testUpdateDriverStatus() {
        assertTrue(employeeDAO.updateDriverStatus("EMP001", "Off Duty"));
        Employee driver = employeeDAO.getDriverById("EMP001");
        assertNotNull(driver);
    }

    @Test
    @Order(12)
    void testGetDriverById() {
        Employee driver = employeeDAO.getDriverById("EMP001");
        assertNotNull(driver);
        assertEquals("Driver", driver.getRole());
    }
}
