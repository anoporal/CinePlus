/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.sessao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.ICommand;
import dao.FilmeDAO;
import dao.SalaDAO;
import dao.SessaoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.List;
import javax.servlet.ServletException;
import model.FilmeModel;
import model.SalaModel;
import model.SessaoModel;

/**
 *
 * @author PC
 */
public class SessaoConsultarId implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina;

        int id = Integer.parseInt(request.getParameter("id"));

        SessaoDAO sessaoDAO = new SessaoDAO();
        SessaoModel sessao = SessaoModel.getBuilder()
                .comId(id)
                .constroi();
        SalaDAO salaDAO = new SalaDAO();
        FilmeDAO filmeDAO = new FilmeDAO();
        try {
            Hashtable resultadoSessao = sessaoDAO.consultarById(sessao);

            List<SalaModel> salas = salaDAO.consultarTodos();
            List<FilmeModel> filmes = filmeDAO.consultarTodos();
            Hashtable opcoes = new Hashtable<>();
            opcoes.put("salas", salas);
            opcoes.put("filmes", filmes);

            request.setAttribute("sessao", resultadoSessao);
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
