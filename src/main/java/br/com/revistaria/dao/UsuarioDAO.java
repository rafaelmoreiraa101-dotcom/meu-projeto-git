package br.com.revistaria.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import br.com.revistaria.model.Usuario;

public class UsuarioDAO {

	public Usuario login(String login, String senha) {
	    String sql = "SELECT * FROM usuario WHERE login = ? AND senha = ?";

	    try (Connection conn = Conexao.getConexao();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setString(1, login);
	        stmt.setString(2, senha);

	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	            Usuario usuario = new Usuario();
	            usuario.setId(rs.getInt("id"));
	            usuario.setLogin(rs.getString("login"));
	            usuario.setSenha(rs.getString("senha"));
	            return usuario;
	        }

	    } catch (Exception e) {
	        System.out.println("ERRO NO DAO: " + e.getMessage());
	        throw new RuntimeException(e);
	    }

	    return null;
	}
}