<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="loc" uri="http://com.ua/FinalProject" %>
<html>
<head>
    <title>Title</title>
    <style>

        #nav {
            width: 100%;
            float: right;
            margin: -92px 0 1em 0;
            padding: 0;
            list-style: none;
            background-color: #f2f2f2;
            border-bottom: 1px solid #ccc;
            border-top: 1px solid #ccc;
        }

        #nav li.right {
            float: left;
        }

        #nav li.right p {
            display: block;
            padding: 8px 16px;
            text-decoration: none;
            font-weight: bold;
            border-right: 1px solid #ccc;
        }

        #nav li.right p:hover {
            color: #c00;
            background-color: #fff;
        }

        a {
            text-decoration: none;
        }

        #nav li.left {
            float: right;
        }

        #nav li.left p {
            display: block;
            padding: 8px 16px;
            text-decoration: none;
            font-weight: bold;
            border-left: 1px solid #ccc;
        }

        #nav li.left p:hover {
            color: #c00;
            background-color: #fff;
        }

        .login-page {
            width: 84%;
            padding: 5% 8% 8% 8%;
            margin: auto;
            text-align: center;
        }

        .form input {
            font-family: "Roboto", sans-serif;
            outline: 0;
            background: #f2f2f2;
            width: 100%;
            border: 0;
            margin: 0 0 15px;
            padding: 15px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form .message {
            margin: 15px 0 0;
            color: #b3b3b3;
            font-size: 12px;
        }

        .form .message a {
            color: #4CAF50;
            text-decoration: none;
        }

        .form .register-form {
            display: none;
        }

        body {
            background: #ebebeb; /* fallback for old browsers */
            font-family: 'Open Sans', Arial, sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .letter {
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            margin: 100px auto 0;
            max-width: 550px;
            min-height: 300px;
            padding: 24px;
            position: relative;
            width: 80%;
        }

        .letter:before, .letter:after {
            content: "";
            height: 98%;
            position: absolute;
            width: 100%;
            z-index: -1;
        }

        .letter:before {
            background: #fafafa;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
            left: -5px;
            top: 4px;
            transform: rotate(-2.5deg);
        }

        .letter:after {
            background: #f6f6f6;
            box-shadow: 0 0 3px rgba(0, 0, 0, 0.2);
            right: -3px;
            top: 1px;
            transform: rotate(1.4deg);
        }

        .hr-shadow {
            margin: 20px 0;
            padding: 0;
            height: 10px;
            border: none;
            border-top: 1px solid #333;
            box-shadow: 0 10px 10px -10px #8c8b8b inset;
        }

        .three {
            padding: 0px 20px 50px;
            text-align: center;
        }

        .three h1 {
            font-family: 'Open Sans', Arial, sans-serif;
            position: relative;
            color: White;
            background: #c0c0c0;
            font-size: 2.5em;
            font-weight: normal;
            padding: 10px 40px;
            display: inline-block;
            margin: 0;
            line-height: 1;
        }

        .three h1:before {
            content: "";
            position: absolute;
            width: 100%;
            height: 4px;
            left: 0;
            bottom: -15px;
            background: #c0c0c0;
        }

        .three h1:after {
            content: "";
            position: absolute;
            height: 0;
            width: 80%;
            border-top: 10px solid #c0c0c0;
            border-left: 12px solid transparent;
            border-right: 12px solid transparent;
            left: 50%;
            transform: translateX(-50%);
            bottom: -25px;
        }

        .shine-button {
            text-decoration: none;
            display: inline-block;
            padding: 10px 30px;
            margin: 10px 20px;
            position: relative;
            overflow: hidden;
            border: 2px solid rgba(114, 212, 202, 1);
            border-radius: 8px;
            font-family: 'Montserrat', sans-serif;
            color: GREEN;
            transition: .2s ease-in-out;
            float: end;
        }

        .shine-button:before {
            content: "";
            background: linear-gradient(90deg, rgba(255, 255, 255, .1), rgba(255, 255, 255, .5));
            height: 50px;
            width: 50px;
            position: absolute;
            top: -8px;
            left: -75px;
            transform: skewX(-45deg);
        }

        .shine-button:hover {
            background: rgba(114, 212, 202, 1);
            color: #fff;
        }

        .shine-button:hover:before {
            left: 150px;
            transition: .5s ease-in-out;
        }

    </style>
    <script type="text/javascript">

    </script>
</head>
<body>
<ul id="nav">
    <li class="left"><p><a href="/controller?command=exit">
        <loc:print key="Head_Button_Exit"/></a></p></li>
    <c:forTokens items="${initParam['locales']}"
                 var="locale" delims=" ">
        <li class="left">
            <p>
                <a href="/changeLocale.jsp?localeToSet=${locale}&pageToForward=users/anketa.jsp&basename=message_${locale}">
                    <img src="/${locale}.png" width="20" height="20"></a></p>
        </li>
    </c:forTokens>
    <li class="left"><p>
        <loc:print key="Head_Button_Login"/>${globalLogin}</p></li>
    <li class="left"><p><a href="/controller?command=redirect&address=users/doctorList.jsp">
        <loc:print key="Head_Button_Return"/></a></p></li>
</ul>
<div class="letter">
    <div class="login-page">
        <div class="form">
            <div class="three"><h1><loc:print key="Anketa"/></h1></div>
            <hr class="hr-shadow">
            <table align="center" width="100%">
                <c:forEach items="${doctors}" var="entry">
                    <c:if test="${entry.getLogin() == loginDoctor}">
                        <tr>
                            <th><loc:print key="Passport_Number_Empty"/></th>
                            <th><input name="passport" placeholder="${entry.getPassport()}"
                                       pattern="[А-Яа-яЁё]{2,2}\d{8,8}" type="text" readonly></th>
                            </p>
                        </tr>
                        <tr>
                            <th align="right"><loc:print key="Name_Anketa"/></th>
                            <th><input type="text" name="name" placeholder="${entry.getName()}"
                                       pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" readonly></th>
                        </tr>
                        <tr>
                            <th><loc:print key="Surname_Anketa"/></th>
                            <th><input type="text" name="surname" placeholder="${entry.getSurname()}"
                                       pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" readonly></th>
                        </tr>
                        <tr>
                            <th><loc:print key="Department_Anketa"/></th>
                            <th><input type="text" name="surname" placeholder="${entry.getDepartment()}"
                                       pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" readonly></th>
                        </tr>

                    </c:if>
                </c:forEach>
            </table>
            <hr class="hr-shadow">
            <form action="/controller" method="post">
                <button class="shine-button" type="submit" name="command" value="deleteDoctor" width="100%">
                    <loc:print key="Delete_Employee"/>
                </button>
                <button class="shine-button" type="submit" name="command" value="changeDoctor" width="100%">
                    <loc:print key="Add_Employee"/>
                </button>
                <input name="loginDoctor" value="${loginDoctor}" hidden>
                <input name="address" value="users/anketa.jsp" hidden>
            </form>
            </input>
            <%--            <form action="/controller" method="post">--%>
            <%--                <input name="password" type="password" required placeholder="<loc:print key="Password"/>"/>--%>
            <%--                <input name="password_repeat" type="password" required--%>
            <%--                       placeholder="<loc:print key="Confirm_Password"/>"/>--%>
            <%--                <input name="newLogin" value="${newLogin}" hidden>--%>
            <%--                <input name="password" value="${password}" hidden>--%>
            <%--                <input name="role" value="${role}" hidden>--%>
            <%--                <p align="center"><input name="passport" placeholder="<loc:print key="Passport_Number"/>"--%>
            <%--                                         pattern="[А-Яа-яЁё]{2,2}\d{8,8}" type="text" required>--%>
            <%--                </p>--%>
            <%--                <p align="center"><input type="text" name="name" placeholder="<loc:print key="Name_Anketa"/>"--%>
            <%--                                         pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required></p>--%>
            <%--                <p align="center"><input type="text" name="surname" placeholder="<loc:print key="Surname_Anketa"/>"--%>
            <%--                                         pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required></p>--%>
            <%--                <p align="center"><input id="online_phone" name="telephone" type="tel" maxlength="50"--%>
            <%--                                         pattern="[0-9]{12,12}"--%>
            <%--                                         placeholder="<loc:print key="Number_Telephone"/>"--%>
            <%--                                         name="telephone"></p>--%>
            <%--                <c:if test="${role == 'doctor'}">--%>
            <%--                    <p align="center"><select name="department" class="selcls">--%>
            <%--                        <c:forEach items="${departments}" var="department">--%>
            <%--                            <option value="${department.description}">${department.description}</option>--%>
            <%--                        </c:forEach>--%>
            <%--                    </select></p>--%>
            <%--                </c:if>--%>
            <%--                <button type="submit" name="command" value="createNewLogin"><loc:print key="Create"/></button>--%>
            <%--            </form>--%>
        </div>
    </div>
</div>
</body>
</html>
