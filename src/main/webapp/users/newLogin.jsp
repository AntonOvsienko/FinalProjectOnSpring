<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        @import url(/users/css/newLogin_blank.css);
        @import url(/users/css/highBanner.css);

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
<ul id="nav">
    <li class="left"><p><a href="/controller?command=exit">Выход</a></p></li>
    <li class="left"><p>Локаль</p></li>
    <li class="left"><p>Login:${globalLogin}</p></li>
    <li class="left"><p><a href="/controller?command=redirect&address=users/doctorList.jsp">Назад</a></p></li>
</ul>
<div class="container">
    <section id="content">
        <div class="login-page">
            <div class="form">
                <form class="login-form" id="auth" action="/controller" method="post">
                    <c:choose>
                        <c:when test="${checkLogin == 'true'}">
                            <h2 align="center">Новый логин</h2>
                            <input name="command" value="checkNewLogin" hidden/>
                            <input name="login" value="${login}" required disabled type="text"/>
                            <input name="password" type="password" value="${password}" required disabled/>
                            <input name="password_repeat" type="password" value="${password_repeat}" required disabled
                                   placeholder="confirm password"/>
                        </c:when>
                        <c:otherwise>
                            <h2 align="center">Новый логин</h2>
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

            </div>
        </div>
    </section>
</div>
</body>
</html>
