/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import command.ICommand;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

/**
 *
 * @author lucas
 */
@WebServlet(urlPatterns = {"/controle"})
public class Controller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String pagina = "view/cadastroCliente.jsp";
        String paramAction = request.getParameter("op");
        String paramModel = request.getParameter("model");

        if (paramAction != null && paramModel != null) {
            try {
                // exemplo: "command.cliente.ClienteCadastrar"
                String nomeDaclasse = "command." + paramModel.toLowerCase() + "." + paramModel + paramAction;
                Class<?> classAction = Class.forName(nomeDaclasse);
                @SuppressWarnings("deprecation") ICommand commandAction = (ICommand) classAction.newInstance();

                pagina = commandAction.executar(request, response);
            } catch (Exception e) {
                request.setAttribute("message", e.getMessage());
                pagina = "erro.jsp";
            }
        } else if (paramModel != null) {
            // redireciona para tela de cadastro quando a ação não é especificada (acontece ao abrir a controller normalmente)
            pagina = "view/cadastro" + paramModel + ".jsp";
        }
        request.getRequestDispatcher(pagina).forward(request, response);
    }

    /*
    @param request
    @param response
    @throws ServletException
    @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}