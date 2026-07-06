<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Store - Home</title>
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
    <h2>Welcome to Our Store!</h2>
    <p>We sell the following products:</p>
    <ul>
        <%
            java.sql.Connection con = null;
            java.sql.Statement stmt = null;
            java.sql.ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/store_db?useSSL=false", "store", "store234");
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT name FROM product_list");
                while(rs.next()){
        %>
                    <li><%= rs.getString("name") %></li>
        <%
                }
            } catch(Exception e) {
                out.println("<li>Error loading products</li>");
            } finally {
                if (rs != null) try { rs.close(); } catch(Exception e){}
                if (stmt != null) try { stmt.close(); } catch(Exception e){}
                if (con != null) try { con.close(); } catch(Exception e){}
            }
        %>
    </ul>
</div>

</body>
</html>
