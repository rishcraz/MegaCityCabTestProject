package controller.customer;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import dao.customer.BillingDAO;
import model.customer.Billing;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/customer/DownloadBillServlet")
public class DownloadBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderNumber = request.getParameter("orderNumber");
        BillingDAO billingDAO = new BillingDAO();
        Billing bill = billingDAO.getBillByOrder(orderNumber);

        if (bill == null || !"Paid".equals(bill.getPaymentStatus())) {
            response.sendRedirect("billing.jsp?error=Bill not available for download");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Invoice_" + orderNumber + ".pdf");

        try (OutputStream out = response.getOutputStream()) {
            Document document = new Document(PageSize.A4, 50, 50, 50, 50);
            PdfWriter.getInstance(document, out);
            document.open();

         
            addCompanyHeader(document);

          
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD, BaseColor.BLACK);
            Paragraph title = new Paragraph("TAX INVOICE", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(new Paragraph("\n"));

      
            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            table.setSpacingAfter(10f);

            addTableHeader(table, "Invoice Number", bill.getOrderNumber());
            addTableHeader(table, "Customer Name", bill.getCustomerName());
            addTableHeader(table, "Pickup Location", bill.getPickupLocation());
            addTableHeader(table, "Destination", bill.getDestination());
            addTableHeader(table, "Total Fare", "$" + bill.getTotalFare());
            addTableHeader(table, "Tax Amount", "$" + bill.getTaxAmount());
            addTableHeader(table, "Discount", "-$" + bill.getDiscountAmount());
            addTableHeader(table, "Grand Total", "$" + bill.getFinalAmount());
            addTableHeader(table, "Payment Method", bill.getPaymentMethod());
            addTableHeader(table, "Payment Status", bill.getPaymentStatus());

            document.add(table);
            document.add(new Paragraph("\n"));

       
            addFooter(document);

            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }

    private void addCompanyHeader(Document document) throws DocumentException {
        Paragraph companyName = new Paragraph();
        
       
        Font megaFont = new Font(Font.FontFamily.HELVETICA, 28, Font.BOLD, BaseColor.BLACK);
        Font cityFont = new Font(Font.FontFamily.HELVETICA, 28, Font.BOLD, BaseColor.YELLOW);
        Font cabFont = new Font(Font.FontFamily.HELVETICA, 28, Font.BOLD, BaseColor.BLACK);

        companyName.add(new Chunk("Mega", megaFont));
        companyName.add(new Chunk("City", cityFont)); 
        companyName.add(new Chunk("Cab", cabFont));

        companyName.setAlignment(Element.ALIGN_CENTER);
        document.add(companyName);

        Paragraph companyDetails = new Paragraph(
            "123 Colombo,Lucky/Street, NY\nPhone: +066-2231247\nEmail: support@megacitycab.com\n\n",
            new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, BaseColor.GRAY)
        );
        companyDetails.setAlignment(Element.ALIGN_CENTER);
        document.add(companyDetails);
    }

   
    private void addTableHeader(PdfPTable table, String key, String value) {
        PdfPCell headerCell = new PdfPCell(new Phrase(key, new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.WHITE)));
        headerCell.setBackgroundColor(new BaseColor(44, 62, 80)); 
        headerCell.setPadding(8);
        table.addCell(headerCell);

        PdfPCell valueCell = new PdfPCell(new Phrase(value));
        valueCell.setPadding(8);
        table.addCell(valueCell);
    }

    
    private void addFooter(Document document) throws DocumentException {
        Font footerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC, BaseColor.GRAY);
        Paragraph footer = new Paragraph("\nThank you for riding with MegaCityCab!\nFor support, contact us at support@megacitycab.com", footerFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        document.add(footer);
    }
}
