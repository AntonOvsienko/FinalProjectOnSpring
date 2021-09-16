<%@ page session="true"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
    @import url(/users/css/highBanner.css);
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
<form action="/controller" method="post">
    <input name="command" value="addNewPatient" hidden>
    <p align="center">Номер паспорта: <input name="passport" placeholder="AH0000000"
                                             pattern="[А-Яа-яЁё]{2,2}\d{8,8}" type="text" required><span></span></p>
    <p align="center">Имя: <input type="text" name="name" placeholder="Вася или Vasya"
                                  pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required><span></span></p>
    <p align="center">Фамилия: <input type="text" name="surname" placeholder="Левчий или Levchiy"
                                      pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required><span></span></p>
    <p align="center">Дата рождения:<input type="date" name="date"/></p>
    <p align="center"><input id="online_phone" name="telephone" type="tel" maxlength="50"
                             pattern="[0-9]{12,12}"
                             placeholder="Номер телефона"
                             name="telephone"></p>
    <p align="center">Первичный диагноз <input type="text" name="diagnosis1" required><span></span></p>
    <p id="diagnosis2" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis2"><span></span></p>
    <p id="diagnosis3" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis3"><span></span></p>
    <p id="diagnosis4" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis4"><span></span></p>
    <p id="diagnosis5" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis5"><span></span></p>
    <p id="diagnosis6" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis6"><span></span></p>
    <p align="center"><input type="button" value="Добавить поле диагноза" onclick="showForm()"></p>
    <p align="center"><input type="submit" value="Создать"></p>
</form>
<form><p align="center">
    <input name="command" value="redirect" hidden>
    <input name="address" value="users/doctorList.jsp" hidden>
    <input type="submit" value="Назад">
</p></form>
</body>
</html>
