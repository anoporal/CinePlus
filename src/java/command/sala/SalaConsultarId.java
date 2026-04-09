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
import java.util.ArrayList;
import javax.servlet.ServletException;
import model.SalaModel;

/**
 *
 * @author alunocmc
 */
public class SalaConsultarId implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina;

        int id = Integer.parseInt(request.getParameter("id"));

        SalaDAO salaDAO = new SalaDAO();
        SalaModel sala = SalaModel.getBuilder()
                .comId(id)
                .constroi();
        try {
            SalaModel resultadoSala = salaDAO.consultarById(sala);

            ArrayList resultado = new ArrayList<>();
            if (resultadoSala.getCapacidade() > 0) {
                resultado.add(resultadoSala);
            }

            request.setAttribute("salas", resultado);
            pagina = "view/listaSalas.jsp";
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }
        return pagina;
    }
}
