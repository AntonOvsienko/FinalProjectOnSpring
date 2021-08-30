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
    <script>

    </script>
</head>
<body>
<form action="controller" method="post">
    <input name="command" value="updateStaff" hidden>
    <p align="center">Номер паспорта: <input name="passport" type="text" required><span></span> - поле обязательно</p>
    <p align="center">Имя: <input type="text" name="name" required><span></span> - поле обязательно</p>
    <p align="center">Фамилия: <input type="text" name="surname" required><span> - поле обязательно</span></p>
    <p align="center">Возраст: <input type="number" name="age" size="5"><span></span></p>
    <p align="center"><b>Ваш пол?</b></p>
    <p align="center"><input name="gender" type="radio" value="men">M
        <input name="gender" type="radio" value="women">Ж</p>
    <c:if test="${role} == 'doctor'">
    <p align="center"><label>Направление:<select name="department">
        <option value="Pediatric">Pediatric</option>
        <option value="Surgeon">Surgeon</option>
        <option value="Therapist">Therapist</option>
        <option value="Traumatologist">Traumatologist</option>
    </select></label></p>
    </c:if>
    <p align="center"><input type="submit" value="Обновить"></p>
</form>
</body>
</html>
