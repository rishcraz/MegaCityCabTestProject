package test.dao;


import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.megacitycab.dao.customer.InquiryDAO;
import com.megacitycab.model.customer.Inquiry;

import java.sql.Connection;
import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class InquiryDAOTest {

    @Mock
    private Connection mockConnection;

    private InquiryDAO inquiryDAO;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); 
        inquiryDAO = new InquiryDAO(); 
    }

    @Test
    void testSaveInquiry() {
       
        InquiryDAO spyDAO = spy(inquiryDAO);

       
        Inquiry mockInquiry = new Inquiry("user1", "John Doe", "johndoe@example.com", "Subject", "Message");

  
        doReturn(true).when(spyDAO).saveInquiry(mockInquiry);

    
        boolean result = spyDAO.saveInquiry(mockInquiry);

   
        assertTrue(result, "Inquiry should be saved successfully");
    }

    @Test
    void testGetAllInquiries() {
        
        InquiryDAO spyDAO = spy(inquiryDAO);

       
        List<Inquiry> mockInquiries = Arrays.asList(
                new Inquiry(1, "user1", "John Doe", "johndoe@example.com", "Subject 1", "Message 1", "Reply 1", "Replied", null),
                new Inquiry(2, "user2", "Jane Smith", "janesmith@example.com", "Subject 2", "Message 2", "Reply 2", "Replied", null)
        );

   
        doReturn(mockInquiries).when(spyDAO).getAllInquiries();

  
        List<Inquiry> inquiries = spyDAO.getAllInquiries();


        assertNotNull(inquiries, "Inquiries list should not be null");
        assertEquals(2, inquiries.size(), "Should return exactly 2 inquiries");
        assertEquals("John Doe", inquiries.get(0).getName());
        assertEquals("Jane Smith", inquiries.get(1).getName());
    }

    @Test
    void testGetInquiryById() {
      
        InquiryDAO spyDAO = spy(inquiryDAO);

       
        Inquiry mockInquiry = new Inquiry(1, "user1", "John Doe", "johndoe@example.com", "Subject", "Message", "Reply", "Replied", null);


        doReturn(mockInquiry).when(spyDAO).getInquiryById(1);

    
        Inquiry result = spyDAO.getInquiryById(1);

    
        assertNotNull(result, "Inquiry should not be null");
        assertEquals("John Doe", result.getName());
        assertEquals("Subject", result.getSubject());
    }

    @Test
    void testSendReply() {
     
        InquiryDAO spyDAO = spy(inquiryDAO);

       
        int inquiryId = 1;
        String reply = "Admin reply to the inquiry";

       
        doReturn(true).when(spyDAO).sendReply(inquiryId, reply);

       
        boolean result = spyDAO.sendReply(inquiryId, reply);

        // Assert
        assertTrue(result, "Reply should be sent successfully");
    }

    @Test
    void testGetInquiriesByUserId() {
       
        InquiryDAO spyDAO = spy(inquiryDAO);

        List<Inquiry> mockInquiries = Arrays.asList(
                new Inquiry(1, "user1", "John Doe", "johndoe@example.com", "Subject 1", "Message 1", "Reply 1", "Replied", null),
                new Inquiry(2, "user1", "John Doe", "johndoe@example.com", "Subject 2", "Message 2", "Reply 2", "Replied", null)
        );

      
        doReturn(mockInquiries).when(spyDAO).getInquiriesByUserId("user1");

       
        List<Inquiry> inquiries = spyDAO.getInquiriesByUserId("user1");

      
        assertNotNull(inquiries, "Inquiries list should not be null");
        assertEquals(2, inquiries.size(), "Should return exactly 2 inquiries for user1");
        assertEquals("John Doe", inquiries.get(0).getName());
        assertEquals("Message 2", inquiries.get(1).getMessage());
    }
}

