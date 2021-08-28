<%--
  Created by IntelliJ IDEA.
  User: ARTDoor
  Date: 26.08.2021
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Title</title>
    <%--    <style>--%>
    <%--        input:valid + span:after {--%>
    <%--            content: url(images/ok.png);--%>
    <%--            padding-left: 5px;--%>
    <%--        }--%>
    <%--        input:invalid + span:after {--%>
    <%--            content: url(images/nook.png);--%>
    <%--            padding-left: 5px;--%>
    <%--        }--%>
    <%--        input[type="number"] {--%>
    <%--            margin-right: -3px;--%>
    <%--        }--%>
    <%--    </style>--%>
</head>
<body>
<form action="controller" method="post">
    <input name="command" value="updateStaff" hidden>
    <p>Номер паспорта: <input name="passport" type="text" required><span></span> - поле обязательно</p>
    <p>Имя: <input type="text" name="name" required><span></span> - поле обязательно</p>
    <p>Фамилия: <input type="text" name="surname" required><span> - поле обязательно</span></p>
    <p>Возраст: <input type="number" name="age" size="5"><span></span></p>
    <p><b>Ваш пол?</b></p>
    <p><input name="gender" type="radio" value="men">M
        <input name="gender" type="radio" value="women">Ж</p>
    <p><input type="submit" value="Обновить"></p>
</form>
</body>
</html>
