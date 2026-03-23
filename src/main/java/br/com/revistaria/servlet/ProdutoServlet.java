package br.com.revistaria.servlet;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import br.com.revistaria.dao.ProdutoDAO;
import br.com.revistaria.model.Produto;

@WebServlet("/ProdutoServlet")
public class ProdutoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String acao = request.getParameter("acao");

            ProdutoDAO dao = new ProdutoDAO();

            if ("editar".equals(acao)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String nome = request.getParameter("nome");
                int quantidade = Integer.parseInt(request.getParameter("quantidade"));
                BigDecimal preco = new BigDecimal(request.getParameter("preco"));

                Produto p = new Produto();
                p.setId(id);
                p.setNome(nome);
                p.setQuantidade(quantidade);
                p.setPreco(preco);

                dao.atualizar(p);

            } else if ("excluir".equals(acao)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.excluir(id);

            } else {
                String nome = request.getParameter("nome");
                int quantidade = Integer.parseInt(request.getParameter("quantidade"));
                BigDecimal preco = new BigDecimal(request.getParameter("preco"));

                Produto p = new Produto();
                p.setNome(nome);
                p.setQuantidade(quantidade);
                p.setPreco(preco);

                dao.salvar(p);
            }

            response.sendRedirect(request.getContextPath() + "/views/produtos.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}