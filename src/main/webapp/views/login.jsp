<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Sistema Revistaria</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/views/assets/style.css">
</head>
<body class="login-body">

    <div class="login-container">
        <div class="login-card">
            <h1 class="login-title">Sistema Revistaria</h1>
            <p class="login-subtitle">Acesse sua conta</p>

            <form action="<%= request.getContextPath() %>/login" method="post" class="login-form">
                <label>Usuário</label>
                <input type="text" name="login" required>

                <label>Senha</label>
                <input type="password" name="senha" required>

                <button type="submit">Entrar</button>
            </form>

            <%
                String erro = (String) request.getAttribute("erro");
                if (erro != null) {
            %>
                <p class="erro-login"><%= erro %></p>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>