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
import util.FabricaConexao;
import model.PagamentoModel;

/**
 *
 * @author Breno
 */
public class PagamentoDAO {

    public int cadastrar(PagamentoModel pagamento) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("insert into Pagamento (valor, formaPagamento) values (?, ?)", Statement.RETURN_GENERATED_KEYS);
        comando.setDouble(1, pagamento.getValor());
        comando.setString(2, pagamento.getFormaPagamento());
        Integer idGerado = comando.executeUpdate();

        if (idGerado == 0) {
            throw new SQLException("Falha na criação de Pagamento, nenhuma linha afetada.");
        }

        try (ResultSet chaveGerada = comando.getGeneratedKeys()) {
            if (chaveGerada.next()) {
                idGerado = chaveGerada.getInt(1);
            } else {
                throw new SQLException("Falha na criação de Pagamento, nenhum id obtido.");
            }
        }
        con.close();
        return idGerado;
    }

    /*
    public void deletar(PagamentoModel pagamento) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("delete from Pagamento where idPagamento = ?");
        comando.setInt(1, pagamento.getId());
        comando.execute();
        con.close();
    }
    
    public void atualizar(PagamentoModel pagamento) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("update Pagamento set valor = ?, formaPagamento = ? where idPagamento = ?");
        comando.setDouble(1, pagamento.getValor());
        comando.setString(2, pagamento.getFormaPagamento());
        comando.setInt(3, pagamento.getId());
        comando.execute();
        con.close();
    }
    
    public PagamentoModel consultarById(PagamentoModel pagamento) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("select * from Pagamento where idPagamento = ?");
        comando.setInt(1, pagamento.getId());
        ResultSet rs = comando.executeQuery();
        PagamentoModel.PagamentoBuilder pag = PagamentoModel.getBuilder();
        if (rs.next()) {
            pag.comId(rs.getInt("idPagamento"))
                .comFormaPagamento(rs.getString("formaPagamento"))
                .comValor(rs.getDouble("valor"));
        }
        con.close();
        return pag.constroi();
    }
     */
}
