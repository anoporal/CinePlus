/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author lucas
 */
public class FilmeModel {

    private int id;
    private String titulo;
    private String genero;
    private int duracao;

    public int getId() {
        return id;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getGenero() {
        return genero;
    }

    public int getDuracao() {
        return duracao;
    }

    public FilmeModel() {
    }

    public static FilmeBuilder getBuilder() {
        return new FilmeBuilder();
    }

    public static class FilmeBuilder {

        private FilmeModel filme = new FilmeModel();

        public FilmeBuilder comId(int id) {
            filme.id = id;
            return this;
        }

        public FilmeBuilder comTitulo(String titulo) {
            filme.titulo = titulo;
            return this;
        }

        public FilmeBuilder comGenero(String genero) {
            filme.genero = genero;
            return this;
        }

        public FilmeBuilder comDuracao(int duracao) {
            filme.duracao = duracao;
            return this;
        }

        public FilmeModel constroi() {
            return filme;
        }
    }
}
