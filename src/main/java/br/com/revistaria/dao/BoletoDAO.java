package br.com.revistaria.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import br.com.revistaria.model.Boleto;

public class BoletoDAO {

    public void salvar(Boleto boleto) throws Exception {
        String sql = "INSERT INTO boletos (descricao, valor, vencimento, status) VALUES (?, ?, ?, ?)";

        Connection conn = Conexao.getConexao();
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, boleto.getDescricao());
        ps.setDouble(2, boleto.getValor());
        ps.setDate(3, new java.sql.Date(boleto.getVencimento().getTime()));
        ps.setString(4, boleto.getStatus());

        ps.execute();
        ps.close();
        conn.close();
    }

    public List<Boleto> listar() throws Exception {
        List<Boleto> lista = new ArrayList<>();

        String sql = "SELECT * FROM boletos ORDER BY vencimento ASC";

        Connection conn = Conexao.getConexao();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Boleto b = new Boleto();
            b.setId(rs.getInt("id"));
            b.setDescricao(rs.getString("descricao"));
            b.setValor(rs.getDouble("valor"));
            b.setVencimento(rs.getDate("vencimento"));
            b.setStatus(rs.getString("status"));

            lista.add(b);
        }

        rs.close();
        ps.close();
        conn.close();

        return lista;
    }

    public void marcarComoPago(int id) throws Exception {
        String sql = "UPDATE boletos SET status = 'PAGO' WHERE id = ?";

        Connection conn = Conexao.getConexao();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();

        ps.close();
        conn.close();
    }

    public void excluir(int id) throws Exception {
        String sql = "DELETE FROM boletos WHERE id = ?";

        Connection conn = Conexao.getConexao();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();

        ps.close();
        conn.close();
    }

    public int contarEmAberto() throws Exception {
        String sql = "SELECT COUNT(*) FROM boletos WHERE status = 'PENDENTE'";
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

    public int contarPagos() throws Exception {
        String sql = "SELECT COUNT(*) FROM boletos WHERE status = 'PAGO'";
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

    public int contarVencidos() throws Exception {
        String sql = "SELECT COUNT(*) FROM boletos WHERE status = 'PENDENTE' AND vencimento < CURDATE()";
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

    public int contarVencendo() throws Exception {
        String sql = "SELECT COUNT(*) FROM boletos WHERE status = 'PENDENTE' AND vencimento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 DAY)";
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
}