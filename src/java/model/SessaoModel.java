/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author lucas
 */
public class SessaoModel {

    private int id;
    private Date dataHora;
    private FilmeModel filme;

    public int getId() {
        return id;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public FilmeModel getFilme() {
        return filme;
    }

    public SessaoModel() {
    }

    public static SessaoBuilder getBuilder() {
        return new SessaoBuilder();
    }

    public static class SessaoBuilder {

        private final SessaoModel sessao = new SessaoModel();

        public SessaoBuilder comId(int id) {
            sessao.id = id;
            return this;
        }

        public SessaoBuilder comDataHora(String sqlDataHora) {
            try {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ROOT);
                sessao.dataHora = format.parse(sqlDataHora);
            } catch (ParseException ex) {
                System.out.println(ex.getMessage());
            }
            return this;
        }

        public SessaoBuilder comFilme(FilmeModel filme) {
            sessao.filme = filme;
            return this;
        }

        public SessaoModel constroi() {
            return sessao;
        }
    }
}