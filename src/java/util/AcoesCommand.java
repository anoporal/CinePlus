/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

public enum AcoesCommand {
    ATUALIZAR("Atualizar"),
    CADASTRAR("Cadastrar"),
    CONSULTAR_TODOS("ConsultarTodos"),
    CONSULTAR_ID("ConsultarId"),
    CONSULTAR_CADASTRO("ConsultarCadastro"),
    DELETAR("Deletar");

    private final String acao;

    AcoesCommand(String acao) {
        this.acao = acao;
    }

    public String getAcao() {
        return acao;
    }
}