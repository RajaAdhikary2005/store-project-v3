<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Store - Order Form</title>
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
    <h2>Order Form</h2>

    <form class="orderForm" method="post" action="OrderServlet">

        <label>Name:</label>
        <input type="text" name="custName" required>

        <label>Address:</label>
        <input type="text" name="custAddr" required>

        <label>Product Name:</label>
        <select name="prodName" required>
            <option value="">-- Select Product --</option>
            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/store_db?useSSL=false", "store", "store234");
                    stmt = con.createStatement();
                    rs = stmt.executeQuery("SELECT name, price FROM product_list");
                    while(rs.next()){
            %>
                        <option value="<%= rs.getString("name") %>">
                            <%= rs.getString("name") %> - Rs. <%= rs.getString("price") %>
                        </option>
            <%
                    }
                } catch(Exception e) {
                    out.println("<option value=''>Error loading products</option>");
                } finally {
                    if (rs != null) try { rs.close(); } catch(Exception e){}
                    if (stmt != null) try { stmt.close(); } catch(Exception e){}
                    if (con != null) try { con.close(); } catch(Exception e){}
                }
            %>
        </select>

        <label>Product Quantity:</label>
        <input type="number" name="prodQty" min="1" required>

        <br>
        <input type="submit" value="Submit" style="margin-top: 15px;">

    </form>
</div>

</body>
</html>
