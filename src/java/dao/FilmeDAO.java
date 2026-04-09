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
import util.FabricaConexao;

/**
 *
 * @author Breno
 */
public class FilmeDAO {

    public void cadastrar(FilmeModel filme) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("insert into Filme (titulo, genero, duracao) values (?, ?, ?)");
        comando.setString(1, filme.getTitulo());
        comando.setString(2, filme.getGenero());
        comando.setInt(3, filme.getDuracao());
        comando.execute();
        con.close();
    }

    public void deletar(FilmeModel filme) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("delete from Filme where idFilme = ?;");
        comando.setInt(1, filme.getId());
        comando.execute();
        con.close();
    }

    public void atualizar(FilmeModel filme) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("update Filme set titulo = ?, genero = ?, duracao = ? where idfilme = ?");
        comando.setString(1, filme.getTitulo());
        comando.setString(2, filme.getGenero());
        comando.setInt(3, filme.getDuracao());
        comando.setInt(4, filme.getId());
        comando.execute();
        con.close();
    }

    public FilmeModel consultarById(FilmeModel filme) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("select * from Filme where idfilme = ?");
        comando.setInt(1, filme.getId());
        ResultSet rs = comando.executeQuery();
        FilmeModel.FilmeBuilder f = FilmeModel.getBuilder();
        if (rs.next()) {
            f.comId(rs.getInt("idfilme"))
                    .comTitulo(rs.getString("titulo"))
                    .comGenero(rs.getString("genero"))
                    .comDuracao(rs.getInt("duracao"));
        }
        con.close();
        return f.constroi();
    }

    public List<FilmeModel> consultarTodos() throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        Statement comando = con.createStatement();
        comando.execute("select * from Filme");
        ResultSet rs = comando.getResultSet();

        List<FilmeModel> listfilme = new ArrayList<>();
        while (rs.next()) {
            FilmeModel f = FilmeModel.getBuilder()
                    .comId(rs.getInt("idfilme"))
                    .comTitulo(rs.getString("titulo"))
                    .comGenero(rs.getString("genero"))
                    .comDuracao(rs.getInt("duracao"))
                    .constroi();
            listfilme.add(f);
        }
        con.close();
        return listfilme;
    }

}
