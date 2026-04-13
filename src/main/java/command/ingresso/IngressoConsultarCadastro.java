/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.ingresso;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.ICommand;
import dao.ClienteDAO;
import dao.IngressoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import model.ClienteModel;

/**
 *
 * @author alunocmc
 */
public class IngressoConsultarCadastro implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina;

        int idCliente = Integer.parseInt(request.getParameter("idCliente"));

        IngressoDAO ingressoDAO = new IngressoDAO();
        ClienteDAO clienteDAO = new ClienteDAO();

        ClienteModel cliente = ClienteModel.getBuilder()
                .comId(idCliente)
                .constroi();
        try {
            List<HashMap<String, Object>> resultadosOpcoes = ingressoDAO.consultarDisponibilidade();

            ClienteModel resultadoCliente = clienteDAO.consultarById(cliente);
            request.setAttribute("cliente", resultadoCliente);
            request.setAttribute("opcoes", resultadosOpcoes);
            pagina = "view/cadastroIngresso.jsp";
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;

    }
}