<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Novo Produto - Revistaria</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/views/assets/style.css">
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
                <h1>Novo Produto</h1>
                <p>Cadastre um novo produto no sistema.</p>

                <div class="card">
                    <form action="<%= request.getContextPath() %>/ProdutoServlet" method="post">
                        
                        <div style="margin-bottom: 16px;">
                            <label for="nome">Nome do produto</label><br>
                            <input type="text" id="nome" name="nome" required
                                   style="width:100%; padding:10px; margin-top:6px;">
                        </div>

                        <div style="margin-bottom: 16px;">
                            <label for="quantidade">Quantidade</label><br>
                            <input type="number" id="quantidade" name="quantidade" min="0" required
                                   style="width:100%; padding:10px; margin-top:6px;">
                        </div>

                        <div style="margin-bottom: 20px;">
                            <label for="preco">Preço</label><br>
                            <input type="number" id="preco" name="preco" step="0.01" min="0" required
                                   style="width:100%; padding:10px; margin-top:6px;">
                        </div>

                        <div style="display:flex; gap:10px;">
                            <button type="submit" class="btn-primary">Salvar Produto</button>
                            <a href="produtos.jsp" class="btn-acao editar">Cancelar</a>
                        </div>

                    </form>
                </div>
            </main>
        </div>

    </div>

</body>
</html>