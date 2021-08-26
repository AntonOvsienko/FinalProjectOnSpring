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

<h1>Hello Admin</h1>
<p><input type="submit" onclick="showForm()" value="Создать логин"></p>
<form id="auth" action="controller" method="get" hidden>
    <input name="command" value="newStaff" hidden>
    <p><label>Логин: <input name="login" value="admin" required></label></p>
    <p><label>Пароль: <input name="password" type="password" value="12345" required></label></p>
    <p><label>Повторить пароль: <input name="password_repeat" type="password" value="12345" required></label></p>
    <p><select name="role">
        <option disabled>Select position</option>
        <option value="doctor">doctor</option>
        <option value="nurse">nurse</option>
    </select></p>
    <p><input type="submit" value="Создать"></p>
</form>
<p><input type="submit" onclick="showForm()" value="Удалить логин"></p>
</body>
</html>