<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        @import url(/users/css/newLogin_blank.css);

        .selcls {
            padding: 9px;
            margin: 0px 0px 15px;
            border: solid 1px Black;
            outline: 0;
            background: #f1f1f1;
            align-content: center;
            box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 8px;
            -moz-box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 8px;
            -webkit-box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 8px;
            border-radius: 3px;
            width: 100%;
        }

    </style>
    <script type="text/javascript">

    </script>
</head>
<body>
<div class="container">
    <section id="content">
        <div class="login-page">
            <div class="form">
                <form class="login-form" id="auth" action="/controller" method="post">
                    <c:choose>
                        <c:when test="${checkLogin == 'true'}">
                            <input name="command" value="checkNewLogin" hidden/>
                            <input name="login" value="${login}" required disabled type="text"/>
                            <input name="password" type="password" value="${password}" required disabled/>
                            <input name="password_repeat" type="password" value="${password_repeat}" required disabled
                                   placeholder="repeat password"/>
                        </c:when>
                        <c:otherwise>
                            <input name="command" value="checkNewLogin" hidden/>
                            <input name="login" required type="text" placeholder="login"/>
                            <input name="password" type="password" required placeholder="password"/>
                            <input name="password_repeat" type="password" required placeholder="repeat password"/>

                            <select name="role" class="selcls">
                                <option disabled>Select position</option>
                                <option value="doctor">Доктор</option>
                                <option value="nurse">Медсестра</option>
                            </select>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${checkLogin != 'true'}">
                        <button>Checked</button>
                    </c:if>
                </form>

                <c:if test="${checkLogin == 'true'}">
                    <hr>
                    <form action="/controller" method="post">
                        <input name="login" value="${login}" hidden>
                        <input name="password" value="${password}" hidden>
                        <input name="role" value="${role}" hidden>
                        <input name="command" value="createNewLogin" hidden>
                        <p align="center"><input name="passport" placeholder="Номер паспорта: AH00000000"
                                                                 pattern="[А-Яа-яЁё]{2,2}\d{8,8}" type="text" required>
                        </p>
                        <p align="center"><input type="text" name="name" placeholder="Имя"
                                                      pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required></p>
                        <p align="center"><input type="text" name="surname" placeholder="Фамилия"
                                                          pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required></p>
                        <p align="center"><input id="online_phone" name="telephone" type="tel" maxlength="50"
                                                          pattern="[0-9]{12,12}"
                                                          placeholder="Номер телефона"
                                                          name="telephone"></p>
                        <c:if test="${role == 'doctor'}">
                            <p align="center"><select name="department" class="selcls">
                                <c:forEach items="${departments}" var="department">
                                    <option value="${department.description}">${department.description}</option>
                                </c:forEach>
                            </select></p>
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
<%--                <form id="auth" action="/controller" method="get">--%>
<%--                    <p align="center">--%>
<%--                        <input name="command" value="redirect" hidden>--%>
<%--                        <input name="address" value="users/admin.jsp" hidden>--%>
<%--                        <input type="submit" value="Назад">--%>
<%--                    </p>--%>
<%--                </form>--%>
            </div>
        </div>
    </section><!-- content -->
</div><!-- container -->
<%--<form id="auth" action="/controller" method="post">--%>
<%--    <c:if test="${checkLogin == 'true'}">--%>
<%--        <hr align="center" width="400" size="2" color="#00ff00"/>--%>
<%--    </c:if>--%>
<%--    <c:if test="${checkLogin == 'false'}">--%>
<%--        <hr align="center" width="400" size="2" color="#ff0000"/>--%>
<%--    </c:if>--%>
<%--    <input name="command" value="checkNewLogin" hidden>--%>

<%--    <c:choose>--%>
<%--        <c:when test="${checkLogin == 'true'}">--%>
<%--            <p align="center"><label>Логин:--%>
<%--                <input name="login" value="${login}" required disabled></label></p>--%>
<%--            <p align="center"><label>Пароль:--%>
<%--                <input name="password" type="password" value="${password}" required disabled></label></p>--%>
<%--            <p align="center"><label>Повторить пароль:--%>
<%--                <input name="password_repeat" type="password" value="${password_repeat}" required disabled></label>--%>
<%--            </p>--%>
<%--        </c:when>--%>
<%--        <c:otherwise>--%>
<%--                <p align="center"><label>Логин:--%>
<%--                    <input name="login" required></label></p>--%>
<%--                <p align="center"><label>Пароль:--%>
<%--                    <input name="password" type="password" required></label></p>--%>
<%--                <p align="center"><label>Повторить пароль:--%>
<%--                    <input name="password_repeat" type="password" required></label></p>--%>
<%--                <p align="center"><label>Должность:<select name="role">--%>
<%--                    <option disabled>Select position</option>--%>
<%--                    <option value="doctor">Доктор</option>--%>
<%--                    <option value="nurse">Медсестра</option>--%>
<%--                </select></label></p>--%>
<%--        </c:otherwise>--%>
<%--    </c:choose>--%>

<%--    <c:if test="${checkLogin == 'true'}">--%>
<%--        <hr align="center" width="400" size="2" color="#00ff00"/>--%>
<%--    </c:if>--%>
<%--    <p align="center">--%>
<%--        <c:if test="${checkLogin != 'true'}">--%>
<%--            <input type="submit" value="Проверить">--%>
<%--        </c:if>--%>
<%--    </p>--%>
<%--    <c:if test="${checkLogin == 'false'}">--%>
<%--        <h4 style="color:red" name="error" align="center" color="#ff0000" c>Login is already taken</h4>--%>
<%--        <hr align="center" width="400" size="2" color="#ff0000"/>--%>
<%--    </c:if>--%>

<%--</form>--%>

<%--<c:if test="${checkLogin == 'true'}">--%>
<%--    <form action="/controller" method="post">--%>
<%--        <input name="login" value="${login}" hidden>--%>
<%--        <input name="password" value="${password}" hidden>--%>
<%--        <input name="role" value="${role}" hidden>--%>
<%--        <input name="command" value="createNewLogin" hidden>--%>
<%--        <p align="center">Номер паспорта: <input name="passport" placeholder="AH0000000"--%>
<%--                                                 pattern="[А-Яа-яЁё]{2,2}\d{7,7}" type="text" required></p>--%>
<%--        <p align="center">Имя: <input type="text" name="name" placeholder="Вася или Vasya"--%>
<%--                                      pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required></p>--%>
<%--        <p align="center">Фамилия: <input type="text" name="surname" placeholder="Левчий или Levchiy"--%>
<%--                                          pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required></p>--%>
<%--        <p align="center">Телефон: <input id="online_phone" name="phone" type="tel" maxlength="50"--%>
<%--                                          autofocus="autofocus" value="+3(___)___-__-__"--%>
<%--                                          pattern="\+3\s?[\(]{0,1}9[0-9]{2}[\)]{0,1}\s?\d{3}[-]{0,1}\d{2}[-]{0,1}\d{2}"--%>
<%--                                          placeholder="+3(___)___-__-__"--%>
<%--                                          name="telephone"></p>--%>
<%--        <c:if test="${role == 'doctor'}">--%>
<%--            <p align="center"><label>Направление:<select name="department">--%>
<%--                <option value="Педиатр">Педиатр</option>--%>
<%--                <option value="Хирург">Хирург</option>--%>
<%--                <option value="Терапевт">Терапевт</option>--%>
<%--                <option value="Травматолог">Травматолог</option>--%>
<%--            </select></label></p>--%>
<%--        </c:if>--%>
<%--        <p align="center"><input type="submit" value="Создать"></p>--%>
<%--    </form>--%>
<%--</c:if>--%>
<%--<c:if test="${error != null}">--%>
<%--    <h4 style="color:red" name="error" align="center" color="#ff0000" c>${error}</h4>--%>
<%--</c:if>--%>
<%--<c:if test="${successfully != null}">--%>
<%--    <h4 style="color:green" name="error" align="center" color="#ff0000" c>${successfully}</h4>--%>
<%--</c:if>--%>
<%--<form id="auth" action="/controller" method="get">--%>
<%--    <p align="center">--%>
<%--        <input name="command" value="redirect" hidden>--%>
<%--        <input name="address" value="users/admin.jsp" hidden>--%>
<%--        <input type="submit" value="Назад">--%>
<%--    </p>--%>
<%--</form>--%>
</body>
</html>
