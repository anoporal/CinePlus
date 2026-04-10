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
public class SalaDeletar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Sala";

        int id = Integer.parseInt(request.getParameter("id"));

        SalaDAO salaDAO = new SalaDAO();
        SalaModel sala = SalaModel.getBuilder()
                .comId(id)
                .constroi();
        try {
            salaDAO.deletar(sala);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}
