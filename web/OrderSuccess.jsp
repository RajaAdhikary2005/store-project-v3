<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Store - Order Success</title>
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
    <h2>Order Status</h2>

    <%
        String msg = (String) request.getAttribute("msg");
        String cname = (String) request.getAttribute("custName");
        String pcode = (String) request.getAttribute("prodCode");
        Integer pqty = (Integer) request.getAttribute("prodQty");
    %>

    <p><b><%= msg %></b></p>

    <% if (msg != null && msg.contains("successfully")) { %>
        <p>Thank you, <b><%= cname %></b>!</p>
        <p>Quantity: <%= pqty %></p>
        <br>
        <a href="Home.jsp">Go back to Home</a>
    <% } else { %>
        <br>
        <a href="OrderForm.jsp">Try again</a>
    <% } %>

</div>

</body>
</html>
