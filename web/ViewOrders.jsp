<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>All Orders</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

    <div class="linkDiv">
        <a href="Home.jsp">Home</a>
        <a href="Products.jsp">Products</a>
        <a href="OrderForm.jsp">Order Form</a>
        <a href="ViewOrdersServlet">All Orders</a>
    </div>

    <div class="contentDiv">
        <h2>All Orders</h2>

        <%
            String errMsg = (String) request.getAttribute("errMsg");
            if (errMsg != null) {
        %>
            <p class="errMsg">Error: <%= errMsg %></p>
        <%
            }
        %>

        <%
            List<String[]> orderList = (List<String[]>) request.getAttribute("orderList");
            if (orderList != null && !orderList.isEmpty()) {
        %>

        <table class="prodTable">
            <tr>
                <th>Customer Name</th>
                <th>Customer Address</th>
                <th>Product Name</th>
                <th>Quantity</th>
            </tr>
            <%
                for (String[] row : orderList) {
            %>
            <tr>
                <td><%= row[0] %></td>
                <td><%= row[1] %></td>
                <td><%= row[2] %></td>
                <td><%= row[3] %></td>
            </tr>
            <%
                }
            %>
        </table>

        <%
            } else if (errMsg == null) {
        %>
            <p>No orders found.</p>
        <%
            }
        %>

    </div>
</body>
</html>
