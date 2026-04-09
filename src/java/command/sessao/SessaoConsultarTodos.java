/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.sessao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.ICommand;
import dao.SessaoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.List;
import javax.servlet.ServletException;

/**
 *
 * @author PC
 */
public class SessaoConsultarTodos implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina;

        SessaoDAO sessaoDAO = new SessaoDAO();
        try {
            List<Hashtable> listses = sessaoDAO.consultarTodos();

            request.setAttribute("sessoes", listses);
            pagina = "view/listaSessoes.jsp";
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}
