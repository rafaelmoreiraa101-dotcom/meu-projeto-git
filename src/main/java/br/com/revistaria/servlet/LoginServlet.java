package br.com.revistaria.servlet;

import java.io.IOException;

import br.com.revistaria.dao.UsuarioDAO;
import br.com.revistaria.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String login = request.getParameter("login");
            String senha = request.getParameter("senha");

            if (login != null) login = login.trim();
            if (senha != null) senha = senha.trim();

            System.out.println("LOGIN DIGITADO: [" + login + "]");
            System.out.println("SENHA DIGITADA: [" + senha + "]");

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            System.out.println("ANTES DE CHAMAR DAO");
            Usuario usuario = usuarioDAO.login(login, senha);
            System.out.println("DEPOIS DE CHAMAR DAO");

            System.out.println("USUARIO RETORNADO: " + usuario);

            if (usuario != null) {
                HttpSession sessao = request.getSession();
                sessao.setAttribute("usuarioLogado", usuario);
                response.sendRedirect("views/dashboard.jsp");
            } else {
                request.setAttribute("erro", "Usuário ou senha inválidos.");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erro no login: " + e.getMessage());
        }
    }
}