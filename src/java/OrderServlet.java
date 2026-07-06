import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class OrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // get form data
        String name = req.getParameter("custName");
        String addr = req.getParameter("custAddr");
        String prodName = req.getParameter("prodName");
        int qty = Integer.parseInt(req.getParameter("prodQty"));

        // DB info
        String url = "jdbc:mysql://localhost:3306/store_db?useSSL=false";
        String user = "store";
        String pass = "store234";

        String msg = "";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // load driver
            Class.forName("com.mysql.jdbc.Driver");

            // connect
            con = DriverManager.getConnection(url, user, pass);

            // insert order
            String sql = "INSERT INTO orders (cust_name, cust_addr, prod_name, prod_qty) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, addr);
            ps.setString(3, prodName);
            ps.setInt(4, qty);
            ps.executeUpdate();

            msg = "Order placed successfully!";

        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        } finally {
            // close all
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }

        // send message to JSP
        req.setAttribute("msg", msg);
        req.setAttribute("custName", name);
        req.setAttribute("prodName", prodName);
        req.setAttribute("prodQty", qty);

        // forward to success page
        RequestDispatcher rd = req.getRequestDispatcher("OrderSuccess.jsp");
        rd.forward(req, res);
    }
}
