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
import javax.servlet.ServletException;
import model.FilmeModel;
import model.SalaModel;
import model.SessaoModel;

/**
 *
 * @author alunocmc
 */
public class SessaoCadastrar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Sessao";

        String dataHora = request.getParameter("dataHora");
        dataHora = dataHora.replace("T", " ");
        dataHora = dataHora.concat(":00");

        int idFilme = Integer.parseInt(request.getParameter("idFilme"));
        int idSala = Integer.parseInt(request.getParameter("idSala"));

        FilmeDAO filmeDAO = new FilmeDAO();
        FilmeModel filme = FilmeModel.getBuilder()
                .comId(idFilme)
                .constroi();

        try {
            filme = filmeDAO.consultarById(filme);

            SalaDAO salaDAO = new SalaDAO();
            SalaModel sala = SalaModel.getBuilder()
                    .comId(idSala)
                    .constroi();
            sala = salaDAO.consultarById(sala);

            SessaoDAO sessaoDAO = new SessaoDAO();
            SessaoModel sessao = SessaoModel.getBuilder()
                    .comDataHora(dataHora)
                    .comFilme(filme)
                    .constroi();

            Hashtable hashtable = new Hashtable<>();
            hashtable.put("sala", sala);
            hashtable.put("sessao", sessao);

            sessaoDAO.cadastrar(hashtable);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }

}
