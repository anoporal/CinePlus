/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.sessao;

import command.ICommand;
import dao.FilmeDAO;
import dao.SalaDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.FilmeModel;
import model.SalaModel;

/**
 *
 * @author lucas
 */
public class SessaoConsultarCadastro implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina;
        Integer idSala;

        try {
            idSala = Integer.valueOf(request.getParameter("idSala"));
        } catch (NumberFormatException e) {
            idSala = null;
        }

        SalaDAO salaDAO = new SalaDAO();
        FilmeDAO filmeDAO = new FilmeDAO();
        try {
            List<SalaModel> salas = salaDAO.consultarTodos();
            List<FilmeModel> filmes = filmeDAO.consultarTodos();
            HashMap<String, Object> opcoes = new HashMap<>();
            opcoes.put("salas", salas);
            opcoes.put("filmes", filmes);

            if (idSala != null) {
                request.setAttribute("idSala", idSala);
            }
            request.setAttribute("opcoes", opcoes);
            pagina = "view/cadastroSessao.jsp";
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}