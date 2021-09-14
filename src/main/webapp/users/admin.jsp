<%@ page session="true"%>
<%@ page import="com.ua.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- rest of the page --%>

<html>
<head>
    <style>
        body {
            font-family: 'Open Sans', Arial, sans-serif;
            font-size: 1em;
            background: #ebebeb;
            /*background-size: 100%;*/
        }
    </style>
    <script>

        function showForm() {
            if (document.getElementById("auth").hidden == false) {
                document.getElementById("auth").hidden = true;
            } else {
                document.getElementById("auth").hidden = false;
            }
        }

    </script>
</head>
<body>

<h1 align="center">Hello Admin</h1>
<form id="viewLogin" action="/controller" method="post">
    <input name="command" value="viewStaff" hidden>
    <p align="center"><input type="submit" value="Взаимодействие с персоналом"></p>
</form>
<form action="/controller" method="get">
    <input name="command" value="exit" hidden>
    <p align="center"><input type="submit" value="Закончить сессию"></p>
</form>

</body>
</html>