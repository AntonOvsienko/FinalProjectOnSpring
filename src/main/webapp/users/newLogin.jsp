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
    <style>
        table {
            text-align: center;
            border: 1px
        }
    </style>
    <script type="text/javascript">
        function setCursorPosition(pos, e) {
            e.focus();
            if (e.setSelectionRange) e.setSelectionRange(pos, pos);
            else if (e.createTextRange) {
                var range = e.createTextRange();
                range.collapse(true);
                range.moveEnd("character", pos);
                range.moveStart("character", pos);
                range.select()
            }
        }

        function mask(e) {
            //console.log('mask',e);
            var matrix = this.placeholder,// .defaultValue
                i = 0,
                def = matrix.replace(/\D/g, ""),
                val = this.value.replace(/\D/g, "");
            def.length >= val.length && (val = def);
            matrix = matrix.replace(/[_\d]/g, function (a) {
                return val.charAt(i++) || "_"
            });
            this.value = matrix;
            i = matrix.lastIndexOf(val.substr(-1));
            i < matrix.length && matrix != this.placeholder ? i++ : i = matrix.indexOf("_");
            setCursorPosition(i, this)
        }

        window.addEventListener("DOMContentLoaded", function () {
            var input = document.querySelector("#online_phone");
            input.addEventListener("input", mask, false);
            input.focus();
            setCursorPosition(3, input);
        });
    </script>
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
                <input name="password_repeat" type="password" value="${password_repeat}" required disabled></label>
            </p>
        </c:when>
        <c:otherwise>
            <table border="5%" width="45%" cellpadding="5">
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
            </table>
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
        <h4 style="color:red" name="error" align="center" color="#ff0000" c>Login is already taken</h4>
        <hr align="center" width="400" size="2" color="#ff0000"/>
    </c:if>

</form>

<c:if test="${checkLogin == 'true'}">
    <form action="/controller" method="post">
        <input name="login" value="${login}" hidden>
        <input name="password" value="${password}" hidden>
        <input name="role" value="${role}" hidden>
        <input name="command" value="createNewLogin" hidden>
        <p align="center">Номер паспорта: <input name="passport" placeholder="AH0000000"
                                                 pattern="[А-Яа-яЁё]{2,2}\d{7,7}" type="text" required></p>
        <p align="center">Имя: <input type="text" name="name" placeholder="Вася или Vasya"
                                      pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required></p>
        <p align="center">Фамилия: <input type="text" name="surname" placeholder="Левчий или Levchiy"
                                          pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required></p>
        <p align="center">Телефон: <input id="online_phone" name="phone" type="tel" maxlength="50"
                                          autofocus="autofocus" value="+3(___)___-__-__"
                                          pattern="\+3\s?[\(]{0,1}9[0-9]{2}[\)]{0,1}\s?\d{3}[-]{0,1}\d{2}[-]{0,1}\d{2}"
                                          placeholder="+3(___)___-__-__"
                                          name="telephone"></p>
        <c:if test="${role == 'doctor'}">
            <p align="center"><label>Направление:<select name="department">
                <option value="Педиатр">Педиатр</option>
                <option value="Хирург">Хирург</option>
                <option value="Терапевт">Терапевт</option>
                <option value="Травматолог">Травматолог</option>
            </select></label></p>
        </c:if>
        <p align="center"><input type="submit" value="Создать"></p>
    </form>
</c:if>
<c:if test="${error != null}">
    <h4 style="color:red" name="error" align="center" color="#ff0000" c>${error}</h4>
</c:if>
<c:if test="${successfully != null}">
    <h4 style="color:green" name="error" align="center" color="#ff0000" c>${successfully}</h4>
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
