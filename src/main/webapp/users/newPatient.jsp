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
    <script type="text/javascript">
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

            function setCursorPosition(pos, e) {
            e.focus();
            if (e.setSelectionRange) e.setSelectionRange(pos, pos);
            else if (e.createTextRange) {
            var range = e.createTextRange();
            range.collapse(true);
            range.moveEnd("character", pos);
            range.moveStart("character", pos);
            range.select()
        }
        }

            function mask(e) {
            //console.log('mask',e);
            var matrix = this.placeholder,// .defaultValue
            i = 0,
            def = matrix.replace(/\D/g, ""),
            val = this.value.replace(/\D/g, "");
            def.length >= val.length && (val = def);
            matrix = matrix.replace(/[_\d]/g, function (a) {
            return val.charAt(i++) || "_"
        });
            this.value = matrix;
            i = matrix.lastIndexOf(val.substr(-1));
            i < matrix.length && matrix != this.placeholder ? i++ : i = matrix.indexOf("_");
            setCursorPosition(i, this)
        }

            window.addEventListener("DOMContentLoaded", function () {
            var input = document.querySelector("#online_phone");
            input.addEventListener("input", mask, false);
            input.focus();
            setCursorPosition(3, input);
        });
    </script>
</head>
<body>
<form action="/controller" method="post">
    <input name="command" value="addNewPatient" hidden>
    <p align="center">Номер паспорта: <input name="passport" placeholder="AH0000000"
                                             pattern="[А-Яа-яЁё]{2,2}\d{7,7}" type="text" required><span></span></p>
    <p align="center">Имя: <input type="text" name="name" placeholder="Вася или Vasya"
                                  pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required><span></span></p>
    <p align="center">Фамилия: <input type="text" name="surname" placeholder="Левчий или Levchiy"
                                      pattern="([А-Яа-яЁё]+)|([A-Za-z]+)" required><span></span></p>
    <p align="center">Дата рождения:<input type="date" name="date"/></p>
    <p align="center">Контактный номер: <input id="online_phone" name="phone" type="tel" maxlength="50"
                                               autofocus="autofocus" value="+3(__)___-__-__"
                                               pattern="\+3\s?[\(]{0,1}9[0-9]{2}[\)]{0,1}\s?\d{3}[-]{0,1}\d{2}[-]{0,1}\d{2}"
                                               placeholder="+3(___)___-__-__"
                                               name="telephone"></p>
    <p align="center">Первичный диагноз <input type="text" name="diagnosis1" required><span></span></p>
    <p id="diagnosis2" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis2"><span></span></p>
    <p id="diagnosis3" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis3"><span></span></p>
    <p id="diagnosis4" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis4"><span></span></p>
    <p id="diagnosis5" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis5"><span></span></p>
    <p id="diagnosis6" align="center" hidden>Первичный диагноз <input type="text" name="diagnosis6"><span></span></p>
    <p  align="center"><input type="button" value="Добавить поле диагноза" onclick="showForm()"></p>
    <p  align="center"><input type="submit" value="Создать"></p>

</form>
<form><p align="center">
    <input name="command" value="redirect" hidden>
    <input name="address" value="users/doctorList.jsp" hidden>
    <input type="submit" value="Назад">
</p></form>
</body>
</html>
