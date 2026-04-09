/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.cliente;

import command.ICommand;
import dao.ClienteDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ClienteModel;

/**
 *
 * @author alunocmc
 */
public class ClienteCadastrar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Cliente";
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");

        ClienteDAO clienteDAO = new ClienteDAO();
        ClienteModel cliente = ClienteModel.getBuilder()
                .comNome(nome)
                .comEmail(email)
                .comTelefone(telefone)
                .constroi();
        try {
            clienteDAO.cadastrar(cliente);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}
