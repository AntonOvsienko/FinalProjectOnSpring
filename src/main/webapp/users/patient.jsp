<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<body>

<h1 align="center">Hello Patient</h1>
<form action="/controller" method="post">
    <input name="command" value="updateStaff" hidden>
    <p align="center">Номер паспорта: <input name="passport" type="text" required><span></span> - поле обязательно</p>
    <p align="center">Имя: <input type="text" name="name" required><span></span> - поле обязательно</p>
    <p align="center">Фамилия: <input type="text" name="surname" required><span> - поле обязательно</span></p>
    <p align="center">Дата рождения:<input type="date" id="date" name="date"/></p>
    <p align="center">Контактный номер: <input type="text" name="telephone"><span></span></p>
    <p align="center"><input type="submit" value="Создать"></p>
</form>
</body>
</html>