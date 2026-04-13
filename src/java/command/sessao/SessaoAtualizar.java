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
import javax.servlet.ServletException;
import model.FilmeModel;
import model.SessaoModel;

/**
 *
 * @author alunocmc
 */
public class SessaoAtualizar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Sessao";

        int id = Integer.parseInt(request.getParameter("id"));
        String dataHora = request.getParameter("dataHora");
        dataHora = dataHora.replace("T", " ");
        dataHora = dataHora.concat(":00");
        int idFilme = Integer.parseInt(request.getParameter("idFilme"));

        FilmeModel filme = FilmeModel.getBuilder()
                .comId(idFilme)
                .constroi();
        try {
            SessaoDAO sessaoDAO = new SessaoDAO();
            SessaoModel sessao = SessaoModel.getBuilder()
                    .comId(id)
                    .comDataHora(dataHora)
                    .comFilme(filme)
                    .constroi();

            sessaoDAO.atualizar(sessao);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}