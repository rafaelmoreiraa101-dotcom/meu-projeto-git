package br.com.revistaria.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;

import br.com.revistaria.dao.BoletoDAO;
import br.com.revistaria.model.Boleto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BoletoServlet")
public class BoletoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        try {
            BoletoDAO dao = new BoletoDAO();

            if ("salvar".equals(acao)) {
                Boleto boleto = new Boleto();
                boleto.setDescricao(request.getParameter("descricao"));
                boleto.setValor(Double.parseDouble(request.getParameter("valor")));
                boleto.setVencimento(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("vencimento")));
                boleto.setStatus("PENDENTE");

                dao.salvar(boleto);
            } else if ("pagar".equals(acao)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.marcarComoPago(id);
            } else if ("excluir".equals(acao)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.excluir(id);
            }

            response.sendRedirect("views/boletos.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().append("Erro: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}