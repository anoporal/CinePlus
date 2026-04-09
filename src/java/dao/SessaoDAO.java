/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import model.FilmeModel;
import model.SalaModel;
import model.SessaoModel;
import util.FabricaConexao;

/**
 *
 * @author Breno
 */
public class SessaoDAO {

    public void cadastrar(Hashtable hashtable) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("insert into Sessao (idFilme, dataHora) values (?, ?)", Statement.RETURN_GENERATED_KEYS);

        comando.setInt(1, ((SessaoModel) hashtable.get("sessao")).getFilme().getId());
        comando.setTimestamp(2, new Timestamp(((SessaoModel) hashtable.get("sessao")).getDataHora().getTime()));

        Integer idGerado = comando.executeUpdate();

        if (idGerado == 0) {
            throw new SQLException("Falha na criação de Sessao, nenhuma linha afetada.");
        }

        try (ResultSet chaveGerada = comando.getGeneratedKeys()) {
            if (chaveGerada.next()) {
                idGerado = chaveGerada.getInt(1);
            } else {
                throw new SQLException("Falha na criação de Sessao, nenhum id obtido.");
            }
        }

        comando = con.prepareStatement("insert into SessoesSala (idSala, idSessao) values (?, ?)");
        comando.setInt(1, ((SalaModel) hashtable.get("sala")).getId());
        comando.setInt(2, idGerado);

        comando.execute();
        con.close();
    }

    public void deletar(SessaoModel sessao) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("delete from Sessao where idSessao = ?");
        comando.setInt(1, sessao.getId());
        comando.execute();
        con.close();
    }

    public void atualizar(SessaoModel sessao) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("update Sessao set dataHora = ? where idSessao = ?");
        comando.setTimestamp(1, new Timestamp(sessao.getDataHora().getTime()));
        comando.setInt(2, sessao.getId());
        comando.execute();
        con.close();
    }

    public Hashtable consultarById(SessaoModel sessao) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("SELECT f.titulo, se.idSessao, se.dataHora, f.idFilme, f.duracao, f.genero, sa1.idSala, (sa1.capacidade - ((SELECT COUNT(i.idIngresso) FROM SessoesSala sesa JOIN Ingresso i ON i.idSessao = sesa.idSessao WHERE sesa.idSala = sa1.idSala AND sesa.idSessao = se.idSessao))) AS vagasDisponiveis FROM Sala sa1 JOIN SessoesSala sesa ON sesa.idSala = sa1.idSala JOIN Sessao se ON sesa.idSessao = se.idSessao JOIN Filme f ON f.idFilme = se.idFilme WHERE se.idSessao = ? GROUP BY se.idSessao, f.titulo ORDER BY se.dataHora ASC, vagasDisponiveis ASC, f.titulo ASC");
        comando.setInt(1, sessao.getId());
        ResultSet rs = comando.executeQuery();

        Hashtable<String, Object> hashtable = new Hashtable<>();
        if (rs.next()) {
            FilmeModel filme = FilmeModel.getBuilder()
                    .comId(rs.getInt("idFilme"))
                    .comTitulo(rs.getString("titulo"))
                    .comDuracao(rs.getInt("duracao"))
                    .comGenero(rs.getString("genero"))
                    .constroi();
            hashtable.put("filme", filme);
            SessaoModel ses = SessaoModel.getBuilder()
                    .comId(rs.getInt("idsessao"))
                    .comDataHora(rs.getString("dataHora"))
                    .comFilme(filme)
                    .constroi();
            hashtable.put("sessao", ses);
            SalaModel sal = SalaModel.getBuilder()
                    .comId(rs.getInt("idsala"))
                    .comCapacidade(rs.getInt("vagasDisponiveis"))
                    .constroi();
            hashtable.put("sala", sal);
        }
        con.close();
        return hashtable;
    }

    public List<Hashtable> consultarTodos() throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        Statement statement = con.createStatement();
        statement.execute("SELECT f.titulo, se.idSessao, se.dataHora, f.idFilme, f.duracao, f.genero, sa1.idSala, (sa1.capacidade - ((SELECT COUNT(i.idIngresso) FROM SessoesSala sesa JOIN Ingresso i ON i.idSessao = sesa.idSessao WHERE sesa.idSala = sa1.idSala AND sesa.idSessao = se.idSessao))) AS vagasDisponiveis FROM Sala sa1 JOIN SessoesSala sesa ON sesa.idSala = sa1.idSala JOIN Sessao se ON sesa.idSessao = se.idSessao JOIN Filme f ON f.idFilme = se.idFilme GROUP BY se.idSessao, f.titulo ORDER BY se.dataHora ASC, vagasDisponiveis ASC, f.titulo ASC;");
        ResultSet rs = statement.getResultSet();

        List<Hashtable> listses = new ArrayList<>();
        while (rs.next()) {
            Hashtable<String, Object> hashtable = new Hashtable<>();
            FilmeModel filme = FilmeModel.getBuilder()
                    .comTitulo(rs.getString("titulo"))
                    .comDuracao(rs.getInt("duracao"))
                    .comGenero(rs.getString("genero"))
                    .comId(rs.getInt("idFilme"))
                    .constroi();
            hashtable.put("filme", filme);
            SessaoModel ses = SessaoModel.getBuilder()
                    .comId(rs.getInt("idsessao"))
                    .comDataHora(rs.getString("dataHora"))
                    .comFilme(filme)
                    .constroi();
            hashtable.put("sessao", ses);
            SalaModel sal = SalaModel.getBuilder()
                    .comId(rs.getInt("idsala"))
                    .comCapacidade(rs.getInt("vagasDisponiveis"))
                    .constroi();
            hashtable.put("sala", sal);
            listses.add(hashtable);
        }
        con.close();
        return listses;
    }
}
