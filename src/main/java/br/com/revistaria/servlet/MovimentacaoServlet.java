package br.com.revistaria.servlet;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import br.com.revistaria.dao.MovimentacaoDAO;
import br.com.revistaria.dao.ProdutoDAO;
import br.com.revistaria.model.Movimentacao;
import br.com.revistaria.model.Produto;

@WebServlet("/MovimentacaoServlet")
public class MovimentacaoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        if ("excluir".equals(acao)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));

                MovimentacaoDAO dao = new MovimentacaoDAO();
                dao.excluir(id);

            } catch (Exception e) {
                e.printStackTrace();
            }

            response.sendRedirect(request.getContextPath() + "/views/movimentacao.jsp");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/views/movimentacao.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String tipo = request.getParameter("tipo");
            int quantidade = Integer.parseInt(request.getParameter("quantidade"));

            Movimentacao mov = new Movimentacao();
            mov.setTipo(tipo);
            mov.setQuantidade(quantidade);

            MovimentacaoDAO movDAO = new MovimentacaoDAO();

            if ("saida_estoque".equals(tipo)) {
                int produtoId = Integer.parseInt(request.getParameter("produtoId"));

                ProdutoDAO produtoDAO = new ProdutoDAO();
                Produto produto = produtoDAO.buscarPorId(produtoId);

                if (produto == null) {
                    response.sendRedirect(request.getContextPath() + "/views/nova-movimentacao.jsp");
                    return;
                }

                if (quantidade > produto.getQuantidade()) {
                    response.sendRedirect(request.getContextPath() + "/views/nova-movimentacao.jsp?erro=estoque");
                    return;
                }

                BigDecimal valorUnitario = produto.getPreco();
                BigDecimal valorTotal = valorUnitario.multiply(new BigDecimal(quantidade));

                mov.setProdutoId(produtoId);
                mov.setNomeAvulso(null);
                mov.setValorUnitario(valorUnitario);
                mov.setValorTotal(valorTotal);

                movDAO.salvar(mov);
                movDAO.baixarEstoque(produtoId, quantidade);

            } else if ("saida_avulsa".equals(tipo)) {
                String nomeAvulso = request.getParameter("nomeAvulso");
                BigDecimal valorUnitario = new BigDecimal(request.getParameter("valorUnitario"));
                BigDecimal valorTotal = valorUnitario.multiply(new BigDecimal(quantidade));

                mov.setProdutoId(null);
                mov.setNomeAvulso(nomeAvulso);
                mov.setValorUnitario(valorUnitario);
                mov.setValorTotal(valorTotal);

                movDAO.salvar(mov);
            }

            response.sendRedirect(request.getContextPath() + "/views/movimentacao.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("Erro ao salvar movimentação: " + e.getMessage());
        }
    }
}