/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.ingresso;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.ICommand;
import dao.IngressoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import model.IngressoModel;

/**
 *
 * @author alunocmc
 */
public class IngressoDeletar implements ICommand {

    // acredito que isso não esteja sendo utilizado, mas pode ser útil em manutenções futuras
    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Cliente";

        int id = Integer.parseInt(request.getParameter("id"));

        IngressoDAO ingressoDAO = new IngressoDAO();
        IngressoModel ingresso = IngressoModel.getBuilder()
                .comId(id)
                .constroi();
        try {
            ingressoDAO.deletar(ingresso);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}
