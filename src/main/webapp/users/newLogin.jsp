<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        table {
            text-align: center;
            border: 1px
        }

        /* Reset CSS */
        html, body, div, span, applet, object, iframe,
        h1, h2, h3, h4, h5, h6, p, blockquote, pre,
        a, abbr, acronym, address, big, cite, code,
        del, dfn, em, font, img, ins, kbd, q, s, samp,
        small, strike, strong, sub, sup, tt, var,
        b, u, i, center,
        dl, dt, dd, ol, ul, li,
        fieldset, form, label, legend,
        table, caption, tbody, tfoot, thead, tr, th, td {
            margin: 0;
            padding: 0;
            border: 0;
            outline: 0;
            font-size: 100%;
            vertical-align: baseline;
            background: transparent;
        }

        body {
            background: #DCDDDF url(https://cssdeck.com/uploads/media/items/7/7AF2Qzt.png);
            color: #000;
            font: 14px Arial;
            margin: 0 auto;
            padding: 0;
            position: relative;
        }

        h1 {
            font-size: 28px;
        }

        h2 {
            font-size: 26px;
        }

        h3 {
            font-size: 18px;
        }

        h4 {
            font-size: 16px;
        }

        h5 {
            font-size: 14px;
        }

        h6 {
            font-size: 12px;
        }

        h1, h2, h3, h4, h5, h6 {
            color: #563D64;
        }

        small {
            font-size: 10px;
        }

        b, strong {
            font-weight: bold;
        }

        a {
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .left {
            float: left;
        }

        .right {
            float: right;
        }

        .alignleft {
            float: left;
            margin-right: 15px;
        }

        .alignright {
            float: right;
            margin-left: 15px;
        }

        .clearfix:after,
        form:after {
            content: ".";
            display: block;
            height: 0;
            clear: both;
            visibility: hidden;
        }

        .container {
            margin: 25px auto;
            position: relative;
            width: 900px;
        }

        #content {
            background: #f9f9f9;
            background: -moz-linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            background: -webkit-linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            background: -o-linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            background: -ms-linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            background: linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#f8f8f8', endColorstr='#f9f9f9', GradientType=0);
            -webkit-box-shadow: 0 1px 0 #fff inset;
            -moz-box-shadow: 0 1px 0 #fff inset;
            -ms-box-shadow: 0 1px 0 #fff inset;
            -o-box-shadow: 0 1px 0 #fff inset;
            box-shadow: 0 1px 0 #fff inset;
            border: 1px solid #c4c6ca;
            margin: 0 auto;
            padding: 25px 0 0;
            position: relative;
            text-align: center;
            text-shadow: 0 1px 0 #fff;
            width: 400px;
        }

        #content h1 {
            color: #7E7E7E;
            font: bold 25px Helvetica, Arial, sans-serif;
            letter-spacing: -0.05em;
            line-height: 20px;
            margin: 10px 0 30px;
        }

        #content h1:before,
        #content h1:after {
            content: "";
            height: 1px;
            position: absolute;
            top: 10px;
            width: 27%;
        }

        #content h1:after {
            background: rgb(126, 126, 126);
            background: -moz-linear-gradient(left, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            background: -webkit-linear-gradient(left, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            background: -o-linear-gradient(left, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            background: -ms-linear-gradient(left, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            background: linear-gradient(left, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            right: 0;
        }

        #content h1:before {
            background: rgb(126, 126, 126);
            background: -moz-linear-gradient(right, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            background: -webkit-linear-gradient(right, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            background: -o-linear-gradient(right, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            background: -ms-linear-gradient(right, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            background: linear-gradient(right, rgba(126, 126, 126, 1) 0%, rgba(255, 255, 255, 1) 100%);
            left: 0;
        }

        #content:after,
        #content:before {
            background: #f9f9f9;
            background: -moz-linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            background: -webkit-linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            background: -o-linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            background: -ms-linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            background: linear-gradient(top, rgba(248, 248, 248, 1) 0%, rgba(249, 249, 249, 1) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#f8f8f8', endColorstr='#f9f9f9', GradientType=0);
            border: 1px solid #c4c6ca;
            content: "";
            display: block;
            height: 100%;
            left: -1px;
            position: absolute;
            width: 100%;
        }

        #content:after {
            -webkit-transform: rotate(2deg);
            -moz-transform: rotate(2deg);
            -ms-transform: rotate(2deg);
            -o-transform: rotate(2deg);
            transform: rotate(2deg);
            top: 0;
            z-index: -1;
        }

        #content:before {
            -webkit-transform: rotate(-3deg);
            -moz-transform: rotate(-3deg);
            -ms-transform: rotate(-3deg);
            -o-transform: rotate(-3deg);
            transform: rotate(-3deg);
            top: 0;
            z-index: -2;
        }

        #content form {
            margin: 0 20px;
            position: relative
        }

        #content form input[type="text"],
        #content form input[type="password"] {
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            -ms-border-radius: 3px;
            -o-border-radius: 3px;
            border-radius: 3px;
            -webkit-box-shadow: 0 1px 0 #fff, 0 -2px 5px rgba(0, 0, 0, 0.08) inset;
            -moz-box-shadow: 0 1px 0 #fff, 0 -2px 5px rgba(0, 0, 0, 0.08) inset;
            -ms-box-shadow: 0 1px 0 #fff, 0 -2px 5px rgba(0, 0, 0, 0.08) inset;
            -o-box-shadow: 0 1px 0 #fff, 0 -2px 5px rgba(0, 0, 0, 0.08) inset;
            box-shadow: 0 1px 0 #fff, 0 -2px 5px rgba(0, 0, 0, 0.08) inset;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -ms-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
            background: #eae7e7 url(https://cssdeck.com/uploads/media/items/8/8bcLQqF.png) no-repeat;
            border: 1px solid #c8c8c8;
            color: #777;
            font: 13px Helvetica, Arial, sans-serif;
            margin: 0 0 10px;
            padding: 15px 10px 15px 40px;
            width: 80%;
        }

        #content form input[type="text"]:focus,
        #content form input[type="password"]:focus {
            -webkit-box-shadow: 0 0 2px #ed1c24 inset;
            -moz-box-shadow: 0 0 2px #ed1c24 inset;
            -ms-box-shadow: 0 0 2px #ed1c24 inset;
            -o-box-shadow: 0 0 2px #ed1c24 inset;
            box-shadow: 0 0 2px #ed1c24 inset;
            background-color: #fff;
            border: 1px solid #ed1c24;
            outline: none;
        }

        #username {
            background-position: 10px 10px !important
        }

        #password {
            background-position: 10px -53px !important
        }

        #content form input[type="submit"] {
            background: rgb(254, 231, 154);
            background: -moz-linear-gradient(top, rgba(254, 231, 154, 1) 0%, rgba(254, 193, 81, 1) 100%);
            background: -webkit-linear-gradient(top, rgba(254, 231, 154, 1) 0%, rgba(254, 193, 81, 1) 100%);
            background: -o-linear-gradient(top, rgba(254, 231, 154, 1) 0%, rgba(254, 193, 81, 1) 100%);
            background: -ms-linear-gradient(top, rgba(254, 231, 154, 1) 0%, rgba(254, 193, 81, 1) 100%);
            background: linear-gradient(top, rgba(254, 231, 154, 1) 0%, rgba(254, 193, 81, 1) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fee79a', endColorstr='#fec151', GradientType=0);
            -webkit-border-radius: 30px;
            -moz-border-radius: 30px;
            -ms-border-radius: 30px;
            -o-border-radius: 30px;
            border-radius: 30px;
            -webkit-box-shadow: 0 1px 0 rgba(255, 255, 255, 0.8) inset;
            -moz-box-shadow: 0 1px 0 rgba(255, 255, 255, 0.8) inset;
            -ms-box-shadow: 0 1px 0 rgba(255, 255, 255, 0.8) inset;
            -o-box-shadow: 0 1px 0 rgba(255, 255, 255, 0.8) inset;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.8) inset;
            border: 1px solid #D69E31;
            color: #85592e;
            cursor: pointer;
            float: left;
            font: bold 15px Helvetica, Arial, sans-serif;
            height: 35px;
            margin: 20px 0 35px 15px;
            position: relative;
            text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
            width: 120px;
        }

        #content form input[type="submit"]:hover {
            background: rgb(254, 193, 81);
            background: -moz-linear-gradient(top, rgba(254, 193, 81, 1) 0%, rgba(254, 231, 154, 1) 100%);
            background: -webkit-linear-gradient(top, rgba(254, 193, 81, 1) 0%, rgba(254, 231, 154, 1) 100%);
            background: -o-linear-gradient(top, rgba(254, 193, 81, 1) 0%, rgba(254, 231, 154, 1) 100%);
            background: -ms-linear-gradient(top, rgba(254, 193, 81, 1) 0%, rgba(254, 231, 154, 1) 100%);
            background: linear-gradient(top, rgba(254, 193, 81, 1) 0%, rgba(254, 231, 154, 1) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fec151', endColorstr='#fee79a', GradientType=0);
        }

        #content form div a {
            color: #004a80;
            float: right;
            font-size: 12px;
            margin: 30px 15px 0 0;
            text-decoration: underline;
        }

        .button {
            background: rgb(247, 249, 250);
            background: -moz-linear-gradient(top, rgba(247, 249, 250, 1) 0%, rgba(240, 240, 240, 1) 100%);
            background: -webkit-linear-gradient(top, rgba(247, 249, 250, 1) 0%, rgba(240, 240, 240, 1) 100%);
            background: -o-linear-gradient(top, rgba(247, 249, 250, 1) 0%, rgba(240, 240, 240, 1) 100%);
            background: -ms-linear-gradient(top, rgba(247, 249, 250, 1) 0%, rgba(240, 240, 240, 1) 100%);
            background: linear-gradient(top, rgba(247, 249, 250, 1) 0%, rgba(240, 240, 240, 1) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#f7f9fa', endColorstr='#f0f0f0', GradientType=0);
            -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) inset;
            -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) inset;
            -ms-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) inset;
            -o-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) inset;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) inset;
            -webkit-border-radius: 0 0 5px 5px;
            -moz-border-radius: 0 0 5px 5px;
            -o-border-radius: 0 0 5px 5px;
            -ms-border-radius: 0 0 5px 5px;
            border-radius: 0 0 5px 5px;
            border-top: 1px solid #CFD5D9;
            padding: 15px 0;
        }

        .button a {
            background: url(https://cssdeck.com/uploads/media/items/8/8bcLQqF.png) 0 -112px no-repeat;
            color: #7E7E7E;
            font-size: 17px;
            padding: 2px 0 2px 40px;
            text-decoration: none;
            -webkit-transition: all 0.3s ease;
            -moz-transition: all 0.3s ease;
            -ms-transition: all 0.3s ease;
            -o-transition: all 0.3s ease;
            transition: all 0.3s ease;
        }

        .button a:hover {
            background-position: 0 -135px;
            color: #00aeef;
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
<div class="container">
    <section id="content">
        <form action="">
            <h1>Login Form</h1>
            <div>
                <input type="text" placeholder="Username" required="" id="username"/>
            </div>
            <div>
                <input type="password" placeholder="Password" required="" id="password"/>
            </div>
            <div>
                <input type="submit" value="Log in"/>
                <a href="#">Lost your password?</a>
                <a href="#">Register</a>
            </div>
        </form><!-- form -->

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
<%--            <table border="5%" width="45%" cellpadding="5">--%>
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
<%--            </table>--%>
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
