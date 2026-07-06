import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ViewOrdersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String url = "jdbc:mysql://localhost:3306/store_db?useSSL=false";
        String user = "store";
        String pass = "store234";

        List<String[]> orderList = new ArrayList<>();
        String errMsg = null;

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);

            stmt = con.createStatement();
            String sql = "SELECT cust_name, cust_addr, prod_name, prod_qty FROM orders";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                String[] row = new String[4];
                row[0] = rs.getString("cust_name");
                row[1] = rs.getString("cust_addr");
                row[2] = rs.getString("prod_name");
                row[3] = String.valueOf(rs.getInt("prod_qty"));
                orderList.add(row);
            }

        } catch (Exception e) {
            errMsg = e.getMessage();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }

        req.setAttribute("orderList", orderList);
        req.setAttribute("errMsg", errMsg);

        RequestDispatcher rd = req.getRequestDispatcher("ViewOrders.jsp");
        rd.forward(req, res);
    }
}
