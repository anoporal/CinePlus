/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.sessao;

import command.ICommand;
import dao.SessaoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.SessaoModel;

/**
 *
 * @author alunocmc
 */
public class SessaoDeletar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Sessao";

        int id = Integer.parseInt(request.getParameter("id"));

        SessaoDAO sessaoDAO = new SessaoDAO();
        SessaoModel sessao = SessaoModel.getBuilder()
                .comId(id)
                .constroi();
        try {
            sessaoDAO.deletar(sessao);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}
