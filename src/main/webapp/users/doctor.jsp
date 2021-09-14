<%@ page session="true"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <style>

        th.table1 {
            font-weight: normal;
            font-size: 13px;
            color: #039;
            border-right: 1px solid #0865c2;
            border-top: 1px solid #0865c2;
            border-left: 1px solid #0865c2;
            border-bottom: 1px solid white;
            padding: 20px;
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

        table.table2 {
            border: 1px solid #6cf;
        }

        th.table2 {
            font-weight: normal;
            font-size: 13px;
            color: #039;
            border-right: 1px solid #0865c2;
            border-top: 1px solid #0865c2;
            border-left: 1px solid #0865c2;
            border-bottom: 1px solid white;
            padding: 20px;
        }

        td.table2 {
            color: #669;
            border-right: 1px dashed #6cf;
            padding: 10px 20px;
        }

        body {
            font-family: 'Open Sans', Arial, sans-serif;
            font-size: 1em;
            background: #ebebeb;
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
<h1>Hello Nurse</h1>
<h3>
    Login:${globalLogin}<br>
    Name:${name}<br>
    Surname:${surname}<br>
    Passport:${passport}<br>
</h3>
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