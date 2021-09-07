<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <style>
        table {
            border: 1px solid grey;
            width: 1000px;
            text-align: left;
        }

        th.cell {
            padding: 3px 5px;
        }

        th {
            border: 1px solid grey;
        }

        td {
            border: 1px solid grey;
        }
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
    </script>
</head>
<body>

<h1 align="center">Hello Patient</h1>
<%--<form action="/controller" method="post">--%>
<%--    <input name="command" value="updateStaff" hidden>--%>
<%--    <p align="center">Номер паспорта: <input name="passport" type="text" required><span></span> - поле обязательно</p>--%>
<%--    <p align="center">Имя: <input type="text" name="name" required><span></span> - поле обязательно</p>--%>
<%--    <p align="center">Фамилия: <input type="text" name="surname" required><span> - поле обязательно</span></p>--%>
<%--    <p align="center">Дата рождения:<input type="date" id="date" name="date"/></p>--%>
<%--    <p align="center">Контактный номер: <input type="text" name="telephone"><span></span></p>--%>
<%--    <p align="center"><input type="submit" value="Создать"></p>--%>
<%--</form>--%>
<p align="center">Текущие процедуры</p>
<table align="center">
    <tr>
        <th class="cell" align="center" width="5%">id</th>
        <th class="cell" width="20%">Назначение</th>
        <th class="cell">Подробности</th>
        <th class="cell" width="15%">Выполнено</th>
    </tr>
    <c:forEach items="${appointmentList}" var="entry" varStatus="i">
        <tr>
            <th class="cell" align="center">${i.count}</th>
            <th class="cell">${entry.getType()}</th>
            <th class="cell">${entry.getDescription()}</th>
            <th class="cell"></th>
        </tr>
    </c:forEach>
    </tr>
</table>
<p align="center">Назначить процедуры</p>
<form id="auth" action="/controller" method="post">
<table align="center">
        <input input name="command" value="addAppointment" hidden>
        <tr>
            <th class="cell" align="center" width="5%">id</th>
            <th class="cell" width="20%">Назначение</th>
            <th class="cell">Подробности</th>
            <th class="cell" width="15%">Ответственный</th>
        </tr>
        <tr>
            <th class="cell" align="center">1</th>
            <th class="cell">
                <select name="select1">
                    <option value="null" selected disabled>Выберите действие</option>
                    <option value="medication intake">Приём лекарств</option>
                    <option value="surgical preparation">Подготовка к операции</option>
                    <option value="surgery">Операция</option>
                    <option value="therapy">Терапия</option>
                </select>
            </th>
            <th class="cell"><textarea name="description1" rows="2" cols="78"></textarea></th>
            <th class="cell">${doctor.getName()} ${doctor.getSurname()}</th>
        </tr>
        <tr id="diagnosis2" hidden>
            <th class="cell" align="center">2</th>
            <th class="cell">
                <select name="select2">
                    <option value="medication intake">Приём лекарств</option>
                    <option value="surgical preparation">Подготовка к операции</option>
                    <option value="surgery">Операция</option>
                    <option value="therapy">Терапия</option>
                </select>
            </th>
            <th class="cell"><<textarea name="description2" rows="2" cols="78"></textarea></th>
            <th class="cell">${doctor.getName()} ${doctor.getSurname()}</th>
        </tr>
        <tr id="diagnosis3" hidden>
            <th class="cell" align="center">3</th>
            <th class="cell">
                <select name="select3">
                    <option value="medication intake">Приём лекарств</option>
                    <option value="surgical preparation">Подготовка к операции</option>
                    <option value="surgery">Операция</option>
                    <option value="therapy">Терапия</option>
                </select>
            </th>
            <th class="cell"><textarea name="description3" rows="2" cols="78"></textarea></th>
            <th class="cell">${doctor.getName()} ${doctor.getSurname()}</th>
        </tr>
        <tr id="diagnosis4" hidden>
            <th class="cell" align="center">4</th>
            <th class="cell">
                <select name="select4">
                    <option value="medication intake">Приём лекарств</option>
                    <option value="surgical preparation">Подготовка к операции</option>
                    <option value="surgery">Операция</option>
                    <option value="therapy">Терапия</option>
                </select>
            </th>
            <th class="cell"><textarea name="description4" rows="2" cols="78"></textarea></th>
            <th class="cell">${doctor.getName()} ${doctor.getSurname()}</th>
        </tr>
        <tr id="diagnosis5" hidden>
            <th class="cell" align="center">5</th>
            <th class="cell">
                <select name="select5">
                    <option value="medication intake">Приём лекарств</option>
                    <option value="surgical preparation">Подготовка к операции</option>
                    <option value="surgery">Операция</option>
                    <option value="therapy">Терапия</option>
                </select>
            </th>
            <th class="cell"><textarea name="description5" rows="2" cols="78"></textarea></th>
            <th class="cell"><p name="responsible">${doctor.getName()} ${doctor.getSurname()}</p></th>
        </tr>
</table>
<p  align="center"><input type="button" value="Добавить процедур" onclick="showForm()"></p>
<p  align="center"><input type="submit" value="Готово"></p>
</form>
<p align="center">Выполнить процедуры</p>
</body>
</html>