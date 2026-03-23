<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.revistaria.model.Usuario" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Novo Boleto - Revistaria</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>

<div class="layout">
    <aside class="sidebar">
        <h2>Revistaria</h2>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="produtos.jsp">Produtos</a>
        <a href="movimentacao.jsp">Movimentações</a>
        <a href="boletos.jsp">Boletos</a>
    </aside>

    <div class="main">
        <header class="header">
            <span>Bem-vindo, <%= usuarioLogado.getLogin() %></span>
        </header>

        <main class="content">
            <h1>Novo Boleto</h1>
            <p>Cadastre um novo boleto no sistema.</p>

            <div class="card form-card">
                <form action="../BoletoServlet" method="post">
                    <input type="hidden" name="acao" value="salvar">

                    <div class="form-group">
                        <label for="descricao">Descrição</label>
                        <input type="text" id="descricao" name="descricao" placeholder="Ex: Fornecedor de revistas" required>
                    </div>

                    <div class="form-group">
                        <label for="valor">Valor</label>
                        <input type="number" id="valor" name="valor" step="0.01" placeholder="Ex: 150.00" required>
                    </div>

                    <div class="form-group">
                        <label for="vencimento">Vencimento</label>
                        <input type="date" id="vencimento" name="vencimento" required>
                    </div>

                    <div class="form-actions">
                        <a href="boletos.jsp" class="btn-secondary">Cancelar</a>
                        <button type="submit" class="btn-primary">Salvar Boleto</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>

</body>
</html>