package br.com.revistaria.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Movimentacao {
    private int id;
    private Integer produtoId;
    private String tipo;
    private String nomeAvulso;
    private String nomeProduto;
    private int quantidade;
    private BigDecimal valorUnitario;
    private BigDecimal valorTotal;
    private Timestamp dataMovimentacao;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getProdutoId() {
        return produtoId;
    }

    public void setProdutoId(Integer produtoId) {
        this.produtoId = produtoId;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getNomeAvulso() {
        return nomeAvulso;
    }

    public void setNomeAvulso(String nomeAvulso) {
        this.nomeAvulso = nomeAvulso;
    }

    public String getNomeProduto() {
        return nomeProduto;
    }

    public void setNomeProduto(String nomeProduto) {
        this.nomeProduto = nomeProduto;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public BigDecimal getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(BigDecimal valorUnitario) {
        this.valorUnitario = valorUnitario;
    }

    public BigDecimal getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(BigDecimal valorTotal) {
        this.valorTotal = valorTotal;
    }

    public Timestamp getDataMovimentacao() {
        return dataMovimentacao;
    }

    public void setDataMovimentacao(Timestamp dataMovimentacao) {
        this.dataMovimentacao = dataMovimentacao;
    }
}