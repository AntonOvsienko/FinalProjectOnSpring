<%--
  Created by IntelliJ IDEA.
  User: ARTDoor
  Date: 31.08.2021
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script>
        function showForm() {
            if (document.getElementById("diagnosis2").hidden == true){
                document.getElementById("diagnosis2").hidden = false;
            } else if (document.getElementById("diagnosis3").hidden == true){
                document.getElementById("diagnosis3").hidden = false;
            } else if (document.getElementById("diagnosis4").hidden == true){
                document.getElementById("diagnosis4").hidden = false;
            } else if (document.getElementById("diagnosis5").hidden == true){
                document.getElementById("diagnosis5").hidden = false;
            } else if (document.getElementById("diagnosis6").hidden == true){
                document.getElementById("diagnosis6").hidden = false;
            }
        }
    </script>
</head>
<body>
<form action="/controller" method="post">
    <input name="command" value="addNewPatient" hidden>
    <p align="center">Номер паспорта: <input name="passport" type="text" required><span></span></p>
    <p align="center">Имя: <input type="text" name="name" required><span></span></p>
    <p align="center">Фамилия: <input type="text" name="surname" required><span></span></p>
    <p align="center">Дата рождения:<input type="date" name="date"/></p>
    <p align="center">Контактный номер: <input type="text" name="telephone" required><span></span></p>
    <p align="center">Первичный диагноз <input type="text" name="diagnosis1" required><span></span></p>
    <p id="diagnosis2" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis2"><span></span></p>
    <p id="diagnosis3" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis3"><span></span></p>
    <p id="diagnosis4" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis4"><span></span></p>
    <p id="diagnosis5" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis5"><span></span></p>
    <p id="diagnosis6" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis6"><span></span></p>
    <p  align="center"><input type="button" value="Добавить поле диагноза" onclick="showForm()"></p>
    <p  align="center"><input type="submit" value="Создать"></p>
</form>
</body>
</html>
