/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author lucas
 */
public class ClienteModel {

    private int id;
    private String nome;
    private String email;
    private String telefone;
    private List<IngressoModel> ingressos;

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getEmail() {
        return email;
    }

    public String getTelefone() {
        return telefone;
    }

    public List<IngressoModel> getIngressos() {
        return ingressos;
    }

    public void comprarIngresso(List<IngressoModel> ingressos) {
        this.ingressos = ingressos;
    }

    public ClienteModel() {
    }

    public static ClienteBuilder getBuilder() {
        return new ClienteBuilder();
    }

    public static class ClienteBuilder {

        private final ClienteModel cliente = new ClienteModel();

        public ClienteBuilder comId(int id) {
            cliente.id = id;
            return this;
        }

        public ClienteBuilder comNome(String nome) {
            cliente.nome = nome;
            return this;
        }

        public ClienteBuilder comEmail(String email) {
            cliente.email = email;
            return this;
        }

        public ClienteBuilder comTelefone(String telefone) {
            cliente.telefone = telefone;
            return this;
        }

        public ClienteBuilder comIngressos(List<IngressoModel> ingressos) {
            cliente.ingressos = ingressos;
            return this;
        }

        public ClienteModel constroi() {
            return cliente;
        }
    }
}