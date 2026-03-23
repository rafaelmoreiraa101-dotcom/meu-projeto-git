<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.revistaria.model.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.revistaria.dao.BoletoDAO" %>
<%@ page import="br.com.revistaria.model.Boleto" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%
    BoletoDAO dao = new BoletoDAO();
    List<Boleto> lista = dao.listar();

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    Date hoje = new Date();
    
    DecimalFormat df = new DecimalFormat("0.00");
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Boletos - Revistaria</title>
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
                <h1>Boletos</h1>
                <p>Gerencie os boletos cadastrados no sistema.</p>

                <div class="card">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                        <h3>Lista de Boletos</h3>
                        <a href="novo-boleto.jsp" class="btn-primary">+ Novo Boleto</a>
                    </div>

                    <table class="tabela">
                        <thead>
    <tr>
        <th>ID</th>
        <th>Descrição</th>
        <th>Valor</th>
        <th>Vencimento</th>
        <th>Status</th>
        <th>Ações</th>
    </tr>
</thead>
<tbody>
<%
    for (Boleto b : lista) {
        long diferencaMillis = b.getVencimento().getTime() - hoje.getTime();
        long dias = diferencaMillis / (1000 * 60 * 60 * 24);

        String classeLinha = "";
        String textoStatus = "";
        String classeStatus = "";

        if ("PAGO".equalsIgnoreCase(b.getStatus())) {
            classeLinha = "linha-pago";
            textoStatus = "Pago";
            classeStatus = "pago";
        } else if (dias <= 1) {
            classeLinha = "linha-atrasado";
            textoStatus = "Urgente";
            classeStatus = "atrasado";
        } else if (dias <= 3) {
            classeLinha = "linha-alerta";
            textoStatus = "Vence em breve";
            classeStatus = "alerta";
        } else {
            textoStatus = "Pendente";
            classeStatus = "pendente";
        }
%>
<tr class="<%= classeLinha %>">
    <td><%= b.getId() %></td>
    <td><%= b.getDescricao() %></td>
    <td>R$ <%= df.format(b.getValor()).replace(".", ",") %></td>
    <td><%= sdf.format(b.getVencimento()) %></td>
    <td>
        <span class="status <%= classeStatus %>"><%= textoStatus %></span>
    </td>
    <td>
        <% if (!"PAGO".equalsIgnoreCase(b.getStatus())) { %>
            <form action="../BoletoServlet" method="post" style="display:inline;">
                <input type="hidden" name="acao" value="pagar">
                <input type="hidden" name="id" value="<%= b.getId() %>">
                <button type="submit" class="btn-table btn-success">Pagar</button>
            </form>
        <% } %>

        <form action="../BoletoServlet" method="post" style="display:inline;" onsubmit="return confirm('Deseja excluir este boleto?');">
            <input type="hidden" name="acao" value="excluir">
            <input type="hidden" name="id" value="<%= b.getId() %>">
            <button type="submit" class="btn-table btn-danger">Excluir</button>
        </form>
    </td>
</tr>
<%
    }
%>
</tbody>
</html>