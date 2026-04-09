/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author lucas
 */
public class PagamentoModel {

    private int id;
    private double valor;
    private String formaPagamento;

    public int getId() {
        return id;
    }

    public double getValor() {
        return valor;
    }

    public String getFormaPagamento() {
        return formaPagamento;
    }

    public PagamentoModel() {
    }

    public static PagamentoBuilder getBuilder() {
        return new PagamentoBuilder();
    }

    public static class PagamentoBuilder {

        private PagamentoModel pagamento = new PagamentoModel();

        public PagamentoBuilder comId(int id) {
            pagamento.id = id;
            return this;
        }

        public PagamentoBuilder comValor(double valor) {
            pagamento.valor = valor;
            return this;
        }

        public PagamentoBuilder comFormaPagamento(String formaPagamento) {
            pagamento.formaPagamento = formaPagamento;
            return this;
        }

        public PagamentoModel constroi() {
            return pagamento;
        }
    }
}
