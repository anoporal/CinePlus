<%--
    Document   : TelaFilmes
    Created on : 30 de mar. de 2026, 14:26:31
    Author     : PC
--%>

<%@page import="model.FilmeModel" %>
<%@page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page import="util.NomesModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Filme</title>
    <link rel="stylesheet" href="view/style/menuModel.css">
    <link rel="stylesheet" href="view/style/cadastroFilme.css">
</head>
<body>
<%
    NomesModel model = NomesModel.Filme;
    String op = request.getParameter("op");
    if (op == null) {
        op = "";
    }
    String paginaAnterior = request.getParameter("from");
    if (paginaAnterior == null) {
        paginaAnterior = model.toString();
    }
    String[] generos = {"Sci-Fi", "Crime", "Animação", "Drama", "Ação"};
    String atualizarStr = "Atualizar";
    String cadastrarStr = "Cadastrar";
    String listarTodosStr = "ConsultarTodos";
    String listarPorIdStr = "ConsultarId";
    List<FilmeModel> lfilm = (List<FilmeModel>) request.getAttribute("filmes");
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

<header class="movie-header"></header>

<main class="main-content">

    <form action="controle" method="GET" class="main-content" style="width: 100%; margin-top: 0;">
        <%if (op.equals(listarPorIdStr) && !Objects.requireNonNull(lfilm).isEmpty()) {%>
        <input type="hidden" name="id" value="<%out.print(lfilm.getFirst().getId());
                    %>">
        <%}%>
        <input type="hidden" name="from" value="<%out.print(paginaAnterior);%>">
        <input type="hidden" name="model" value="<%out.print(model);%>">
        <input type="hidden" name="op" value="<%
                    if (op.equals(listarPorIdStr) && !lfilm.isEmpty()) {
                        out.print(atualizarStr);
                    } else {
                        out.print(cadastrarStr);
                    }%>">

        <section class="form-column">
            <div class="input-group">
                <label for="titulo" class="label-gold">Título</label>
                <input type="text" id="titulo" name="titulo" placeholder="Título" class="input-field" required <%if (op.equals(listarPorIdStr)&&!lfilm.isEmpty()) {
                                out.print(String.format("value='%s'", lfilm.getFirst().getTitulo()));
                            }%>>
            </div>

            <div class="input-group">
                <label for="genero" class="label-gold">Gênero</label>
                <select class="input-field" id="genero" name="genero" required>
                    <option value="">Selecione</option>
                    <%for (String genero : generos) {%>
                    <option value="<%out.print(genero);%>"<%
                        if (op.equals(listarPorIdStr) && !lfilm.isEmpty() && lfilm.getFirst().getGenero().equals(genero))
                            out.print(" selected");
                    %>><%out.print(genero);%></option>
                    <%}%>
                </select>
            </div>

            <div class="input-group">
                <label for="duracao" class="label-gold">Duração</label>
                <input type="number" id="duracao" name="duracao" placeholder="Minutos" class="input-field" required
                       min="2" <%
                    if (op.equals(listarPorIdStr) && !lfilm.isEmpty()) {
                        out.print(String.format("value='%s'", lfilm.getFirst().getDuracao()));
                    }
                %> />
            </div>
        </section>

        <section class="button-column">

            <input type="submit" class="btn-action" value="<%if (op.equals(listarPorIdStr) && !lfilm.isEmpty()) {
                        out.print("Editar");
                    } else {
                        out.print("Cadastrar");
                    }; out.print(" " + model);%>">

            <a href="controle?model=<%out.print(paginaAnterior);%>&op=<%out.print(listarTodosStr);%>">
                <button type="button" class="btn-action">
                    Voltar
                </button>
            </a>

        </section>
    </form>
</main>

</body>
</html>