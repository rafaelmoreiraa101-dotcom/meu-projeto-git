<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.revistaria.model.Usuario" %>
<%@ page import="br.com.revistaria.dao.BoletoDAO" %>
<%@ page import="br.com.revistaria.dao.MovimentacaoDAO" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int boletosPendentes = 0;
    int boletosPagos = 0;
    int boletosVencidos = 0;
    int boletosVencendo = 0;

    int movHoje = 0;
    int movMes = 0;
    double valorHoje = 0;
    double valorMes = 0;

    DecimalFormat df = new DecimalFormat("R$ #,##0.00");

    try {
        BoletoDAO boletoDAO = new BoletoDAO();
        boletosPendentes = boletoDAO.contarEmAberto();
        boletosPagos = boletoDAO.contarPagos();
        boletosVencidos = boletoDAO.contarVencidos();
        boletosVencendo = boletoDAO.contarVencendo();

        MovimentacaoDAO movDAO = new MovimentacaoDAO();
        movHoje = movDAO.contarMovimentacoesHoje();
        valorHoje = movDAO.somarValorHoje();
        movMes = movDAO.contarMovimentacoesMes();
        valorMes = movDAO.somarValorMes();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Revistaria</title>
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
    <div class="dashboard-topo">
        <h1>Dashboard</h1>
        <p class="subtitulo-dashboard">Resumo geral do sistema.</p>
    </div>

    <section class="dashboard-secao">
        <h2>Movimentações</h2>
        <div class="resumo-boletos">
            <div class="card-resumo card-pendente">
                <h3>Movimentações hoje</h3>
                <p><%= movHoje %></p>
            </div>

            <div class="card-resumo card-pago">
                <h3>Valor de hoje</h3>
                <p><%= df.format(valorHoje) %></p>
            </div>

            <div class="card-resumo card-alerta">
                <h3>Movimentações no mês</h3>
                <p><%= movMes %></p>
            </div>

            <div class="card-resumo card-vencido">
                <h3>Valor do mês</h3>
                <p><%= df.format(valorMes) %></p>
            </div>
        </div>
    </section>

    <section class="dashboard-secao">
        <h2>Boletos</h2>
        <div class="resumo-boletos">
            <div class="card-resumo card-pendente">
                <h3>Boletos em aberto</h3>
                <p><%= boletosPendentes %></p>
            </div>

            <div class="card-resumo card-pago">
                <h3>Boletos pagos</h3>
                <p><%= boletosPagos %></p>
            </div>

            <div class="card-resumo card-vencido">
                <h3>Boletos vencidos</h3>
                <p><%= boletosVencidos %></p>
            </div>

            <div class="card-resumo card-alerta">
                <h3>Vencem em até 3 dias</h3>
                <p><%= boletosVencendo %></p>
            </div>
        </div>
    </section>
</main>        </div>

    </div>
</body>
</html>