<%@ page import="com.ua.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
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
<%--<p align="center" id="createLogin"><input type="submit" onclick="showForm()" value="Создать логин"></p>--%>
<form id="createLogin" action="controller" method="get">
    <input name="command" value="checkNewLogin" hidden>
    <p align="center"><input type="submit" value="Добавить сотрудника"></p>
</form>
<form id="viewLogin" action="controller" method="post">
    <input name="command" value="viewStaff" hidden>
    <p align="center"><input type="submit" value="Посмотреть сотрудников"></p>
</form>
<form id="viewLogin" action="controller" method="get">
    <input name="command" value="addNewPatient" hidden>
    <p align="center"><input type="submit" value="Добавить пациентов"></p>
</form>
<form action="controller" method="get">
    <input name="command" value="exit" hidden>
    <p align="center"><input type="submit" value="Закончить сессию"></p>
</form>

</body>
</html>