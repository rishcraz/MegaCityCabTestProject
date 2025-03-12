/*
 * package test.controller;
 * 
 * import model.User; import org.junit.jupiter.api.BeforeEach; import
 * org.junit.jupiter.api.Test; import org.mockito.*;
 * 
 * import controller.LoginServlet; import dao.UserDAO;
 * 
 * import javax.servlet.RequestDispatcher; import javax.servlet.http.*;
 * 
 * import java.io.PrintWriter; import java.io.StringWriter;
 * 
 * import static org.mockito.Mockito.*;
 * 
 * class LoginServletTest {
 * 
 * @InjectMocks private LoginServlet loginServlet;
 * 
 * @Mock private UserDAO userDAO;
 * 
 * @Mock private HttpServletRequest request;
 * 
 * @Mock private HttpServletResponse response;
 * 
 * @Mock private HttpSession session;
 * 
 * @Mock private RequestDispatcher requestDispatcher;
 * 
 * @BeforeEach void setUp() { MockitoAnnotations.openMocks(this); }
 * 
 * @Test void testAdminLogin_Success() throws Exception {
 * when(request.getParameter("email")).thenReturn("admin@megacitycab.com");
 * when(request.getParameter("password")).thenReturn("4321");
 * when(request.getSession()).thenReturn(session);
 * 
 * loginServlet.doPost(request, response);
 * 
 * verify(session).setAttribute("adminId", "EMP001");
 * verify(response).sendRedirect(contains("/admin/AdminDashboard.jsp")); }
 * 
 * @Test void testCustomerLogin_Success() throws Exception { User mockUser = new
 * User("USR001", "John Doe", "john@megacitycab.com", "1234567890",
 * "123456789V", "123 Street", "password"); mockUser.setRole("Customer");
 * 
 * when(request.getParameter("email")).thenReturn("john@megacitycab.com");
 * when(request.getParameter("password")).thenReturn("password");
 * when(request.getSession()).thenReturn(session);
 * when(userDAO.loginUser(anyString(), anyString())).thenReturn(mockUser);
 * 
 * loginServlet.doPost(request, response);
 * 
 * verify(session).setAttribute("user", mockUser);
 * verify(response).sendRedirect(contains("/customer/CustomerDashboard.jsp")); }
 * 
 * @Test void testLogin_InvalidCredentials() throws Exception {
 * when(request.getParameter("email")).thenReturn("wrong@megacitycab.com");
 * when(request.getParameter("password")).thenReturn("wrongpass");
 * when(userDAO.loginUser(anyString(), anyString())).thenReturn(null);
 * when(request.getRequestDispatcher("login.jsp")).thenReturn(requestDispatcher)
 * ;
 * 
 * loginServlet.doPost(request, response);
 * 
 * verify(request).setAttribute(eq("error"), eq("Invalid credentials!"));
 * verify(requestDispatcher).forward(request, response); } }
 */
package test.controller;

