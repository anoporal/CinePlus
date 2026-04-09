/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.filme;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.ICommand;
import dao.FilmeDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import model.FilmeModel;

/**
 *
 * @author alunocmc
 */
public class FilmeConsultarTodos implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina;

        FilmeDAO filmeDAO = new FilmeDAO();
        try {
            List<FilmeModel> listFilmes = filmeDAO.consultarTodos();
            request.setAttribute("filmes", listFilmes);
            pagina = "view/listaFilmes.jsp";
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }

        return pagina;
    }
}
