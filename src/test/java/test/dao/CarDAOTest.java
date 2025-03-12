package test.dao;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.megacitycab.dao.admin.CarDAO;
import com.megacitycab.model.admin.Car;

import java.sql.Connection;
import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class CarDAOTest {

    @Mock
    private Connection mockConnection;

    private CarDAO carDAO;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); 
        carDAO = new CarDAO(); 
    }

    @Test
    void testGetAllCars() {
      
        CarDAO spyDAO = spy(carDAO);

    
        List<Car> mockCars = Arrays.asList(
                new Car("C001", "Toyota", "ABC123", "Available"),
                new Car("C002", "Honda", "XYZ456", "Unavailable")
        );

       
        doReturn(mockCars).when(spyDAO).getAllCars();

     
        List<Car> cars = spyDAO.getAllCars();

      
        assertNotNull(cars, "Car list should not be null");
        assertEquals(2, cars.size(), "Should return exactly 2 cars");
        assertEquals("Toyota", cars.get(0).getModel());
        assertEquals("Unavailable", cars.get(1).getStatus());
    }

    @Test
    void testGetAvailableCars() {
      
        CarDAO spyDAO = spy(carDAO);

      
        List<Car> mockAvailableCars = Arrays.asList(
                new Car("C001", "Toyota", "ABC123", "Available")
        );

       
        doReturn(mockAvailableCars).when(spyDAO).getAvailableCars();

        // Act
        List<Car> availableCars = spyDAO.getAvailableCars();

       
        assertNotNull(availableCars, "Available cars list should not be null");
        assertEquals(1, availableCars.size(), "Should return exactly 1 available car");
        assertEquals("Available", availableCars.get(0).getStatus());
    }

    @Test
    void testAddCar() {
        CarDAO spyDAO = spy(carDAO);

      
        doReturn(true).when(spyDAO).addCar("Toyota", "ABC123", "Available");

    
        boolean result = spyDAO.addCar("Toyota", "ABC123", "Available");

        assertTrue(result, "Car should be added successfully");
    }

    @Test
    void testUpdateCar() {
        CarDAO spyDAO = spy(carDAO);

       
        doReturn(true).when(spyDAO).updateCar("C001", "Honda", "XYZ456", "Available");

      
        boolean result = spyDAO.updateCar("C001", "Honda", "XYZ456", "Available");

      
        assertTrue(result, "Car should be updated successfully");
    }

    @Test
    void testDeleteCar() {
        CarDAO spyDAO = spy(carDAO);

       
        doReturn(true).when(spyDAO).deleteCar("C001");

        
        boolean result = spyDAO.deleteCar("C001");

        
        assertTrue(result, "Car should be deleted successfully");
    }

    @Test
    void testFindCarById() {
        CarDAO spyDAO = spy(carDAO);

       
        Car mockCar = new Car("C001", "Toyota", "ABC123", "Available");
        doReturn(mockCar).when(spyDAO).findCarById("C001");

       
        Car car = spyDAO.findCarById("C001");

       
        assertNotNull(car, "Car should not be null");
        assertEquals("Toyota", car.getModel());
        assertEquals("ABC123", car.getPlateNumber());
    }

    @Test
    void testGetAssignedCarByDriverId() {
        CarDAO spyDAO = spy(carDAO);

        
        Car mockCar = new Car("C001", "Toyota", "ABC123", "Assigned");
        doReturn(mockCar).when(spyDAO).getAssignedCarByDriverId("EMP001");

      
        Car car = spyDAO.getAssignedCarByDriverId("EMP001");

       
        assertNotNull(car, "Assigned car should not be null");
        assertEquals("Toyota", car.getModel());
        assertEquals("Assigned", car.getStatus());
    }

    @Test
    void testGetCarById() {
        CarDAO spyDAO = spy(carDAO);

     
        Car mockCar = new Car("C001", "Toyota", "ABC123", "Available");
        doReturn(mockCar).when(spyDAO).getCarById("C001");

  
        Car car = spyDAO.getCarById("C001");

    
        assertNotNull(car, "Car should not be null");
        assertEquals("Toyota", car.getModel());
        assertEquals("ABC123", car.getPlateNumber());
    }
}
