package util;

public enum NomesModel {
    CLIENTE("Cliente", "Clientes"),
    FILME("Filme", "Filmes"),
    INGRESSO("Ingresso", "Ingressos"),
    SALA("Sala", "Salas"),
    SESSAO("Sessão", "Sessões", "Sessao");

    private final String singular;
    private final String plural;
    private String singularSemAcento;

    NomesModel(String singular, String plural) {
        this.singular = singular;
        this.plural = plural;
    }

    NomesModel(String singular, String plural, String singularSemAcento) {
        this.singular = singular;
        this.plural = plural;
        this.singularSemAcento = singularSemAcento;
    }

    public String getSingular() {
        return singular;
    }

    public String getPlural() {
        return plural;
    }

    public String getSingularSemAcento() {
        return singularSemAcento == null ? singular : singularSemAcento;
    }
}