/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.sala;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.ICommand;
import dao.SalaDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import model.SalaModel;

/**
 *
 * @author alunocmc
 */
public class SalaAtualizar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Sala";

        int id = Integer.parseInt(request.getParameter("id"));
        int capacidade = Integer.parseInt(request.getParameter("capacidade"));
        SalaDAO salaDAO = new SalaDAO();
        SalaModel sala = SalaModel.getBuilder()
                .comId(id)
                .comCapacidade(capacidade)
                .constroi();
        try {
            salaDAO.atualizar(sala);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }

        return pagina;
    }
}
