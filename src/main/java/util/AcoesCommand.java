package util;

import org.jetbrains.annotations.Contract;

public enum AcoesCommand {
    ATUALIZAR("Atualizar"),
    CADASTRAR("Cadastrar"),
    CONSULTAR_TODOS("ConsultarTodos"),
    CONSULTAR_ID("ConsultarId"),
    CONSULTAR_CADASTRO("ConsultarCadastro"),
    DELETAR("Deletar");

    private final String acao;

    @Contract(pure = true)
    AcoesCommand(String acao) {
        this.acao = acao;
    }

    @Contract(pure = true)
    public String getAcao() {
        return acao;
    }
}