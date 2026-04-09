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
public class SalaModel {

    private int id;
    private int capacidade;
    private List<SessaoModel> sessoes;

    public int getId() {
        return id;
    }

    public int getCapacidade() {
        return capacidade;
    }

    public List<SessaoModel> getSessoes() {
        return sessoes;
    }

    public SalaModel() {
    }

    public static SalaBuilder getBuilder() {
        return new SalaBuilder();
    }

    public static class SalaBuilder {

        private SalaModel sala = new SalaModel();

        public SalaBuilder comId(int id) {
            sala.id = id;
            return this;
        }

        public SalaBuilder comCapacidade(int capacidade) {
            sala.capacidade = capacidade;
            return this;
        }

        public SalaBuilder comSessoes(List<SessaoModel> sessoes) {
            sala.sessoes = sessoes;
            return this;
        }

        public SalaModel constroi() {
            return sala;
        }
    }
}
