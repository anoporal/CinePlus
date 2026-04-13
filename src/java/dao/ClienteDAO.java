/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.SQLException;
import util.FabricaConexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.ClienteModel;
import model.ClienteModel.ClienteBuilder;
import model.IngressoModel;

/**
 *
 * @author Breno
 */
public class ClienteDAO {

    public void cadastrar(ClienteModel cliente) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("insert into Cliente (nome, email, telefone) values (?, ?, ?)");
        comando.setString(1, cliente.getNome());
        comando.setString(2, cliente.getEmail());
        comando.setString(3, cliente.getTelefone());
        comando.execute();
        con.close();
    }

    public void deletar(ClienteModel cliente) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("delete from Cliente where idCliente = ?");
        comando.setInt(1, cliente.getId());
        comando.execute();
        con.close();
    }

    public void atualizar(ClienteModel cliente) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("update Cliente set nome = ?, email = ?, telefone = ? where idCliente = ?");
        comando.setString(1, cliente.getNome());
        comando.setString(2, cliente.getEmail());
        comando.setString(3, cliente.getTelefone());
        comando.setInt(4, cliente.getId());
        comando.execute();
        con.close();
    }

    public ClienteModel consultarById(ClienteModel cliente) throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        PreparedStatement comando = con.prepareStatement("SELECT *, (SELECT GROUP_CONCAT(i.idIngresso) FROM Cliente c2 JOIN Ingresso i ON i.idCliente = c2.idCliente AND c2.idCliente = ?) AS idIngressos FROM Cliente c WHERE c.idCliente = ?");
        comando.setInt(1, cliente.getId());
        comando.setInt(2, cliente.getId());
        ResultSet rs = comando.executeQuery();

        ClienteBuilder clibuild = ClienteModel.getBuilder();
        if (rs.next()) {
            String[] listaIngressos = {};
            String resultadoIngressos = rs.getString("idIngressos");

            if (resultadoIngressos != null && resultadoIngressos.contains(",")) {
                listaIngressos = resultadoIngressos.split(",");
            } else if (resultadoIngressos != null) {
                listaIngressos = new String[]{resultadoIngressos};
            }

            ArrayList<IngressoModel> listaIng = new ArrayList<>();
            for (String ingresso : listaIngressos) {
                IngressoModel ing = IngressoModel.getBuilder()
                        .comId(Integer.parseInt(ingresso.trim()))
                        .constroi();
                listaIng.add(ing);
            }
            clibuild.comId(rs.getInt("idcliente"))
                    .comNome(rs.getString("nome"))
                    .comEmail(rs.getString("email"))
                    .comTelefone(rs.getString("telefone"))
                    .comIngressos(listaIng);

        }
        con.close();
        return clibuild.constroi();
    }

    public List<ClienteModel> consultarTodos() throws ClassNotFoundException, SQLException {
        Connection con = FabricaConexao.getConexao();
        Statement comando = con.createStatement();
        comando.execute("SELECT c1.*, ((SELECT GROUP_CONCAT(i2.idIngresso) FROM Ingresso i2 WHERE c1.idCliente = i2.idCliente)) idIngressos FROM Ingresso i1, Cliente c1 GROUP BY c1.idCliente;");
        ResultSet rs = comando.getResultSet();

        ArrayList<ClienteModel> listcliente = new ArrayList<>();
        while (rs.next()) {
            String[] listaIngressos = {};
            String resultadoIngressos = rs.getString("idIngressos");

            if (resultadoIngressos != null && resultadoIngressos.contains(",")) {
                listaIngressos = resultadoIngressos.split(",");
            } else if (resultadoIngressos != null) {
                listaIngressos = new String[]{resultadoIngressos};
            }

            ArrayList<IngressoModel> listaIng = new ArrayList<>();
            for (String ingresso : listaIngressos) {
                IngressoModel ing = IngressoModel.getBuilder()
                        .comId(Integer.parseInt(ingresso.trim()))
                        .constroi();
                listaIng.add(ing);
            }

            ClienteModel c = ClienteModel.getBuilder()
                    .comId(rs.getInt("idcliente"))
                    .comNome(rs.getString("nome"))
                    .comEmail(rs.getString("email"))
                    .comTelefone(rs.getString("telefone"))
                    .comIngressos(listaIng)
                    .constroi();
            listcliente.add(c);
        }
        con.close();
        return listcliente;
    }
}