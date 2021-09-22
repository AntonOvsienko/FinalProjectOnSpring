<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <style>
        @import url(/users/css/highBanner.css);
        @import url(/users/css/table_case_record.css);
    </style>
    <script type="text/javascript">
        function showForm() {
            if (document.getElementById("diagnosis2").hidden == true) {
                document.getElementById("diagnosis2").hidden = false;
            } else if (document.getElementById("diagnosis3").hidden == true) {
                document.getElementById("diagnosis3").hidden = false;
            } else if (document.getElementById("diagnosis4").hidden == true) {
                document.getElementById("diagnosis4").hidden = false;
            } else if (document.getElementById("diagnosis5").hidden == true) {
                document.getElementById("diagnosis5").hidden = false;
            } else if (document.getElementById("diagnosis6").hidden == true) {
                document.getElementById("diagnosis6").hidden = false;
            }
        }

        function showForm2() {
            if (document.getElementById("auth").hidden == true) {
                document.getElementById("auth").hidden = false;
            } else {
                document.getElementById("auth").hidden = true;
            }
        }
    </script>
</head>
<body>
<h1 align="center">Hello Patient</h1>
<p align="center">Текущие процедуры</p>
<form action="/controller" method="post" class="form">
    <table align="center">
        <tr class="table1">
            <th class="table1" align="center" width="5%">id</th>
            <th class="table1" width="20%">Назначение</th>
            <th class="table1" width="50%">Подробности</th>
            <th class="table1">Выполнено</th>
        </tr>
        <c:forEach items="${appointmentList}" var="patient" varStatus="i">
            <input type="hidden" name="id" value="${patient.getId()}"/>
            <c:if test="${patient == null}">
                <tr class="table1">
                    <th class="table1" colspan="4" class="table1" align="center">Нет назначений врача</th>
                </tr>
            </c:if>
            <c:if test="${patient != null}">
                <c:if test="${patient.getComplete() != 'true'}">
                    <tr class="table1">
                        <td class="table1" align="center">${i.count}</td>
                        <td class="table1">${patient.getType()}</td>
                        <td class="table1">${patient.getDescription()}</td>
                        <td class="table1">
                            <input type="checkbox"
                                   name="appointment"
                                   value="${patient.getId()}">
                        </td>
                    </tr>
                </c:if>
                <c:if test="${patient.getComplete() == 'true'}">
                    <div class="toggle-button">
                        <tr id="auth2" class="table1">
                            <td class="table1" align="center">${i.count}</td>
                            <td class="table1"><s>${patient.getType()}</s></td>
                            <td class="table1"><s>${patient.getDescription()}</s></td>
                            <td class="table1">
                                    ${patient.getNameStaffComplete()}
                            </td>
                        </tr>
                    </div>
                </c:if>
            </c:if>
        </c:forEach>
    </table>
    <p align="center">
        <button type="submit" name="command" value="deleteAppointment"
                onclick='return confirm("Вы уверены что хотите удалить назначения?")'>
            Удалить
        </button>
        <button type="submit" name="command" value="confirmAppointment"
                onclick='return confirm("Подтвердить выполнение")'>
            Выполнить
        </button>
        <fmt:parseNumber var="count" type="number" value="0"/>
        <c:forEach items="${appointmentList}" var="appointment">
            <c:if test="${appointment.getComplete() == 'true'}">
                    <fmt:parseNumber var="count" type="number" value="${count+1}"/>
            </c:if>
        </c:forEach>
        <c:if test="${count == appointmentList.size()}">
        <button type="submit" name="command" value="confirmAppointment"
                onclick='return confirm("Выписать?")'>
            Выписать
        </button>
        </c:if>
    </p>
</form>

<p align="center"><input type="button" value="Добавить процедур" onclick="showForm2()"></p>
<form id="auth" action="/controller" method="post" hidden>
    <table class="table2" align="center">
        <input name="caseRecordId" value="${caseRecordId}" hidden>
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
        <tr class="table2" id="diagnosis2" hidden>
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
        <tr class="table2" id="diagnosis3" hidden>
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
        <tr class="table2" id="diagnosis4" hidden>
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
        <tr class="table2" id="diagnosis5" hidden>
            <td class="table2" align="center">5</td>
            <td class="table2">
                <select name="select5">
                    <option value="null" selected disabled>Выберите действие</option>
                    <option value="Приём лекарств">Приём лекарств</option>
                    <option value="Подготовка к операции">Подготовка к операции</option>
                    <option value="Операция">Операция</option>
                    <option value="Терапия">Терапия</option>
                </select>
            </td>
            <td class="table2"><textarea name="description5" rows="1" cols="100"></textarea></td>
        </tr>
        <tr class="table2" id="diagnosis6" hidden>
            <td class="table2" align="center">6</td>
            <td class="table2">
                <select name="select6">
                    <option value="null" selected disabled>Выберите действие</option>
                    <option value="Приём лекарств">Приём лекарств</option>
                    <option value="Подготовка к операции">Подготовка к операции</option>
                    <option value="Операция">Операция</option>
                    <option value="Терапия">Терапия</option>
                </select>
            </td>
            <td class="table2"><textarea name="description5" rows="1" cols="100"></textarea></td>
        </tr>
    </table>
    <p align="center"><input type="button" value="Добавить поле" onclick="showForm()"></p>
    <p align="center"><input type="submit" value="Готово"></p>
</form>
<p align="center">Выполнить процедуры</p>
</body>
</html>