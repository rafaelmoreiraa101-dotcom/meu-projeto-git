<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.revistaria.model.Usuario" %>
<%@ page import="br.com.revistaria.model.Movimentacao" %>
<%@ page import="br.com.revistaria.dao.MovimentacaoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Movimentacao> listaMovimentacoes = null;
    try {
        MovimentacaoDAO movimentacaoDAO = new MovimentacaoDAO();
        listaMovimentacoes = movimentacaoDAO.listar();
    } catch (Exception e) {
        e.printStackTrace();
    }

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Movimentações - Revistaria</title>
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

            <div class="content">
                <div class="card" style="max-width: 100%; width: 100%;">
                    <h1>Movimentações</h1>
                    <p>Gerencie as vendas e movimentações do sistema.</p>

                    <div class="card" style="max-width: 100%; width: 100%; margin-top: 20px;">
                        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px; flex-wrap:wrap; gap:10px;">
                            <h3>Lista de Movimentações</h3>
                            <a href="nova-movimentacao.jsp" class="btn-primary">+ Nova Movimentação</a>
                        </div>

                        <table class="tabela">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tipo</th>
                                    <th>Item</th>
                                    <th>Quantidade</th>
                                    <th>Valor Unitário</th>
                                    <th>Total</th>
                                    <th>Data</th>
                                    <th>Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (listaMovimentacoes != null && !listaMovimentacoes.isEmpty()) {
                                        for (Movimentacao mov : listaMovimentacoes) {
                                %>
                                <tr>
                                    <td><%= mov.getId() %></td>
                                    <td><%= mov.getTipo() %></td>
                                    <td><%= mov.getNomeProduto() != null ? mov.getNomeProduto() : mov.getNomeAvulso() %></td>
                                    <td><%= mov.getQuantidade() %></td>
                                    <td>R$ <%= mov.getValorUnitario() %></td>
                                    <td>R$ <%= mov.getValorTotal() %></td>
                                    <td><%= sdf.format(mov.getDataMovimentacao()) %></td>
                                    <td>
    <a href="<%= request.getContextPath() %>/MovimentacaoServlet?acao=excluir&id=<%= mov.getId() %>"
       class="btn-acao excluir"
       onclick="return confirm('Tem certeza que deseja excluir esta movimentação?')">
       Excluir
    </a>
</td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="8" style="text-align:center;">Nenhuma movimentação cadastrada.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>

</body>
</html>