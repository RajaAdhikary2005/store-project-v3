<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Store - Products</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<!-- Link Division (Navigation) -->
<div class="linkDiv">
    <a href="Home.jsp">Home</a>
    <a href="Products.jsp">Products</a>
    <a href="OrderForm.jsp">Order Form</a>
    <a href="ViewOrdersServlet">All Orders</a>
</div>

<!-- Content Division -->
<div class="contentDiv">
    <h2>Product List</h2>

    <%
        java.sql.Connection con = null;
        java.sql.Statement stmt = null;
        java.sql.ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/store_db?useSSL=false", "store", "store234");
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT name, price, quantity FROM product_list");

            boolean hasProducts = false;
    %>
    <table class="prodTable" style="margin-bottom: 20px;">
        <tr>
            <th>Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Actions</th>
        </tr>
        <%
            while (rs.next()) {
                hasProducts = true;
                String pName = rs.getString("name");
                String pPrice = rs.getString("price");
                String pQty = rs.getString("quantity");
        %>
        <tr>
            <td><%= pName %></td>
            <td><%= pPrice %></td>
            <td>
                <!-- Update Quantity Form -->
                <form action="ProductServlet" method="POST" style="display:inline;">
                    <input type="hidden" name="action" value="updateQty">
                    <input type="hidden" name="prodName" value="<%= pName %>">
                    <input type="number" name="newQty" value="<%= pQty %>" style="width: 50px;" required>
                    <input type="submit" value="Update">
                </form>
            </td>
            <td>
                <!-- Delete Form -->
                <form action="ProductServlet" method="POST" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="prodName" value="<%= pName %>">
                    <input type="submit" value="Delete" class="deleteBtn" onclick="return confirm('Are you sure you want to delete this product?');">
                </form>
            </td>
        </tr>
        <%
            } // end while
        %>
    </table>
    <%
            if (!hasProducts) {
                out.println("<p>No products found.</p>");
            }
        } catch (Exception e) {
            out.println("<p class='errMsg'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
    %>

    <hr style="margin-top: 30px; margin-bottom: 20px;">
    
    <!-- Add Product Form -->
    <h3>Add New Product</h3>
    <form action="ProductServlet" method="POST">
        <input type="hidden" name="action" value="add">
        <table style="text-align: left;">
            <tr>
                <td>Name:</td>
                <td><input type="text" name="prodName" required></td>
            </tr>
            <tr>
                <td>Price:</td>
                <td><input type="number" name="prodPrice" required></td>
            </tr>
            <tr>
                <td>Quantity:</td>
                <td><input type="number" name="prodQty" required></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <input type="submit" value="Add Product" style="margin-top: 10px;">
                </td>
            </tr>
        </table>
    </form>

</div>

</body>
</html>
