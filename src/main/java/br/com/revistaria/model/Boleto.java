package br.com.revistaria.model;

import java.util.Date;

public class Boleto {
    
    private int id;
    private String descricao;
    private double valor;
    private Date vencimento;
    private String status;
    
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getDescricao() {
        return descricao;
    }
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    public double getValor() {
        return valor;
    }
    public void setValor(double valor) {
        this.valor = valor;
    }
    public Date getVencimento() {
        return vencimento;
    }
    public void setVencimento(Date vencimento) {
        this.vencimento = vencimento;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}