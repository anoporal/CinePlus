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
public class SalaCadastrar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Sala";

        int capacidade = Integer.parseInt(request.getParameter("capacidade"));
        SalaDAO salaDAO = new SalaDAO();
        SalaModel sala = SalaModel.getBuilder()
                .comCapacidade(capacidade)
                .constroi();
        try {
            salaDAO.cadastrar(sala);
            String paginaAnterior = request.getParameter("from");
            if (paginaAnterior != null) {
                pagina = "controle?op=ConsultarTodos&model=" + paginaAnterior;
            }
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }

}