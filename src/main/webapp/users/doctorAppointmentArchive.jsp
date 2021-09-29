<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="loc" uri="http://com.ua/FinalProject" %>
<html>
<head>
    <style>

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



        #nav {
            width: 100%;
            float: right;
            margin: -112px 0 1em 0;
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

        table {
            font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
            font-size: 14px;
            background: white;
            max-width: 100%;
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th.table1 {
            font-weight: normal;
            color: #039;
            border-bottom: 2px solid #6678b1;
            padding: 10px 8px;
        }

        td.table1 {
            border-bottom: 1px solid #ccc;
            color: #669;
            padding: 9px 8px;
            transition: .3s linear;
        }

        tr:hover td {
            color: #6699ff;
        }

        .login-page {
            width: 80%;
            padding: 5% 5% 5% 5%;
            margin: auto;
            text-align: left;
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
            margin: 120px auto 0;
            max-width: 70%;
            min-height: 600px;
            padding: 18px;
            position: relative;
            width: 70%;
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

    </style>
</head>
<body>
<ul id="nav">
    <li class="left"><p><a href="/controller?command=exit">
        <loc:print key="Head_Button_Exit"/></a></p></li>
    <c:forTokens items="${initParam['locales']}"
                 var="locale" delims=" ">
        <li class="left">
            <p>
                <a href="/changeLocale.jsp?localeToSet=${locale}&pageToForward=users/doctorAppointmentArchive.jsp&basename=message_${locale}">
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
            <div class="three"><h1><loc:print key="Medical_Appointments"/></h1></div>
            <hr class="hr-shadow">
            <table align="center">
                <tr class="table1">
                    <th class="table1" width="5%">id</th>
                    <th class="table1" width="15%">Тип</th>
                    <th class="table1" width="55%">Подробно</th>
                    <th class="table1" width="25%">Выполнил</th>
                </tr>
                <c:forEach items="${doctorAppointments}" var="appointment" varStatus="i">
                    <tr class="table1">
                        <td class="table1">${i.count}</td>
                        <td class="table1">${appointment.getType()}</td>
                        <td class="table1">${appointment.getDescription()}</td>
                        <td class="table1">${appointment.getNameStaffComplete()}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</body>
</html>