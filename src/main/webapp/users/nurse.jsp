<%@ page session="true"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<html>
<head>
    <style>

        body {
            font-family: 'Open Sans', Arial, sans-serif;
            font-size: 1em;
            background: #ebebeb;
        }

        div.p {
            padding: 0 10%;
        }

        table {
            /*font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;*/
            background: #ebebeb;;
            font-size: 14px;
            max-width: 70%;
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
            width: 80%;
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
            background-color: #ebebeb;
            /*background-color: white;*/
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.2s ease-out;
        }

        .colortext {
            color: darkgreen;
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
<h3>
    Login:${login}<br>
    Name:${name}<br>
    Surname:${surname}<br>
    Passport:${passport}<br>
</h3>
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
    <c:forEach items="${caseRecordList}" var="entry" varStatus="i">
        <c:if test="${i.count>(page-1)*pageSize && i.count<= page*pageSize}">
            <fmt:parseNumber var="count" type="number" value="0"/>
            <c:forEach items="${entry.getDoctorAppointmentList()}" var="appointment">
                <c:if test="${appointment.getComplete() == 'true'}">
                    <fmt:parseNumber var="count" type="number" value="${count+1}"/>
                </c:if>
            </c:forEach>
            <button class="accordion">
                Пациент: ${entry.getPatient().getName()}
                    ${entry.getPatient().getSurname()}
                (${entry.getInitialDiagnosis()}) |
                Врач: ${entry.getDoctor().getName()}
                    ${entry.getDoctor().getSurname()} |
                Процедур:${entry.getDoctorAppointmentList().size()}
                <c:if test="${count != '0'}">/
                    <span class="colortext">Выполненно:${count}</span>
                </c:if>
            </button>
            <div class="panel" align="center">
                <input type="hidden" name="id" value="${entry.getId()}"/>
                <form action="/controller" method="post" class="form">
                    <table align="center">
                        <tr class="table">
                            <th class="table" align="center" width="5%">id</th>
                            <th class="table" width="20%">Назначение</th>
                            <th class="table" width="50%">Подробности</th>
                            <th class="table">Выполнено</th>
                        </tr>
                        <c:forEach items="${entry.getDoctorAppointmentList()}" var="appointment" varStatus="i">
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
                        <c:if test="${entry.getDoctorAppointmentList().size() == 0}">
                            <tr class="table">
                                <th class="table" colspan="4" class="table1" align="center">Нет назначений врача
                                </th>
                            </tr>
                        </c:if>
                    </table>
                    <p align="center">
                        <button type="submit" name="command" value="confirmNurseAppointment"
                                onclick='return confirm("Подтвердить выполнение")'>
                            Выполнить
                        </button>
                    </p>
                </form>
            </div>
        </c:if>
    </c:forEach>
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