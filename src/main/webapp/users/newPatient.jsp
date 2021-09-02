<%--
  Created by IntelliJ IDEA.
  User: ARTDoor
  Date: 31.08.2021
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/controller" method="post">
    <input name="command" value="addNewPatient" hidden>
    <p align="center">Номер паспорта: <input name="passport" type="text" required><span></span> - поле обязательно</p>
    <p align="center">Имя: <input type="text" name="name" required><span></span> - поле обязательно</p>
    <p align="center">Фамилия: <input type="text" name="surname" required><span> - поле обязательно</span></p>
    <p align="center">Дата рождения:<input type="date" name="date"/></p>
    <p align="center">Контактный номер: <input type="text" name="telephone" required><span> - поле обязательно</span></p>
    <p align="center"><input type="submit" value="Создать"></p>
</form>
</body>
</html>
