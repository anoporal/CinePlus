<%--
    Document   : TelaSala
    Created on : 30 de mar. de 2026, 14:26:50
    Author     : PC
--%>

<%@page import="java.text.SimpleDateFormat" %>
<%@page import="model.SessaoModel" %>
<%@page import="model.SalaModel" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@ page import="util.NomesModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlus - Cadastro de Sala e Sessão</title>
    <link rel="stylesheet" href="view/style/menuModel.css">
    <link rel="stylesheet" href="view/style/cadastroSala.css">
</head>
<body>
<%
    NomesModel model = NomesModel.Sala;
    String op = request.getParameter("op");
    if (op == null) {
        op = "";
    }
    String paginaAnterior = request.getParameter("from");
    if (paginaAnterior == null) {
        paginaAnterior = model.toString();
    }
    String atualizarStr = "Atualizar";
    String cadastrarStr = "Cadastrar";
    String listarTodosStr = "ConsultarTodos";
    String listarPorIdStr = "ConsultarId";
    List<SalaModel> lsala = (List<SalaModel>) request.getAttribute("salas");
%>

<div class="menu-models">
    <button class="btn-menu">
        📲</button>

    <div class="menu-opcoes">
        <%for (NomesModel nomeModel : NomesModel.values()) {
            if (nomeModel == model) continue;
            if (nomeModel == NomesModel.Ingresso) continue;%>
        <a href="controle?op=<%out.print(listarTodosStr);%>&model=<%out.print(nomeModel);%>"><%out.print(nomeModel);%></a>
        <%}%>
    </div>
</div>

<div class="main-screen">
    <div class="main-container">

        <section class="panel sala-section">
            <h1 class="neon-title">Sala</h1>

            <div class="sala-content">
                <div class="sala-header-image"></div>

                <form action="controle" method="GET" class="form-neon">
                    <%if (op.equals(listarPorIdStr) && !lsala.isEmpty()) {%>
                    <input type="hidden" name="id" value="<%if (op.equals(listarPorIdStr) && lsala != null && !lsala.isEmpty()) {
                        out.print(lsala.getFirst().getId());
                    }%>">
                    <%}%>
                    <input type="hidden" name="from" value="<%out.print(paginaAnterior);%>">
                    <input type="hidden" name="model" value="<%out.print(model);%>">
                    <input type="hidden" name="op" value="<%
                    if (op.equals(listarPorIdStr) && !lsala.isEmpty()) {
                        out.print(atualizarStr);
                    } else {
                        out.print(cadastrarStr);
                    }%>">
                    <div class="input-group">
                        <label for="capacidade">CAPACIDADE</label>
                        <input type="number" id="capacidade" name="capacidade" placeholder="Assentos" required
                               min="2" <%
                            if (op.equals(listarPorIdStr) && lsala != null && !lsala.isEmpty()) {
                                out.print(String.format("value='%s'", lsala.getFirst().getCapacidade()));
                            }
                        %> />
                    </div>

                    <input type="submit" class="btn-neon" value="<%if (op.equals(listarPorIdStr) && !lsala.isEmpty()) {
                        out.print("Editar");
                    } else {
                        out.print("Cadastrar");
                    };
                    out.print(" " + model);%>">
                </form>
            </div>
        </section>
    </div>
    <a href="controle?model=<%out.print(paginaAnterior);%>&op=<%out.print(listarTodosStr);%>"
       class="btn-voltar">VOLTAR</a>
</div>

</body>
</html>