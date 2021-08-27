<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <script>
        function showForm() {
            if (document.getElementById("auth").hidden == false) {
                document.getElementById("auth").hidden = true;
            } else {
                document.getElementById("auth").hidden = false;
            }
        }
    </script>
</head>
<body>

<h1 align="center">Hello Admin</h1>
<p align="center"><input type="submit" onclick="showForm()" value="Создать логин"></p>
<form id="auth" action="controller" method="post" hidden>
    <hr align="center" width="400" size="2" color="#ff0000" />
    <input name="command" value="newStaff" hidden>
    <p align="center"><label>Логин: <input name="login" value="admin" required></label></p>
    <p align="center"><label>Пароль: <input name="password" type="password" value="12345" required></label></p>
    <p align="center"><label>Повторить пароль: <input name="password_repeat" type="password" value="12345" required></label></p>
    <p align="center"><label>Должность:<select name="role">
        <option disabled>Select position</option>
        <option value="doctor">doctor</option>
        <option value="nurse">nurse</option>
    </select></label></p>
    <p align="center"><input type="submit" value="Создать"></p>
    <hr align="center" width="400" size="2" color="#ff0000" />
</form>
<form id="auth2" action="controller" method="get">
    <input name="command" value="exit" hidden>
    <p align="center"><input type="submit" value="Закончить сессию"></p>
</form>
<p align="center"><input type="submit" onclick="showForm()" value="Удалить логин"></p>
</body>
</html>