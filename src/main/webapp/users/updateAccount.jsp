<%--
  Created by IntelliJ IDEA.
  User: ARTDoor
  Date: 26.08.2021
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<form action="controller" method="get">
    <p>Пожалуйста, заполните обязательные поля.</p>
    <p>Имя: <input type="text" required><span></span></p>
    <p>Возраст: <input type="number" size="3"><span></span></p>
    <p>E-mail: <input type="email" required><span></span></p>
    <p>Сайт: <input type="url"><span></span></p>
    <p><input type="submit" value="Отправить"></p>
    <p><b>Ваш пол?</b></p>
    <p><input name="gender" type="radio" value="men">M</p>
    <p><input name="gender" type="radio" value="women">Ж</p>
    <p><input type="submit" value="Выбрать"></p>
</form>
</body>
</html>
