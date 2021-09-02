<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ARTDoor
  Date: 31.08.2021
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="auth" action="/controller" method="post">
    <c:if test="${checkLogin == 'true'}">
        <hr align="center" width="400" size="2" color="#00ff00"/>
    </c:if>
    <c:if test="${checkLogin == 'false'}">
        <hr align="center" width="400" size="2" color="#ff0000"/>
    </c:if>
    <input name="command" value="checkNewLogin" hidden>
    <c:choose>
        <c:when test="${checkLogin == 'true'}">
            <p align="center"><label>Логин:
                <input name="login" value="${login}" required disabled></label></p>
            <p align="center"><label>Пароль:
                <input name="password" type="password" value="${password}" required disabled></label></p>
            <p align="center"><label>Повторить пароль:
                <input name="password_repeat" type="password" value="${password_repeat}" required disabled></label></p>
        </c:when>
        <c:otherwise>
            <p align="center"><label>Логин:
                <input name="login" required></label></p>
            <p align="center"><label>Пароль:
                <input name="password" type="password" required></label></p>
            <p align="center"><label>Повторить пароль:
                <input name="password_repeat" type="password" required></label></p>
            <p align="center"><label>Должность:<select name="role">
                <option disabled>Select position</option>
                <option value="doctor">doctor</option>
                <option value="nurse">nurse</option>
            </select></label></p>
        </c:otherwise>
    </c:choose>
    <c:if test="${checkLogin == 'true'}">
        <hr align="center" width="400" size="2" color="#00ff00"/>
    </c:if>
    <p align="center">
        <c:if test="${checkLogin != 'true'}">
        <input type="submit" value="Проверить">
        </c:if>
    </p>
    <c:if test="${checkLogin == 'false'}">
        <h4 name="error" align="center" color="#ff0000" c>Login is already taken</h4>
        <hr align="center" width="400" size="2" color="#ff0000"/>
    </c:if>

</form>

<c:if test="${checkLogin == 'true'}">
    <form action="/controller" method="post">
        <input name="login" value="${login}" hidden>
        <input name="password" value="${password}" hidden>
        <input name="role" value="${role}" hidden>
        <input name="command" value="createNewLogin" hidden>
        <p align="center">Номер паспорта: <input name="passport" type="text" required><span></span> - поле обязательно
        </p>
        <p align="center">Имя: <input type="text" name="name" required><span></span> - поле обязательно</p>
        <p align="center">Фамилия: <input type="text" name="surname" required><span> - поле обязательно</span></p>
        <p align="center">Телефон: <input type="text" name="telephone"><span></span></p>
        <c:if test="${role == 'doctor'}">
            <p align="center"><label>Направление:<select name="department">
                <option value="Pediatric">Pediatric</option>
                <option value="Surgeon">Surgeon</option>
                <option value="Therapist">Therapist</option>
                <option value="Traumatologist">Traumatologist</option>
            </select></label></p>
        </c:if>
        <p align="center"><input type="submit" value="Создать"></p>
    </form>
</c:if>
<c:if test="${error != null}">
    <h4 name="error" align="center" color="#ff0000" c>${error}</h4>
</c:if>
<c:if test="${successfully != null}">
    <h4 name="error" align="center" color="#ff0000" c>${successfully}</h4>
</c:if>
<form id="auth" action="/controller" method="get">
    <p align="center">
    <input name="command" value="redirect" hidden>
    <input name="address" value="users/admin.jsp" hidden>
    <input type="submit" value="Назад">
    </p>
</form>
</body>
</html>
