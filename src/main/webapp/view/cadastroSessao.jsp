<%--
    Document   : listaSessoes
    Created on : 31 de mar. de 2026, 17:53:15
    Author     : Breno
--%>

<%@page import="java.util.Date"%>
<%@page import="model.FilmeModel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.SessaoModel"%>
<%@page import="model.SalaModel"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.HashMap" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CinePlus</title>
        <link rel="stylesheet" href="../view/style/style.css"/>
    </head>
    <body>
        <%
            String op = request.getParameter("op");
            if (op == null) {
                op = "";
            }
            String target = "Sessao";
            String targetFilme = "Filme";
            String targetSala = "Sala";
            String targetCliente = "Cliente";
            String atualizarStr = "Atualizar";
            String cadastrarStr = "Cadastrar";
            String listarTodosStr = "ConsultarTodos";
            String listarPorIdStr = "ConsultarId";
            HashMap<String, Object> sessao = (HashMap<String, Object>) request.getAttribute("sessao");
            HashMap<String, Object> opcoes = (HashMap<String, Object>) request.getAttribute("opcoes");
        %>
        <header>
            <script>
                <%String pattern = "YYYY-MM-dd HH:mm";
                    SimpleDateFormat simpleDateFormatted = new SimpleDateFormat(pattern);
                    String date = simpleDateFormatted.format(new Date());
                    date = date.replaceFirst(" ", "T");%>

                setTimeout(() => document.getElementById("datePickerId").min = "<%out.print(date);%>", 1500);
            </script>
            <h1 class="logo">CinePlus</h1>
            <nav class="menu">
                <a href="controle?model=<%out.print(targetCliente);%>&op=<%out.print(listarTodosStr);%>">🤵 Clientes</a>
                <a href="controle?model=<%out.print(targetSala);%>&op=<%out.print(listarTodosStr);%>">💺️ Salas</a>
                <a href="controle?model=<%out.print(target);%>&op=<%out.print(listarTodosStr);%>">📅️ Em Cartaz</a>
                <a href="controle?model=<%out.print(targetFilme);%>&op=<%out.print(listarTodosStr);%>">🎞️️ Filmes</a>
            </nav>
        </header>
        <main>
            <h2><%if (op.equals(listarPorIdStr) && sessao != null) {
                    out.print("Atualizar");
                } else {
                    out.print("Cadastrar");
                };
                out.print(" " + target);%></h2>

            <form method="POST" action="controle" class="form_cadastro">
                <%if (op.equals(listarPorIdStr) && sessao != null) {%>
                <input type="hidden" name="id" value="<%out.print(((SessaoModel) sessao.get("sessao")).getId());
                    %>">
                <%}%>
                <input type="hidden" name="model" value="<%out.print(target);%>">
                <input type="hidden" name="op" value="<%
                    if (op.equals(listarPorIdStr) && sessao != null) {
                        out.print(atualizarStr);
                    } else {
                        out.print(cadastrarStr);
                    }%>">
                <div id="inputs-form">
                    <div class="campo-form">
                        <label for="dataHora">Horário: </label>
                        <input type="datetime-local" id="datePickerId" name="dataHora" placeholder="Horário" required <%if (op.equals(listarPorIdStr) && sessao != null) {
                                out.print(String.format("value=\"%s\"", simpleDateFormatted.format(((SessaoModel) sessao.get("sessao")).getDataHora())));
                            }%> />
                    </div>
                    <div class="campo-form">
                        <label for="idFilme">Filme: </label>
                        <select id="idFilme" name="idFilme" required>
                            <option value="">Selecione</option>
                            <%for (FilmeModel filme : (List<FilmeModel>) opcoes.get("filmes")) {
                            %>
                            <option value="<%out.print(filme.getId());%>" <%if (op.equals(listarPorIdStr)) {
                                assert sessao != null;
                                if (filme.getId() == ((FilmeModel) sessao.get("filme")).getId()) {
                                    out.print("selected");
                                }
                            }
                            %>><%out.print(filme.getTitulo());
                                %></option>
                                <%}%>
                        </select>
                    </div>
                    <div class="campo-form">
                        <label for="idSala">Sala: </label>
                        <%if (!(op.equals(listarPorIdStr))) {%>
                        <select id="idSala" name="idSala" required>
                            <option value="">Selecione</option>
                            <%for (SalaModel sala : (List<SalaModel>) opcoes.get("salas")) {
                            %>
                            <option value="<%out.print(sala.getId());%>" <%
                            %>><%out.print(sala.getId() + " - " + sala.getCapacidade() + " vagas");
                                %></option>
                                <%}%>
                        </select>
                        <%} else {%>
                        <h3><%
                            assert sessao != null;
                            out.print(((SalaModel) sessao.get("sala")).getId());%></h3>
                        <%}%>
                    </div>
                </div>
                <input type="submit" value="<%if (op.equals(listarPorIdStr)) {
                        out.print("Editar");
                    } else {
                        out.print("Cadastrar");
                    };
                    out.print(" " + target);%>">
            </form>
        </main>
    </body>
</html>