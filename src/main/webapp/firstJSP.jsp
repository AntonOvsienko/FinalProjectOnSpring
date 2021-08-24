<%--
  Created by IntelliJ IDEA.
  User: Anton
  Date: 23.08.2021
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>First JSP</title>
</head>
<body>
    <h1>Testing JSP</h1>
    <p>
        <%@ page import="java.util.Date" %>>
        <%
            Date date=new Date();
            String result = "Текущая дата : " + date;
        %>
        <%= result %>
        <%
            out.println("Hello world");
        %>
    </p>
</body>
</html>
