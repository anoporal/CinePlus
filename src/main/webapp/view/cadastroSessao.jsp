<%--
    Document   : TelaSala
    Created on : 30 de mar. de 2026, 14:26:50
    Author     : PC
--%>

<%@page import="java.util.Date" %>
<%@page import="model.FilmeModel" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="model.SessaoModel" %>
<%@page import="model.SalaModel" %>
<%@page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="util.NomesModel" %>
<%@ page import="util.AcoesCommand" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlus - Cadastro de Sala e Sessão</title>
    <link rel="stylesheet" href="view/style/menuModel.css">
    <link rel="stylesheet" href="view/style/cadastroSessao.css">
    <script>
        <%String pattern = "YYYY-MM-dd HH:mm";
            SimpleDateFormat simpleDateFormatted = new SimpleDateFormat(pattern);
            String date = simpleDateFormatted.format(new Date());
            date = date.replaceFirst(" ", "T");%>

        setTimeout(() => document.getElementById("datePickerId").min = "<%out.print(date);%>", 1500);
    </script>
</head>
<body>
<%
    NomesModel sessaoEnum = NomesModel.SESSAO;
    String op = request.getParameter("op");
    if (op == null) {
        op = "";
    }
    String paginaAnterior = request.getParameter("from");
    if (paginaAnterior == null) {
        paginaAnterior = sessaoEnum.getSingularSemAcento();
    }
    HashMap<String, Object> sessao = (HashMap<String, Object>) request.getAttribute("sessao");
    HashMap<String, Object> opcoes = (HashMap<String, Object>) request.getAttribute("opcoes");
    Integer idSala = (Integer) request.getAttribute("idSala");
%>

<div class="menu-models">
    <button class="btn-menu">
        📲</button>

    <div class="menu-opcoes">
        <%for (NomesModel nomeModel : NomesModel.values()) {
            if (nomeModel.getSingular().equals(sessaoEnum.getSingular())) continue;
            if (nomeModel.getSingular().equals(NomesModel.INGRESSO.getSingular())) continue;%>
        <a href="controle?op=<%out.print(AcoesCommand.CONSULTAR_TODOS.getAcao());%>&model=<%out.print(nomeModel.getSingularSemAcento());%>"><%out.print(nomeModel.getPlural());%></a>
        <%}%>
    </div>
</div>

<div class="main-screen">
    <div class="main-container">
        <section class="panel sessao-section">
            <h1 class="neon-title"><%
                if (op.equals(AcoesCommand.CONSULTAR_ID.getAcao()) && sessao != null) {
                    out.print("Atualizar");
                } else {
                    out.print("Cadastrar");
                }
                out.print(" " + sessaoEnum.getSingular());
            %></h1>

            <div class="sessao-content">
                <form action="controle" method="POST" class="form-neon">
                    <%if (op.equals(AcoesCommand.CONSULTAR_ID.getAcao()) && sessao != null) {%>
                    <input type="hidden" name="id" value="<%out.print(((SessaoModel) sessao.get("sessao")).getId());
                    %>">
                    <%}%>
                    <input type="hidden" name="from" value="<%out.print(paginaAnterior);%>">
                    <input type="hidden" name="model" value="<%out.print(sessaoEnum.getSingularSemAcento());%>">
                    <input type="hidden" name="op" value="<%
                    if (op.equals(AcoesCommand.CONSULTAR_ID.getAcao()) && sessao != null) {
                        out.print(AcoesCommand.ATUALIZAR.getAcao());
                    } else {
                        out.print(AcoesCommand.CADASTRAR.getAcao());
                    }%>">
                    <div class="input-group">
                        <label for="datePickerId">HORÁRIO</label>
                        <input type="datetime-local" id="datePickerId" name="dataHora" placeholder="Horário" required <%
                            if (op.equals(AcoesCommand.CONSULTAR_ID.getAcao()) && sessao != null) {
                                out.print(String.format("value=\"%s\"", simpleDateFormatted.format(((SessaoModel) sessao.get("sessao")).getDataHora())));
                            }
                        %> />
                    </div>

                    <div class="input-group">
                        <label for="idFilme">FILME</label>
                        <select id="idFilme" name="idFilme" required>
                            <option value="">Selecione</option>
                            <%
                                for (FilmeModel filme : (List<FilmeModel>) opcoes.get("filmes")) {
                            %>
                            <option value="<%out.print(filme.getId());%>" <%
                                if (op.equals(AcoesCommand.CONSULTAR_ID.getAcao())) {
                                    assert sessao != null;
                                    if (filme.getId() == ((FilmeModel) sessao.get("filme")).getId()) {
                                        out.print("selected");
                                    }
                                }
                            %>><%
                                out.print(filme.getTitulo());
                            %></option>
                            <%}%>
                        </select>
                    </div>

                    <div class="input-group">
                        <label for="idSala">SALA</label>
                        <%if (!(op.equals(AcoesCommand.CONSULTAR_ID.getAcao()))) {%>
                        <select id="idSala" name="idSala" required>
                            <option value="">Selecione</option>
                            <%
                                for (SalaModel sala : (List<SalaModel>) opcoes.get("salas")) {
                            %>
                            <option value="<%out.print(sala.getId());%>" <%if (idSala != null && sala.getId() == idSala) out.print("selected");%>>
                                <%out.print(sala.getId() + " - " + sala.getCapacidade() + " vagas");%>
                            </option>
                            <%}%>
                        </select>
                        <%} else {%>
                        <h3><%
                            assert sessao != null;
                            out.print(((SalaModel) sessao.get("sala")).getId());%></h3>
                        <%}%>
                    </div>

                    <input type="submit" class="btn-neon" value="<%if (op.equals(AcoesCommand.CONSULTAR_ID.getAcao())) {
                        out.print("EDITAR");
                    } else {
                        out.print("CADASTRAR");
                    };
                    out.print(" " + sessaoEnum.getSingular().toUpperCase());%>">
                </form>
            </div>
        </section>
    </div>
    <a href="controle?model=<%out.print(paginaAnterior);%>&op=<%out.print(AcoesCommand.CONSULTAR_TODOS.getAcao());%>"
       class="btn-voltar">VOLTAR</a>
</div>

</body>
</html>