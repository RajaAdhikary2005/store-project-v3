import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // DB info
        String url = "jdbc:mysql://localhost:3306/store_db?useSSL=false";
        String user = "store";
        String pass = "store234";

        // list to hold products
        List<String[]> prodList = new ArrayList<>();
        String errMsg = null;

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // load driver
            Class.forName("com.mysql.jdbc.Driver");

            // connect
            con = DriverManager.getConnection(url, user, pass);

            // run query
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT product_id, name, price, quantity FROM product_list");

            // read rows
            while (rs.next()) {
                String[] row = new String[4];
                row[0] = rs.getString("product_id");
                row[1] = rs.getString("name");
                row[2] = String.valueOf(rs.getInt("price"));
                row[3] = String.valueOf(rs.getInt("quantity"));
                prodList.add(row);
            }

        } catch (Exception e) {
            errMsg = e.getMessage();
        } finally {
            // close all
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }

        // send data to JSP
        req.setAttribute("prodList", prodList);
        req.setAttribute("errMsg", errMsg);

        // forward to Products.jsp
        RequestDispatcher rd = req.getRequestDispatcher("Products.jsp");
        rd.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
            
        String action = req.getParameter("action");
        String url = "jdbc:mysql://localhost:3306/store_db?useSSL=false";
        String user = "store";
        String pass = "store234";
        
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
            
            if ("add".equals(action)) {
                String name = req.getParameter("prodName");
                int price = Integer.parseInt(req.getParameter("prodPrice"));
                int qty = Integer.parseInt(req.getParameter("prodQty"));
                
                String sql = "INSERT INTO product_list (name, price, quantity) VALUES (?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setInt(2, price);
                ps.setInt(3, qty);
                ps.executeUpdate();
                
            } else if ("delete".equals(action)) {
                String name = req.getParameter("prodName");
                
                String sql = "DELETE FROM product_list WHERE name = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.executeUpdate();
                
            } else if ("updateQty".equals(action)) {
                String name = req.getParameter("prodName");
                int qty = Integer.parseInt(req.getParameter("newQty"));
                
                String sql = "UPDATE product_list SET quantity = ? WHERE name = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, qty);
                ps.setString(2, name);
                ps.executeUpdate();
            }
            
        } catch (Exception e) {
            req.setAttribute("errMsg", e.getMessage());
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
        
        // After making changes, redirect to Products.jsp to show the updated list
        res.sendRedirect("Products.jsp");
    }
}
