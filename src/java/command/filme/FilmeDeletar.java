/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.filme;

import command.ICommand;
import dao.FilmeDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.FilmeModel;

/**
 *
 * @author alunocmc
 */
public class FilmeDeletar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Filme";

        int id = Integer.parseInt(request.getParameter("id"));

        FilmeDAO filmeDAO = new FilmeDAO();
        FilmeModel filme = FilmeModel.getBuilder()
                .comId(id)
                .constroi();
        try {
            filmeDAO.deletar(filme);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}
