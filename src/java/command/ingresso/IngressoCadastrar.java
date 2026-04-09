/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.ingresso;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.ICommand;
import dao.IngressoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import model.ClienteModel;
import model.IngressoModel;
import model.PagamentoModel;
import model.SessaoModel;

/**
 *
 * @author alunocmc
 */
public class IngressoCadastrar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Cliente";

        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        int idSessao = Integer.parseInt(request.getParameter("idSessao"));
        String formaPagamento = request.getParameter("formaPagamento");
        double valorPagamento = Double.parseDouble(request.getParameter("valor"));

        IngressoDAO ingressoDAO = new IngressoDAO();
        try {
            ClienteModel cliente = ClienteModel.getBuilder()
                    .comId(idCliente)
                    .constroi();

            SessaoModel sessao = SessaoModel.getBuilder()
                    .comId(idSessao)
                    .constroi();

            PagamentoModel pagamento = PagamentoModel.getBuilder()
                    .comFormaPagamento(formaPagamento)
                    .comValor(valorPagamento)
                    .constroi();
            IngressoModel ingresso = IngressoModel.getBuilder()
                    .comCliente(cliente)
                    .comSessao(sessao)
                    .comPagamento(pagamento)
                    .constroi();

            ingressoDAO.cadastrar(ingresso);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            String mensagem = err.toString();
            if (mensagem.contains("fk_ingresso_sessao")) {
                request.setAttribute("message", "Esta sessão não existe.");
            } else {
                System.out.println("ERRO: " + err);
                request.setAttribute("message", err);
            }
            pagina = "erro.jsp";
        }
        return pagina;
    }
}
