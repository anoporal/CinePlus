<%--
    Document   : TelaCineplus
    Created on : 30 de mar. de 2026, 13:06:50
    Author     : PC
--%>

<%@page import="model.ClienteModel"%>
<%@page import="java.util.List"%>
<%@ page import="util.NomesModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CinePlus</title>
        <link rel="stylesheet" href="view/style/menuModel.css">
        <link rel="stylesheet" href="view/style/cadastroCliente.css">
    </head>

    <body>
        <%
            NomesModel model = NomesModel.Cliente;
            String op = request.getParameter("op");
            if (op == null) {
                op = "";
            }
            String atualizarStr = "Atualizar";
            String cadastrarStr = "Cadastrar";
            String listarTodosStr = "ConsultarTodos";
            String listarPorIdStr = "ConsultarId";
            List<ClienteModel> lcli = (List<ClienteModel>) request.getAttribute("clientes");
        %>

        <div class="area-fixa">

            <section id="secao-cadastro">
                <form action="controle" method="POST">
                    <%if (op.equals(listarPorIdStr) && !lcli.isEmpty()) {%>
                    <input type="hidden" name="id" value="<%out.print(lcli.getFirst().getId());
                        %>">
                    <%}%>
                    <input type="hidden" name="model" value="<%out.print(model);%>">
                    <input type="hidden" name="op" value="<%
                        if (op.equals(listarPorIdStr) && !lcli.isEmpty()) {
                            out.print(atualizarStr);
                        } else {
                            out.print(cadastrarStr);
                        }%>">
                    <input type="text" name="nome" placeholder="Seu nome:" required <%if (op.equals(listarPorIdStr) && !lcli.isEmpty()) {
                                out.print(String.format("value='%s'", lcli.getFirst().getNome()));
                            }%>>
                    <input type="email" name="email" placeholder="Seu e-mail:" required <%if (op.equals(listarPorIdStr) && !lcli.isEmpty()) {
                                out.print(String.format("value='%s'", lcli.getFirst().getEmail()));
                            }%>>
                    <input type="tel" name="telefone" required pattern="[0-9]{2} [0-9]{5}-[0-9]{4}" maxlength=13 placeholder="Seu telefone:"
                           oninvalid="this.setCustomValidity('Digite apenas telefones (ex: 11 99999-9999)')"
                           oninput="this.setCustomValidity('')" <%if (op.equals(listarPorIdStr) && !lcli.isEmpty()) {
                                out.print(String.format("value='%s'", lcli.getFirst().getTelefone()));
                            }%>>
                    <button type="submit"><%if (op.equals(listarPorIdStr) && !lcli.isEmpty()) {
                            out.print("ATUALIZAR");
                        } else {
                            out.print("CADASTRAR");
                        };
                        out.print(" " + model.toString().toUpperCase());%></button>
                </form>
            </section>

            <nav id="menu-principal">
                <div class="menu-titulo">MENU</div>
                <a href="controle?model=<%out.print(NomesModel.Sessao);%>&op=<%out.print(listarTodosStr);%>" class="btn-link">EM CARTAZ</a>
                <a href="controle?model=<%out.print(NomesModel.Filme);%>&op=<%out.print(listarTodosStr);%>" class="btn-link">FILMES</a>
                <a href="controle?model=<%out.print(NomesModel.Sala);%>&op=<%out.print(listarTodosStr);%>" class="btn-link">SALAS</a>
                <a href="controle?model=<%out.print(model);%>&op=<%out.print(listarTodosStr);%>" class="btn-link">CLIENTES</a>
            </nav>
        </div>
    </body>

</html>