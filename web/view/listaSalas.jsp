<%-- 
    Document   : listaSalas
    Created on : 30 de mar. de 2026, 17:46:25
    Author     : lucas
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.SessaoModel"%>
<%@page import="model.SalaModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CinePlus</title>
        <link rel="stylesheet" href="view/style/style.css"/>
    </head>
    <body>
        <%
            String op = request.getParameter("op");
            String target = "Sala";
            String targetSessao = "Sessao";
            String targetFilme = "Filme";
            String targetCliente = "Cliente";
            String atualizarStr = "Atualizar";
            String cadastrarStr = "Cadastrar";
            String listarTodosStr = "ConsultarTodos";
            String listarPorIdStr = "ConsultarId";
            String deletarStr = "Deletar";
            List<SalaModel> lsala = (List<SalaModel>) request.getAttribute("salas");
        %>
        <header>
            <h1 class="logo">CinePlus</h1>
            <nav class="menu">
                <a href="controle?model=<%out.print(targetCliente);%>&op=<%out.print(listarTodosStr);%>">🤵 Clientes</a>
                <a href="controle?model=<%out.print(target);%>&op=<%out.print(listarTodosStr);%>">💺️ Salas</a>
                <a href="controle?model=<%out.print(targetSessao);%>&op=<%out.print(listarTodosStr);%>">📅️ Em Cartaz</a>
                <a href="controle?model=<%out.print(targetFilme);%>&op=<%out.print(listarTodosStr);%>">🎞️️ Filmes</a>
            </nav>
        </header>
        <main>
            <h2><%if (op.equals(listarPorIdStr) && !lsala.isEmpty()) {
                    out.print("Atualizar");
                } else {
                    out.print("Cadastrar");
                };
                out.print(" " + target);%></h2>

            <%
                ArrayList<Integer> ids = new ArrayList<>();
                if (lsala != null) {
                    for (int index = 0; index < lsala.size(); index++) {
                        ids.add(lsala.get(index).getId());
                    }
                }
            %>

            <form method="GET" action="controle" class="form_cadastro">
                <%if (op.equals(listarPorIdStr) && !lsala.isEmpty()) {%>
                <input type="hidden" name="id" value="<%if (op.equals(listarPorIdStr) && lsala != null && !lsala.isEmpty()) {
                        out.print(lsala.getFirst().getId());
                    }%>">
                <%}%>
                <input type="hidden" name="model" value="<%out.print(target);%>">
                <input type="hidden" name="op" value="<%
                    if (op.equals(listarPorIdStr) && !lsala.isEmpty()) {
                        out.print(atualizarStr);
                    } else {
                        out.print(cadastrarStr);
                    }%>">
                <div id="inputs-form">
                    <div class="campo-form">
                        <label for="capacidade">Capacidade:  </label>
                        <input type="number" id="capacidade" name="capacidade" placeholder="Assentos" required min="2" <%if (op.equals(listarPorIdStr) && lsala != null && !lsala.isEmpty()) {
                                out.print(String.format("value='%s'", lsala.getFirst().getCapacidade()));
                            }%> />
                    </div>
                </div>
                <input type="submit" value="<%if (op.equals(listarPorIdStr) && !lsala.isEmpty()) {
                        out.print("Editar");
                    } else {
                        out.print("Cadastrar");
                    };
                    out.print(" " + target);%>">
            </form>

            <%if (op.equals(listarTodosStr) || lsala.isEmpty()) {%>
            <section>
                <div class="consulta">
                    <h3>Consultar <%out.print(target);%> por ID</h3>
                    <form method="GET" action="controle">
                        <input type="hidden" name="model" value="<%out.print(target);%>">
                        <input type="hidden" name="op" value="<%out.print(listarPorIdStr);%>">
                        <input type="number" name="id" value="1" min="1" max="<%if (ids.size() > 1) {
                                out.print(ids.getLast());
                            }%>" id="consultaId" placeholder="Digite o ID da <%out.print(target.toLowerCase());%>">
                        <input type="submit" value="Buscar <%out.print(target);%>">
                    </form>
                </div>
            </section>
            <%}%>

            <hr>

            <section>
                <div id="listagem">
                    <table>
                        <tr>
                            <th class="noborder"></th>
                            <%if (!(op.equals(listarPorIdStr))) {%><th class="noborder"></th><%}%>
                            <th>ID</th>
                            <th>Capacidade</th>
                            <th>Sessões</th>
                        </tr>

                        <%if (lsala != null)
                                for (SalaModel sa : lsala) {%>
                        <tr>
                            <td align="center"><a href="controle?op=<%out.print(deletarStr);%>&id=<%out.print(sa.getId());%>&model=<%out.print(target);%>"><img src="images/lixeira01.png" width="25" height="25"></a></td>
                            <%if (!(op.equals(listarPorIdStr))) {%><td align="center"><a href="controle?op=<%out.print(listarPorIdStr);%>&id=<%out.print(sa.getId());%>&model=<%out.print(target);%>" ><img src="images/editar01.png" width="25" height="25"></a></td><%}%>
                            <td><%out.print(String.format("%04d", sa.getId()));%></td>
                            <td><%out.print(sa.getCapacidade());%></td>
                            <%if (sa.getSessoes().isEmpty()) {%>
                            <td>Nenhuma Sessão</td>
                            <%} else if (lsala.size() > 0) {%>
                            <td>
                                <%
                                    String padraoData = "HH:mm (dd/MM/yyyy)";
                                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(padraoData);
                                    for (SessaoModel sessao : sa.getSessoes()) {%>
                                <p>
                                    <%out.print(String.format("ID: %s, Filme: \"%s\" às %s", sessao.getId(), sessao.getFilme().getTitulo(), simpleDateFormat.format(sessao.getDataHora())));%>
                                </p>
                                <%}%>
                            </td>
                            <%}%>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </section>
        </main>
    </body>
</html>