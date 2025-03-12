package test.dao;

import org.junit.jupiter.api.*;

import com.megacitycab.dao.customer.BillingDAO;
import com.megacitycab.model.customer.Billing;
import com.megacitycab.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class BillingDAOTest {

    private BillingDAO billingDAO;

    @BeforeAll
    void setUp() {
        billingDAO = new BillingDAO();
        setupTestData();
    }

    @AfterAll
    void tearDown() {
        cleanTestData();
    }

    @Test
    void testGetCompletedPayments() {
        List<Billing> payments = billingDAO.getCompletedPayments();
        assertNotNull(payments);
        assertFalse(payments.isEmpty());
        assertEquals("Paid", payments.get(0).getPaymentStatus());
    }

    @Test
    void testGetPendingBills() {
        List<Billing> pendingBills = billingDAO.getPendingBills();
        assertNotNull(pendingBills);
        assertFalse(pendingBills.isEmpty());
        assertEquals("Awaiting Manager Approval", pendingBills.get(0).getPaymentStatus());
    }

    @Test
    void testConfirmBillSuccess() {
        boolean result = billingDAO.confirmBill("TEST123");
        assertTrue(result);
        Billing updatedBill = billingDAO.getBillByOrder("TEST123");
        assertEquals("Paid", updatedBill.getPaymentStatus());
    }

    @Test
    void testConfirmBillFail() {
        boolean result = billingDAO.confirmBill("INVALID_ORDER");
        assertFalse(result);
    }

    @Test
    void testGenerateBill() {
        boolean result = billingDAO.generateBill("TEST456", 1);
        assertTrue(result);
        Billing bill = billingDAO.getBillByOrder("TEST456");
        assertNotNull(bill);
        assertEquals("Pending Payment", bill.getPaymentStatus());
    }

    @Test
    void testGetBillByOrder() {
        Billing bill = billingDAO.getBillByOrder("TEST123");
        assertNotNull(bill);
        assertEquals("TEST123", bill.getOrderNumber());
        assertEquals("John Doe", bill.getCustomerName());
    }

    @Test
    void testUpdatePaymentStatusCash() {
        boolean result = billingDAO.updatePaymentStatus("TEST123", "Cash");
        assertTrue(result);
        Billing bill = billingDAO.getBillByOrder("TEST123");
        assertEquals("Paid", bill.getPaymentStatus());
        assertEquals("Cash", bill.getPaymentMethod());
    }

    @Test
    void testUpdatePaymentStatusCard() {
        boolean result = billingDAO.updatePaymentStatus("TEST456", "Card");
        assertTrue(result);
        Billing bill = billingDAO.getBillByOrder("TEST456");
        assertEquals("Awaiting Manager Approval", bill.getPaymentStatus());
        assertEquals("Card", bill.getPaymentMethod());
    }

    private void setupTestData() {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO billing (order_number, total_fare, tax_amount, discount_amount, final_amount, payment_status, payment_method) " +
                             "VALUES ('TEST123', 100.0, 5.0, 10.0, 95.0, 'Awaiting Manager Approval', NULL), " +
                             "('TEST124', 150.0, 7.5, 15.0, 142.5, 'Paid', 'Cash')"
             )) {
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void cleanTestData() {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "DELETE FROM billing WHERE order_number IN ('TEST123', 'TEST124', 'TEST456')"
             )) {
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
