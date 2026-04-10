/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.FilmeModel;
import model.SalaModel;
import model.SessaoModel;
import util.FabricaConexao;

/**
 *
 * @author Breno
 */
public class SalaDAO {

    public void cadastrar(SalaModel sala) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("insert into Sala (capacidade) values (?)");
        comando.setInt(1, sala.getCapacidade());
        comando.execute();
        con.close();
    }

    public void deletar(SalaModel sala) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("delete from Sala where idSala = ?");
        comando.setInt(1, sala.getId());
        comando.execute();
        con.close();
    }

    public void atualizar(SalaModel sala) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("update Sala set capacidade = ? where idSala = ?");
        comando.setInt(1, sala.getCapacidade());
        comando.setInt(2, sala.getId());
        comando.execute();
        con.close();
    }

    public SalaModel consultarById(SalaModel sala) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("SELECT sa.*, se.idSessao, se.dataHora, f.* FROM Sala sa LEFT JOIN SessoesSala sesa ON sa.idSala = sesa.idSala LEFT JOIN Sessao se ON sesa.idSessao = se.idSessao LEFT JOIN Filme f ON f.idFilme = se.idFilme WHERE sa.idSala =  ?");
        comando.setInt(1, sala.getId());
        ResultSet rs = comando.executeQuery();

        int capacidade = 0;
        ArrayList<SessaoModel> listaSessoes = new ArrayList<>();
        while (rs.next()) {
            if (capacidade == 0) {
                capacidade = rs.getInt("capacidade");
            }
            if (rs.getString("idSessao") == null) {
                break;
            }
            FilmeModel filme = FilmeModel.getBuilder()
                    .comId(rs.getInt("idFilme"))
                    .comTitulo(rs.getString("titulo"))
                    .comGenero(rs.getString("genero"))
                    .comDuracao(rs.getInt("duracao"))
                    .constroi();
            SessaoModel sessao = SessaoModel.getBuilder()
                    .comId(rs.getInt("idSessao"))
                    .comDataHora(rs.getString("dataHora"))
                    .comFilme(filme)
                    .constroi();
            listaSessoes.add(sessao);
        }
        SalaModel sal = SalaModel.getBuilder()
                .comId(sala.getId())
                .comCapacidade(capacidade)
                .comSessoes(listaSessoes)
                .constroi();
        con.close();
        return sal;
    }

    public List<SalaModel> consultarTodos() throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        Statement comando = con.createStatement();
        comando.execute("SELECT sa.idSala, sa.capacidade, GROUP_CONCAT(se.idSessao ORDER BY se.idSessao) AS idSessoes, GROUP_CONCAT(se.datahora ORDER BY se.idSessao) AS datasHoras, GROUP_CONCAT(f.idFilme ORDER BY se.idSessao) AS idFilmes, GROUP_CONCAT(f.genero ORDER BY se.idSessao) AS generos, GROUP_CONCAT(f.duracao ORDER BY se.idSessao) AS duracoes, GROUP_CONCAT(f.titulo ORDER BY se.idSessao) AS nomesFilmes FROM Sala sa LEFT JOIN SessoesSala sesa ON sa.idSala = sesa.idSala LEFT JOIN Sessao se ON sesa.idSessao = se.idSessao LEFT JOIN Filme f ON f.idFilme = se.idFilme GROUP BY sa.idSala;");
        ResultSet rs = comando.getResultSet();

        ArrayList<SalaModel> listsalas = new ArrayList<>();
        while (rs.next()) {
            ArrayList<SessaoModel> sessoes = new ArrayList<>();
            if (rs.getString("idSessoes") != null) {
                String[] idSessoes = rs.getString("idSessoes").split(",");
                String[] datasHoras = rs.getString("datasHoras").split(",");
                String[] idFilmes = rs.getString("idFilmes").split(",");
                String[] generos = rs.getString("generos").split(",");
                String[] nomesFilmes = rs.getString("nomesFilmes").split(",");
                String[] duracoes = rs.getString("duracoes").split(",");

                for (int index = 0; index < idSessoes.length; index++) {
                    FilmeModel filme = FilmeModel.getBuilder()
                            .comId(Integer.parseInt(idFilmes[index]))
                            .comTitulo(nomesFilmes[index])
                            .comGenero(generos[index])
                            .comDuracao(Integer.parseInt(duracoes[index]))
                            .constroi();
                    SessaoModel sessao = SessaoModel.getBuilder()
                            .comId(Integer.parseInt(idSessoes[index]))
                            .comDataHora(datasHoras[index])
                            .comFilme(filme)
                            .constroi();
                    sessoes.add(sessao);
                }
            }
            SalaModel sala = SalaModel.getBuilder()
                    .comId(rs.getInt("idSala"))
                    .comCapacidade(rs.getInt("capacidade"))
                    .comSessoes(sessoes)
                    .constroi();
            listsalas.add(sala);
        }
        con.close();
        return listsalas;
    }
}
