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
import java.util.HashMap;
import java.util.List;
import model.ClienteModel;
import util.FabricaConexao;
import model.IngressoModel;
import model.FilmeModel;
import model.PagamentoModel;
import model.SalaModel;
import model.SessaoModel;

/**
 *
 * @author Breno
 */
public class IngressoDAO {

    public void cadastrar(IngressoModel ingresso) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("insert into Ingresso (idCliente, idSessao, idPagamento) values (?, ?, ?)");

        PagamentoModel pagamento = PagamentoModel.getBuilder()
                .comValor(ingresso.getPagamento().getValor())
                .comFormaPagamento(ingresso.getPagamento().getFormaPagamento())
                .constroi();
        PagamentoDAO pagamentoDAO = new PagamentoDAO();
        int idGerado = pagamentoDAO.cadastrar(pagamento);

        comando.setInt(1, ingresso.getCliente().getId());
        comando.setInt(2, ingresso.getSessao().getId());
        comando.setInt(3, idGerado);
        comando.execute();
        con.close();
    }

    public void deletar(IngressoModel ingresso) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("delete from Ingresso where idcliente = ?");
        comando.setInt(1, ingresso.getCliente().getId());
        comando.execute();
        con.close();
    }

    public void atualizar(IngressoModel ingresso) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("update Ingresso set idSessao = ?, idPagamento = ?  where idCliente = ?");
        comando.setInt(1, ingresso.getSessao().getId());
        comando.setString(2, (ingresso.getPagamento().getFormaPagamento()));
        comando.setInt(3, ingresso.getCliente().getId());
        comando.execute();
        con.close();
    }

    public IngressoModel consultarById(IngressoModel ingresso) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("select * from Ingresso where idIngresso = ?");
        comando.setInt(1, ingresso.getId());
        ResultSet rs = comando.executeQuery();
        IngressoModel.IngressoBuilder ing = IngressoModel.getBuilder();
        if (rs.next()) {
            SessaoModel sessao = SessaoModel.getBuilder()
                    .comId(rs.getInt("idSessao"))
                    .constroi();
            ClienteModel cliente = ClienteModel.getBuilder()
                    .comId(rs.getInt("idCliente"))
                    .constroi();
            PagamentoModel pagamento = PagamentoModel.getBuilder()
                    .comId(rs.getInt("idPagamento"))
                    .constroi();
            ing.comId(rs.getInt("idIngresso"))
                    .comSessao(sessao)
                    .comCliente(cliente)
                    .comPagamento(pagamento);
        }
        con.close();
        return ing.constroi();
    }

    public List<HashMap<String, Object>> consultarDisponibilidade() throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        Statement comando = con.createStatement();
        comando.execute("WITH CinematicData AS (SELECT se.idSessao, se.dataHora, sa.idSala, f.titulo, sa.capacidade - (SELECT COUNT(i.idIngresso) FROM Ingresso i WHERE i.idSessao = se.idSessao) AS capacidadeRestante FROM SessoesSala sesa LEFT JOIN Sessao se ON sesa.idSessao = se.idSessao LEFT JOIN Filme f ON f.idFilme = se.idFilme LEFT JOIN Sala sa ON sa.idSala = sesa.idSala) SELECT * FROM CinematicData WHERE capacidadeRestante > 0;");
        ResultSet rs = comando.getResultSet();

        ArrayList<HashMap<String, Object>> listOpcoes = new ArrayList<>();
        while (rs.next()) {
            HashMap<String, Object> hashmap = new HashMap<>();
            FilmeModel filme = FilmeModel.getBuilder()
                    .comTitulo(rs.getString("titulo"))
                    .constroi();
            hashmap.put("filme", filme);
            SessaoModel sessao = SessaoModel.getBuilder()
                    .comDataHora(rs.getString("dataHora"))
                    .comId(rs.getInt("idSessao"))
                    .comFilme(filme)
                    .constroi();
            hashmap.put("sessao", sessao);
            SalaModel sala = SalaModel.getBuilder()
                    .comId(rs.getInt("idSala"))
                    .comCapacidade(rs.getInt("capacidadeRestante"))
                    .constroi();
            hashmap.put("sala", sala);
            listOpcoes.add(hashmap);
        }
        con.close();
        return listOpcoes;
    }

    /*
    public ArrayList<IngressoModel> consultarTodosPorIdCliente(ClienteModel cli) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("select * from Ingresso where idCliente = ?");
        comando.setInt(1, cli.getId());
        ResultSet rs = comando.executeQuery();

        ArrayList<IngressoModel> listaResultados = new ArrayList<>();
        while (rs.next()) {
            SessaoModel sessao = SessaoModel.getBuilder()
                    .comId(rs.getInt("idSessao"))
                    .constroi();
            ClienteModel cliente = ClienteModel.getBuilder()
                    .comId(rs.getInt("idCliente"))
                    .constroi();
            PagamentoModel pagamento = PagamentoModel.getBuilder()
                    .comId(rs.getInt("idPagamento"))
                    .constroi();
            IngressoModel ing = IngressoModel.getBuilder()
                    .comId(rs.getInt("idIngresso"))
                    .comSessao(sessao)
                    .comCliente(cliente)
                    .comPagamento(pagamento)
                    .constroi();
            listaResultados.add(ing);
        }
        con.close();
        return listaResultados;
    }
     */
}