<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.revistaria.model.Usuario" %>
<%@ page import="br.com.revistaria.model.Produto" %>
<%@ page import="br.com.revistaria.dao.ProdutoDAO" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Produto produto = null;

    try {
        int id = Integer.parseInt(request.getParameter("id"));
        ProdutoDAO dao = new ProdutoDAO();
        produto = dao.buscarPorId(id);
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (produto == null) {
        response.sendRedirect("produtos.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Editar Produto - Revistaria</title>
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
            <h1>Editar Produto</h1>

            <div class="card">
                <form action="<%= request.getContextPath() %>/ProdutoServlet" method="post">
                    <input type="hidden" name="acao" value="editar">
                    <input type="hidden" name="id" value="<%= produto.getId() %>">

                    <div style="margin-bottom:16px;">
                        <label>Nome do produto</label><br>
                        <input type="text" name="nome" value="<%= produto.getNome() %>" required
                               style="width:100%; padding:10px; margin-top:6px;">
                    </div>

                    <div style="margin-bottom:16px;">
                        <label>Quantidade</label><br>
                        <input type="number" name="quantidade" value="<%= produto.getQuantidade() %>" required
                               style="width:100%; padding:10px; margin-top:6px;">
                    </div>

                    <div style="margin-bottom:20px;">
                        <label>Preço</label><br>
                        <input type="number" step="0.01" name="preco" value="<%= produto.getPreco() %>" required
                               style="width:100%; padding:10px; margin-top:6px;">
                    </div>

                    <div style="display:flex; gap:10px;">
                        <button type="submit" class="btn-primary">Salvar Alterações</button>
                        <a href="produtos.jsp" class="btn-acao editar">Cancelar</a>
                    </div>
                </form>
            </div>
        </main>
    </div>

</div>

</body>
</html>