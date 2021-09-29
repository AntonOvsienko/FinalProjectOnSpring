<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="loc" uri="http://com.ua/FinalProject" %>
<html>
<head>
    <style>

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

        .login-page {
            width: 90%;
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
            max-width: 80%;
            min-height: 600px;
            padding: 18px;
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

        table {
            font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
            background: White;
            font-size: 14px;
            max-width: 80%;
            width: 90%;
            border-collapse: collapse;
            text-align: left;
        }

        th.table {
            font-weight: normal;
            color: #039;
            border-bottom: 2px solid #6678b1;
            padding: 10px 8px;
        }

        td.table {
            border-bottom: 1px solid #ccc;
            color: #669;
            padding: 9px 8px;
            transition: .3s linear;
        }

        tr:hover td {
            color: #6699ff;
        }

        .accordion {
            background-color: #eee;
            /*background-color: white;*/
            color: #444;
            cursor: pointer;
            padding: 18px;
            width: 90%;
            align-content: center;
            text-align: left;
            font-size: 15px;
            transition: 0.4s;
        }

        .active, .accordion:hover {
            background-color: #ccc;
        }

        .accordion:after {
            content: '\002B';
            color: #777;
            font-weight: bold;
            float: right;
            margin-left: 5px;
        }

        .active:after {
            content: "\2212";
        }

        .panel {
            padding: 0 18px;
            /*background-color: #ebebeb; */
            background-color: WHITE;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.2s ease-out;
        }

        .colortext {
            color: darkgreen;
        }

        div.p {
            padding-top: 10px;
            padding-right: 5%;
            padding-left: 5%;
            padding-bottom: 5px;
        }
    </style>
    <script>
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {
                this.classList.toggle("active");
                var panel = this.nextElementSibling;
                if (panel.style.maxHeight) {
                    panel.style.maxHeight = null;
                } else {
                    panel.style.maxHeight = panel.scrollHeight + "px";
                }
            });
        }
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
                <a href="/changeLocale.jsp?localeToSet=${locale}&pageToForward=users/nurse.jsp&basename=message_${locale}">
                    <img src="/${locale}.png" width="20" height="20"></a></p>
        </li>
    </c:forTokens>
    <li class="left"><p>
        <loc:print key="Head_Button_Login"/>${globalLogin}</p></li>
</ul>
<div class="letter">
    <div class="login-page">
        <div class="form">
            <div class="three"><h1><loc:print key="Patient_Case_Anketa"/></h1></div>
            <div class="p">
                Page ${page} of ${pageCount}

                |

                <c:choose>
                    <c:when test="${page - 1 > 0}">
                        <a href="page?page=${page-1}&pageSize=${pageSize}">Previous</a>
                    </c:when>
                    <c:otherwise>
                        Previous
                    </c:otherwise>
                </c:choose>

                <c:forEach var="p" begin="${minPossiblePage}" end="${maxPossiblePage}">
                    <c:choose>
                        <c:when test="${page == p}">${p}</c:when>
                        <c:otherwise>
                            <a href="page?page=${p}&pageSize=${pageSize}">${p}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${page + 1 <= pageCount}">
                        <a href="page?page=${page+1}&pageSize=${pageSize}">Next</a>
                    </c:when>
                    <c:otherwise>
                        Next
                    </c:otherwise>
                </c:choose>
                |
                <form action="page" style='display:inline;'>
                    <select name="page">
                        <c:forEach begin="1" end="${pageCount}" var="p">
                            <option value="${p}" ${p == param.page ? 'selected' : ''}>${p}</option>
                        </c:forEach>
                    </select>
                    <input name="pageSize" value="${pageSize}" type="hidden"/>
                    <input type="submit" value="Go"/>
                </form>
                <form action="page" style='display:inline;'>
                    <input type="number" name="pageSize"
                           min="1" max="10"/>
                    <input name="page" value="${page}" type="hidden"/>
                    <input type="submit" value="count"/>
                </form>
            </div>
            <div align="center">
                <c:forEach items="${caseRecordList}" var="patient" varStatus="i">
                    <c:if test="${i.count>(page-1)*pageSize && i.count<= page*pageSize}">
                        <fmt:parseNumber var="count" type="number" value="0"/>
                        <c:forEach items="${patient.getDoctorAppointmentList()}" var="appointment">
                            <c:if test="${appointment.getComplete() == 'true'}">
                                <fmt:parseNumber var="count" type="number" value="${count+1}"/>
                            </c:if>
                        </c:forEach>
                        <button class="accordion">
                            <loc:print key="Head_Button_Patient"/>: ${patient.getPatient().getName()}
                                ${patient.getPatient().getSurname()}
                            (${patient.getInitialDiagnosis()}) |
                            <loc:print key="Head_Button_Doctor"/>: ${patient.getDoctor().getName()}
                                ${patient.getDoctor().getSurname()} |
                            <loc:print key="Medical_Appointments"/>:${patient.getDoctorAppointmentList().size()}
                            <c:if test="${count != '0'}">/
                                <span class="colortext">Выполненно:${count}</span>
                            </c:if>
                        </button>
                        <div class="panel" align="center">
                            <input type="hidden" name="id" value="${patient.getId()}"/>
                            <input type="hidden" name="pageSize" value="${pageSize}"/>
                            <form action="/controller" method="post" class="form">
                                <table align="center">
                                    <tr class="table">
                                        <th class="table" align="center" width="5%">id</th>
                                        <th class="table" width="20%"><loc:print key="Medical_Appointments"/></th>
                                        <th class="table" width="50%"><loc:print key="Details"/></th>
                                        <th class="table"><loc:print key="Complete"/></th>
                                    </tr>
                                    <c:forEach items="${patient.getDoctorAppointmentList()}" var="appointment"
                                               varStatus="i">
                                        <c:if test="${appointment != null}">
                                            <c:if test="${appointment.getComplete() != 'true'}">
                                                <tr class="table">
                                                    <td class="table" align="center">${i.count}</td>
                                                    <td class="table">${appointment.getType()}</td>
                                                    <td class="table">${appointment.getDescription()}</td>
                                                    <td class="table">
                                                        <c:if test="${appointment.getType() != 'Операция'}">
                                                            <c:if test="${appointment.getType() != 'Терапия'}">
                                                                <input type="checkbox"
                                                                       name="appointment"
                                                                       value="${appointment.getId()}">
                                                            </c:if>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <c:if test="${appointment.getComplete() == 'true'}">
                                                <div class="toggle-button">
                                                    <tr id="auth2" class="table1">
                                                        <td class="table" align="center">${i.count}</td>
                                                        <td class="table"><s>${appointment.getType()}</s></td>
                                                        <td class="table"><s>${appointment.getDescription()}</s></td>
                                                        <td class="table">
                                                                ${appointment.getNameStaffComplete()}
                                                        </td>
                                                    </tr>
                                                </div>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${patient.getDoctorAppointmentList().size() == 0}">
                                        <tr class="table">
                                            <th class="table" colspan="4" class="table1" align="center">Нет назначений
                                                врача
                                            </th>
                                        </tr>
                                    </c:if>
                                </table>
                                <p align="center">
                                    <button type="submit" name="command" value="confirmNurseAppointment"
                                            onclick='return confirm("<loc:print key="Confirm"/>")'>
                                        <loc:print key="Performed"/>
                                    </button>
                                </p>
                            </form>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script>
    var acc = document.getElementsByClassName("accordion");
    var i;

    for (i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var panel = this.nextElementSibling;
            if (panel.style.maxHeight) {
                panel.style.maxHeight = null;
            } else {
                panel.style.maxHeight = panel.scrollHeight + "px";
            }
        });
    }
</script>
</body>
</html>