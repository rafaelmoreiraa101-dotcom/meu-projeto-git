<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.revistaria.model.Usuario" %>
<%@ page import="br.com.revistaria.model.Produto" %>
<%@ page import="br.com.revistaria.dao.ProdutoDAO" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Produto> listaProdutos = null;
    try {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        listaProdutos = produtoDAO.listar();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Produtos - Revistaria</title>
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
                <h1>Produtos</h1>
                <p>Gerencie os produtos cadastrados no sistema.</p>

                <div class="card">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                        <h3>Lista de Produtos</h3>
                        <a href="novo-produto.jsp" class="btn-primary">+ Novo Produto</a>
                    </div>

                    <table class="tabela">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Quantidade</th>
                                <th>Preço</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
<%
    if (listaProdutos != null && !listaProdutos.isEmpty()) {
        for (Produto produto : listaProdutos) {
%>
<tr>
    <td><%= produto.getId() %></td>
    <td><%= produto.getNome() %></td>
    <td><%= produto.getQuantidade() %></td>
    <td>R$ <%= produto.getPreco() %></td>
<td>
    <a href="editar-produto.jsp?id=<%= produto.getId() %>" class="btn-acao editar">Editar</a>

    <form action="<%= request.getContextPath() %>/ProdutoServlet" method="post" style="display:inline;">
        <input type="hidden" name="acao" value="excluir">
        <input type="hidden" name="id" value="<%= produto.getId() %>">
        <button type="submit" class="btn-acao excluir" 
                onclick="return confirm('Tem certeza que deseja excluir este produto?');">
            Excluir
        </button>
    </form>
</td>
</tr>
<%
        }
    } else {
%>
<tr>
    <td colspan="5" style="text-align:center;">Nenhum produto cadastrado.</td>
</tr>
<%
    }
%>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>

    </div>

</body>
</html>