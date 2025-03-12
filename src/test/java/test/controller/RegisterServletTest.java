/*
 * package test.controller;
 * 
 * import dao.UserDAO; import model.User; import
 * org.junit.jupiter.api.BeforeEach; import org.junit.jupiter.api.Test; import
 * org.mockito.*;
 * 
 * import controller.RegisterServlet;
 * 
 * import javax.servlet.RequestDispatcher; import javax.servlet.http.*;
 * 
 * import static org.mockito.Mockito.*;
 * 
 * class RegisterServletTest {
 * 
 * @InjectMocks private RegisterServlet registerServlet;
 * 
 * @Mock private HttpServletRequest request;
 * 
 * @Mock private HttpServletResponse response;
 * 
 * @Mock private UserDAO userDAO;
 * 
 * @Mock private RequestDispatcher requestDispatcher;
 * 
 * @BeforeEach void setUp() { MockitoAnnotations.openMocks(this); }
 * 
 * @Test void testRegisterUser_PasswordMismatch() throws Exception {
 * when(request.getParameter("password")).thenReturn("password123");
 * when(request.getParameter("confirmPassword")).thenReturn("differentPass");
 * when(request.getRequestDispatcher("register.jsp")).thenReturn(
 * requestDispatcher);
 * 
 * registerServlet.doPost(request, response);
 * 
 * verify(request).setAttribute(eq("error"), eq("Passwords do not match!"));
 * verify(requestDispatcher).forward(request, response); } }
 */
package test.controller;

