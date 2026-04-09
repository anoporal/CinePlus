/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author lucas
 */
public class IngressoModel {

    private int id;
    private SessaoModel sessao;
    private ClienteModel cliente;
    private PagamentoModel pagamento;

    public int getId() {
        return id;
    }

    public ClienteModel getCliente() {
        return cliente;
    }

    public PagamentoModel getPagamento() {
        return pagamento;
    }

    public SessaoModel getSessao() {
        return sessao;
    }

    public IngressoModel() {
    }

    public static IngressoBuilder getBuilder() {
        return new IngressoBuilder();
    }

    public static class IngressoBuilder {

        private IngressoModel ingresso = new IngressoModel();

        public IngressoBuilder comId(int id) {
            ingresso.id = id;
            return this;
        }

        public IngressoBuilder comCliente(ClienteModel cliente) {
            ingresso.cliente = cliente;
            return this;
        }

        public IngressoBuilder comPagamento(PagamentoModel pagamento) {
            ingresso.pagamento = pagamento;
            return this;
        }

        public IngressoBuilder comSessao(SessaoModel sessao) {
            ingresso.sessao = sessao;
            return this;
        }

        public IngressoModel constroi() {
            return ingresso;
        }
    }
}
