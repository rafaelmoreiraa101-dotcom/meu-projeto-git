package br.com.revistaria.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import br.com.revistaria.model.Movimentacao;

public class MovimentacaoDAO {
	
	public void excluir(int id) throws Exception {
	    String sql = "DELETE FROM movimentacoes WHERE id = ?";

	    Connection conn = Conexao.getConexao();
	    PreparedStatement ps = conn.prepareStatement(sql);

	    ps.setInt(1, id);
	    ps.executeUpdate();

	    ps.close();
	    conn.close();
	}

    public void salvar(Movimentacao mov) throws Exception {
        String sql = "INSERT INTO movimentacoes (produto_id, tipo, nome_avulso, quantidade, valor_unitario, valor_total) VALUES (?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = Conexao.getConexao();
            stmt = conn.prepareStatement(sql);

            if (mov.getProdutoId() != null) {
                stmt.setInt(1, mov.getProdutoId());
            } else {
                stmt.setNull(1, java.sql.Types.INTEGER);
            }

            stmt.setString(2, mov.getTipo());
            stmt.setString(3, mov.getNomeAvulso());
            stmt.setInt(4, mov.getQuantidade());
            stmt.setBigDecimal(5, mov.getValorUnitario());
            stmt.setBigDecimal(6, mov.getValorTotal());

            stmt.executeUpdate();

        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public void baixarEstoque(int produtoId, int quantidadeVendida) throws Exception {
        String sql = "UPDATE produtos SET quantidade = quantidade - ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = Conexao.getConexao();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, quantidadeVendida);
            stmt.setInt(2, produtoId);
            stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }

    public List<Movimentacao> listar() throws Exception {
        String sql = "SELECT m.*, p.nome AS nome_produto FROM movimentacoes m " +
                     "LEFT JOIN produtos p ON m.produto_id = p.id " +
                     "ORDER BY m.id DESC";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        List<Movimentacao> lista = new ArrayList<>();

        try {
            conn = Conexao.getConexao();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Movimentacao mov = new Movimentacao();

                mov.setId(rs.getInt("id"));
                mov.setProdutoId((Integer) rs.getObject("produto_id"));
                mov.setTipo(rs.getString("tipo"));
                mov.setNomeAvulso(rs.getString("nome_avulso"));
                mov.setQuantidade(rs.getInt("quantidade"));
                mov.setValorUnitario(rs.getBigDecimal("valor_unitario"));
                mov.setValorTotal(rs.getBigDecimal("valor_total"));
                mov.setDataMovimentacao(rs.getTimestamp("data_movimentacao"));
                mov.setNomeProduto(rs.getString("nome_produto"));

                lista.add(mov);
            }

        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }

        return lista;
    }
    
    public int contarMovimentacoesHoje() throws Exception {
        String sql = "SELECT COUNT(*) FROM movimentacoes WHERE DATE(data_movimentacao) = CURDATE()";

        Connection conn = Conexao.getConexao();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        int total = 0;
        if (rs.next()) {
            total = rs.getInt(1);
        }

        rs.close();
        ps.close();
        conn.close();

        return total;
    }

    public double somarValorHoje() throws Exception {
        String sql = "SELECT COALESCE(SUM(valor_total), 0) FROM movimentacoes WHERE DATE(data_movimentacao) = CURDATE()";

        Connection conn = Conexao.getConexao();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        double total = 0;
        if (rs.next()) {
            total = rs.getDouble(1);
        }

        rs.close();
        ps.close();
        conn.close();

        return total;
    }

    public int contarMovimentacoesMes() throws Exception {
        String sql = "SELECT COUNT(*) FROM movimentacoes WHERE MONTH(data_movimentacao) = MONTH(CURDATE()) AND YEAR(data_movimentacao) = YEAR(CURDATE())";

        Connection conn = Conexao.getConexao();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        int total = 0;
        if (rs.next()) {
            total = rs.getInt(1);
        }

        rs.close();
        ps.close();
        conn.close();

        return total;
    }

    public double somarValorMes() throws Exception {
        String sql = "SELECT COALESCE(SUM(valor_total), 0) FROM movimentacoes WHERE MONTH(data_movimentacao) = MONTH(CURDATE()) AND YEAR(data_movimentacao) = YEAR(CURDATE())";

        Connection conn = Conexao.getConexao();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        double total = 0;
        if (rs.next()) {
            total = rs.getDouble(1);
        }

        rs.close();
        ps.close();
        conn.close();

        return total;
    }
}