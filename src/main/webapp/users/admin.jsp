<%@ page import="com.ua.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <script>
        function showFormPersonal() {
            if (document.getElementById("createLogin").hidden == false) {
                document.getElementById("createLogin").hidden = true;
                document.getElementById("viewLogin").hidden = true;
                document.getElementById("auth").hidden = true;
            } else {
                document.getElementById("createLogin").hidden = false;
                document.getElementById("viewLogin").hidden = false;
            }
        }

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
<p align="center"><input type="submit" onclick="showFormPersonal()" value="Работа с персоналом"></p>
<p align="center" id="createLogin" hidden><input type="submit" onclick="showForm()" value="Создать логин"></p>
<form id="viewLogin" action="controller" method="post" hidden>
    <input name="command" value="viewStaff" hidden>
    <p align="center"><input type="submit" value="Посмотреть логины"></p>
</form>

<form id="auth" action="controller" method="post" hidden>
    <hr align="center" width="400" size="2" color="#ff0000"/>
    <input name="command" value="newStaff" hidden>
    <p align="center"><label>Логин: <input name="login" value="admin" required></label></p>
    <p align="center"><label>Пароль: <input name="password" type="password" value="12345" required></label></p>
    <p align="center"><label>Повторить пароль: <input name="password_repeat" type="password" value="12345"
                                                      required></label></p>
    <p align="center"><label>Должность:<select name="role">
        <option disabled>Select position</option>
        <option value="doctor">doctor</option>
        <option value="nurse">nurse</option>
    </select></label></p>
    <p align="center"><input type="submit" value="Создать"></p>
    <hr align="center" width="400" size="2" color="#ff0000"/>
</form>
<form action="controller" method="get">
    <input name="command" value="exit" hidden>
    <p align="center"><input type="submit" value="Закончить сессию"></p>
</form>

</body>
</html>