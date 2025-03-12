package test.controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import com.megacitycab.controller.admin.AddCarServlet;
import com.megacitycab.dao.admin.CarDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;
import java.lang.reflect.Method;

import static org.mockito.Mockito.*;

class AddCarServletTest {

    @InjectMocks
    private AddCarServlet addCarServlet;

    @Mock
    private CarDAO carDAO;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private HttpSession session;

    @Mock
    private RequestDispatcher requestDispatcher;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testAddCar_Success() throws Exception {
        when(request.getParameter("model")).thenReturn("Toyota");
        when(request.getParameter("plateNumber")).thenReturn("ABC123");
        when(request.getParameter("status")).thenReturn("Available");
        when(request.getRequestDispatcher(anyString())).thenReturn(requestDispatcher);  // Mocking dispatcher

       
        Method doPostMethod = AddCarServlet.class.getDeclaredMethod("doPost", HttpServletRequest.class, HttpServletResponse.class);
        doPostMethod.setAccessible(true);  
        doPostMethod.invoke(addCarServlet, request, response); 

     
        verify(carDAO).addCar("Toyota", "ABC123", "Available");
        verify(response).sendRedirect("CarSection.jsp");
    }

    @Test
    void testAddCar_InvalidParameters() throws Exception {
        when(request.getParameter("model")).thenReturn(null);
        when(request.getParameter("plateNumber")).thenReturn(null);
        when(request.getParameter("status")).thenReturn(null);
        when(request.getRequestDispatcher(anyString())).thenReturn(requestDispatcher);  // Mocking dispatcher

        
        Method doPostMethod = AddCarServlet.class.getDeclaredMethod("doPost", HttpServletRequest.class, HttpServletResponse.class);
        doPostMethod.setAccessible(true);  
        doPostMethod.invoke(addCarServlet, request, response); 


        
        verify(request).setAttribute(eq("error"), eq("Invalid car details!"));
        verify(requestDispatcher).forward(request, response);
    }

    @Test
    void testAddCar_Failure() throws Exception {
       
        doThrow(new RuntimeException("Database error")).when(carDAO).addCar(anyString(), anyString(), anyString());

        when(request.getParameter("model")).thenReturn("Toyota");
        when(request.getParameter("plateNumber")).thenReturn("ABC123");
        when(request.getParameter("status")).thenReturn("Available");
        when(request.getRequestDispatcher(anyString())).thenReturn(requestDispatcher);  // Mocking dispatcher

        
        Method doPostMethod = AddCarServlet.class.getDeclaredMethod("doPost", HttpServletRequest.class, HttpServletResponse.class);
        doPostMethod.setAccessible(true);  
        doPostMethod.invoke(addCarServlet, request, response);  

       
        verify(request).setAttribute(eq("error"), eq("Failed to add car!"));
        verify(requestDispatcher).forward(request, response);
    }
}
