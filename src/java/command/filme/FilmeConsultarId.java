/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.filme;

import command.ICommand;
import dao.FilmeDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.FilmeModel;

/**
 *
 * @author alunocmc
 */
public class FilmeConsultarId implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina;

        int id = Integer.parseInt(request.getParameter("id"));

        FilmeDAO filmeDAO = new FilmeDAO();
        FilmeModel filme = FilmeModel.getBuilder()
                .comId(id)
                .constroi();
        try {
            filme = filmeDAO.consultarById(filme);

            ArrayList<FilmeModel> resultado = new ArrayList<>();
            if (filme.getTitulo() != null) {
                resultado.add(filme);
            }

            request.setAttribute("filmes", resultado);
            pagina = "view/cadastroFilme.jsp";
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}