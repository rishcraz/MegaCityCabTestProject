package test.dao;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.megacitycab.dao.admin.FareRateDAO;
import com.megacitycab.model.admin.FareRate;

import java.sql.Connection;
import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class FareRateDAOTest {

    @Mock
    private Connection mockConnection;

    private FareRateDAO fareRateDAO;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); 
        fareRateDAO = new FareRateDAO(); 
    }

    @Test
    void testGetAllFareRates() {
       
        FareRateDAO spyDAO = spy(fareRateDAO);

       
        List<FareRate> mockFareRates = Arrays.asList(
                new FareRate(1, "Standard", 100, 10, true, 1.5, true, 0.18, 5),
                new FareRate(2, "Luxury", 200, 20, false, 1.0, true, 0.2, 10)
        );

       
        doReturn(mockFareRates).when(spyDAO).getAllFareRates();

       
        List<FareRate> fareRates = spyDAO.getAllFareRates();

      
        assertNotNull(fareRates, "Fare rates list should not be null");
        assertEquals(2, fareRates.size(), "Should return exactly 2 fare rates");
        assertEquals("Standard", fareRates.get(0).getCarType());
        assertEquals(200, fareRates.get(1).getBaseFare());
    }

    @Test
    void testGetFareRateById() {
        FareRateDAO spyDAO = spy(fareRateDAO);

        FareRate mockFareRate = new FareRate(1, "Standard", 100, 10, true, 1.5, true, 0.18, 5);

        doReturn(mockFareRate).when(spyDAO).getFareRateById(1);

        FareRate result = spyDAO.getFareRateById(1);

        assertNotNull(result, "Fare rate should not be null");
        assertEquals("Standard", result.getCarType());
        assertEquals(100, result.getBaseFare());
    }
}
