<%@ page session="true"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<html>
<head>
    <style>
        @import url(/users/css/highBanner.css);
        @import url(/users/css/nurse.css);

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
    <li class="left"><p><a href="/controller?command=exit">Выход</a></p></li>
    <li class="left"><p>Локаль</p></li>
    <li class="left"><p>Login:${globalLogin}(${name} ${surname})</p></li>
    <li class="left"><p><a href="/controller?command=viewCaseRecord">Обновить</a></p></li>
</ul>
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
                <input type="hidden" name="pageSize" value="${pageSize}"/>
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