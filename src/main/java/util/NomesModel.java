package util;

import org.jetbrains.annotations.Contract;

public enum NomesModel {
    CLIENTE("Cliente", "Clientes"),
    FILME("Filme", "Filmes"),
    INGRESSO("Ingresso", "Ingressos"),
    SALA("Sala", "Salas"),
    SESSAO("Sessão", "Sessões", "Sessao");

    private final String singular;
    private final String plural;
    private String singularSemAcento;

    @Contract(pure = true)
    NomesModel(String singular, String plural) {
        this.singular = singular;
        this.plural = plural;
    }

    @Contract(pure = true)
    NomesModel(String singular, String plural, String singularSemAcento) {
        this.singular = singular;
        this.plural = plural;
        this.singularSemAcento = singularSemAcento;
    }

    @Contract(pure = true)
    public String getSingular() {
        return singular;
    }

    @Contract(pure = true)
    public String getPlural() {
        return plural;
    }

    @Contract(pure = true)
    public String getSingularSemAcento() {
        return singularSemAcento == null ? singular : singularSemAcento;
    }
}