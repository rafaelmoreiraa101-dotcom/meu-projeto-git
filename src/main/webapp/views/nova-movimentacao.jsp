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
    <title>Nova Movimentação - Revistaria</title>
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
 <div class="form-box">
    <h2>Nova Movimentação</h2>
    <p class="form-subtitle">Registre uma venda de produto ou uma venda online/avulsa.</p>

    <% if ("estoque".equals(request.getParameter("erro"))) { %>
        <p class="erro-form">Quantidade maior que o estoque disponível.</p>
    <% } %>

    <form action="<%= request.getContextPath() %>/MovimentacaoServlet" method="post">

        <div class="campo">
            <label for="tipo">Tipo de movimentação</label>
            <select name="tipo" id="tipo" onchange="alternarCampos()" required>
                <option value="saida_estoque">Saída de estoque</option>
                <option value="saida_avulsa">Venda online/avulsa</option>
            </select>
        </div>

        <div class="campo full" id="campoProduto">
            <label for="produtoId">Produto</label>
            <select name="produtoId" id="produtoId">
                <option value="">Selecione um produto</option>
                <%
                    if (listaProdutos != null) {
                        for (Produto produto : listaProdutos) {
                %>
                    <option value="<%= produto.getId() %>">
                        <%= produto.getNome() %> - Estoque: <%= produto.getQuantidade() %> - R$ <%= produto.getPreco() %>
                    </option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div class="campo full" id="campoAvulso" style="display:none;">
            <label for="nomeAvulso">Nome da venda online/avulsa</label>
            <input type="text" name="nomeAvulso" id="nomeAvulso">
        </div>

        <div class="campo">
            <label for="quantidade">Quantidade</label>
            <input type="number" name="quantidade" id="quantidade" min="1" required>
        </div>

        <div class="campo" id="campoValorAvulso" style="display:none;">
            <label for="valorUnitario">Valor unitário</label>
            <input type="number" name="valorUnitario" id="valorUnitario" step="0.01" min="0">
        </div>

        <div class="botoes">
            <button type="submit">Salvar Movimentação</button>
            <a href="movimentacao.jsp" class="btn-secundario">Cancelar</a>
        </div>
    </form>
</div>
        </main>
    </div>
</div>

<script>
    function alternarCampos() {
        var tipo = document.getElementById("tipo").value;
        var campoProduto = document.getElementById("campoProduto");
        var campoAvulso = document.getElementById("campoAvulso");
        var campoValorAvulso = document.getElementById("campoValorAvulso");

        var produtoId = document.getElementById("produtoId");
        var nomeAvulso = document.getElementById("nomeAvulso");
        var valorUnitario = document.getElementById("valorUnitario");

        if (tipo === "saida_estoque") {
            campoProduto.style.display = "block";
            campoAvulso.style.display = "none";
            campoValorAvulso.style.display = "none";

            produtoId.setAttribute("required", "required");
            nomeAvulso.removeAttribute("required");
            valorUnitario.removeAttribute("required");
        } else {
            campoProduto.style.display = "none";
            campoAvulso.style.display = "block";
            campoValorAvulso.style.display = "block";

            produtoId.removeAttribute("required");
            nomeAvulso.setAttribute("required", "required");
            valorUnitario.setAttribute("required", "required");
        }
    }

    window.onload = alternarCampos;
</script>

</body>
</html>