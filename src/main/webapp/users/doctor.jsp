<%@ page session="true"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <style>
        @import url(/users/css/highBanner.css);
        @import url(/users/css/doctor.css);

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
<div align="center">
    <c:forEach items="${caseRecordList}" var="entry">
        <c:if test="${entry.getDoctor().login == globalLogin}">
            <fmt:parseNumber var="count" type="number" value="0"/>
            <c:forEach items="${entry.getDoctorAppointmentList()}" var="appointment" varStatus="i">
                <c:if test="${appointment.getComplete() == 'true'}">
                    <fmt:parseNumber var="count" type="number" value="${count+1}"/>
                </c:if>
            </c:forEach>
            <button class="accordion">
                Пациент: ${entry.getPatient().getName()}
                    ${entry.getPatient().getSurname()}
                (${entry.getInitialDiagnosis()}) |
                Процедур:${entry.getDoctorAppointmentList().size()}
                <c:if test="${count != '0'}">
                    <span class="colortext">Выполненно:${count}</span>

                </c:if>
            </button>
            <div class="panel" align="center">
                <input type="hidden" name="id" value="${entry.id}"/>
                <form action="/controller" method="post" class="form">
                    <input name="caseRecordId" value="${entry.id}" hidden>
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
                                            <input type="checkbox"
                                                   name="appointment"
                                                   value="${appointment.getId()}">
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
                        <button type="submit" name="command" value="confirmAppointment"
                                onclick='return confirm("Подтвердить выполнение")'>
                            Выполнить
                        </button>
                    </p>
                </form>
                <c:if test="${count == entry.getDoctorAppointmentList().size()}">
                    <p align="center">
                        <button type="submit" name="command" value="confirmAppointment"
                                onclick='return confirm("Подтвердить выписку")'>
                            Выписать
                        </button>
                    </p>
                </c:if>
                <form id="auth" action="/controller" method="post">
                    <table class="table2" align="center">
                        <input name="caseRecordId" value="${entry.id}" hidden>
                        <input input name="command" value="addAppointment" hidden>
                        <tr class="table2">
                            <th class="table2" align="center" width="5%">id</th>
                            <th class="table2" width="20%">Назначение</th>
                            <th class="table2">Подробности</th>
                        </tr>
                        <tr>
                            <td class="table2" align="center">1</td>
                            <td class="table2">
                                <select name="select1">
                                    <option value="null" selected disabled>Выберите действие</option>
                                    <option value="Приём лекарств">Приём лекарств</option>
                                    <option value="Подготовка к операции">Подготовка к операции</option>
                                    <option value="Операция">Операция</option>
                                    <option value="Терапия">Терапия</option>
                                </select>
                            </td>
                            <td class="table2"><textarea name="description1" rows="1" cols="100"></textarea></td>
                        </tr>
                        <tr class="table2" id="diagnosis2">
                            <td class="table2" align="center">2</td>
                            <td class="table2">
                                <select name="select2">
                                    <option value="null" selected disabled>Выберите действие</option>
                                    <option value="Приём лекарств">Приём лекарств</option>
                                    <option value="Подготовка к операции">Подготовка к операции</option>
                                    <option value="Операция">Операция</option>
                                    <option value="Терапия">Терапия</option>
                                </select>
                            </td>
                            <td class="table2"><textarea name="description2" rows="1" cols="100"></textarea></td>
                        </tr>
                        <tr class="table2" id="diagnosis3">
                            <td class="table2" align="center">3</td>
                            <td class="table2">
                                <select name="select3">
                                    <option value="null" selected disabled>Выберите действие</option>
                                    <option value="Приём лекарств">Приём лекарств</option>
                                    <option value="Подготовка к операции">Подготовка к операции</option>
                                    <option value="Операция">Операция</option>
                                    <option value="Терапия">Терапия</option>
                                </select>
                            </td>
                            <td class="table2"><textarea name="description3" rows="1" cols="100"></textarea></td>
                        </tr>
                        <tr class="table2" id="diagnosis4">
                            <td class="table2" align="center">4</td>
                            <td class="table2">
                                <select name="select4">
                                    <option value="null" selected disabled>Выберите действие</option>
                                    <option value="Приём лекарств">Приём лекарств</option>
                                    <option value="Подготовка к операции">Подготовка к операции</option>
                                    <option value="Операция">Операция</option>
                                    <option value="Терапия">Терапия</option>
                                </select>
                            </td>
                            <td class="table2"><textarea name="description4" rows="1" cols="100"></textarea></td>
                        </tr>
                    </table>
                    <p align="center"><input type="submit" value="Готово"></p>
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