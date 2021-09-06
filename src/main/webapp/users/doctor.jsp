<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<body>
<h1>Hello Doctor</h1>
<h3>
    Login:${globalLogin}<br>
    Name:${name}<br>
    Surname:${surname}<br>
    Passport:${passport}<br>
</h3>
<form id="auth" action="/controller" method="get">
    <input name="address" value="users/updateAccount.jsp" hidden>
    <p><input type="submit" value="Обновить профиль"></p>
</form>
<form id="auth1" action="controller" method="get">
    <input name="command" value="exit" hidden>
    <p><input type="submit" value="Закончить сессию"></p>
</form>
</body>
</html>