<%@page import="model.FilmeModel"%>
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
            String target = "Filme";
            String targetSessao = "Sessao";
            String targetSala = "Sala";
            String targetCliente = "Cliente";
            String[] generos = {"Sci-Fi", "Crime", "Animação", "Drama", "Ação"};
            String atualizarStr = "Atualizar";
            String cadastrarStr = "Cadastrar";
            String listarTodosStr = "ConsultarTodos";
            String listarPorIdStr = "ConsultarId";
            String deletarStr = "Deletar";
            List<FilmeModel> lfilm = (List<FilmeModel>) request.getAttribute("filmes");
        %>
        <header>
            <h1 class="logo">CinePlus</h1>
            <nav class="menu">
                <a href="controle?model=<%out.print(targetCliente);%>&op=<%out.print(listarTodosStr);%>">🤵 Clientes</a>
                <a href="controle?model=<%out.print(targetSala);%>&op=<%out.print(listarTodosStr);%>">💺️ Salas</a>
                <a href="controle?model=<%out.print(targetSessao);%>&op=<%out.print(listarTodosStr);%>">📅️ Em Cartaz</a>
                <a href="controle?model=<%out.print(target);%>&op=<%out.print(listarTodosStr);%>">🎞️️ Filmes</a>
            </nav>
        </header>
        <main>
            <h2><%if (op.equals(listarPorIdStr) && !lfilm.isEmpty()) {
                    out.print("Atualizar");
                } else {
                    out.print("Cadastrar");
                }; out.print(" " + target);%></h2>

            <%
                ArrayList<Integer> ids = new ArrayList<>();
                if (lfilm != null) {
                    for (int index = 0; index < lfilm.size(); index++) {
                        ids.add(lfilm.get(index).getId());
                    }
                }
            %>

            <form method="GET" action="controle" class="form_cadastro">
                <%if (op.equals(listarPorIdStr) && !lfilm.isEmpty()) {%>
                <input type="hidden" name="id" value="<%if (op.equals(listarPorIdStr) && lfilm != null && !lfilm.isEmpty()) {
                        out.print(lfilm.getFirst().getId());
                    }%>">
                <%}%>
                <input type="hidden" name="model" value="<%out.print(target);%>">
                <input type="hidden" name="op" value="<%
                    if (op.equals(listarPorIdStr) && !lfilm.isEmpty()) {
                        out.print(atualizarStr);
                    } else {
                        out.print(cadastrarStr);
                    }%>">
                <div id="inputs-form">
                    <div class="campo-form">
                        <label for="titulo">Título: </label>
                        <input type="text" id="titulo" name="titulo" placeholder="Nome" required <%if (op.equals(listarPorIdStr) && lfilm != null && !lfilm.isEmpty()) {
                                out.print(String.format("value='%s'", lfilm.getFirst().getTitulo()));
                            }%>>
                    </div>
                    <div class="campo-form">
                        <label for="genero">Gênero: </label>
                         <select id="genero" name="genero" required>
                            <option value="">Selecione</option>
                            <%for (String genero : generos) {%>
                            <option value="<%out.print(genero);%>"<%if (op.equals(listarPorIdStr) && lfilm != null && !lfilm.isEmpty() && lfilm.getFirst().getGenero().equals(genero)) out.print(" selected");%>><%out.print(genero);%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="campo-form">
                        <label for="duracao">Duração: </label>
                        <input type="number" id="duracao" name="duracao" placeholder="Minutos" required min="2" <%if (op.equals(listarPorIdStr) && lfilm != null && !lfilm.isEmpty()) {
                                out.print(String.format("value='%s'", lfilm.getFirst().getDuracao()));
                            }%> />
                    </div>
                </div>
                <input type="submit" value="<%if (op.equals(listarPorIdStr) && !lfilm.isEmpty()) {
                        out.print("Editar");
                    } else {
                        out.print("Cadastrar");
                    }; out.print(" " + target);%>">
            </form>

            <%if (op.equals(listarTodosStr) || lfilm.isEmpty()) {%>
            <section>
                <div class="consulta">
                    <h3>Consultar <%out.print(target);%> por ID</h3>
                    <form method="GET" action="controle">
                        <input type="hidden" name="model" value="<%out.print(target);%>">
                        <input type="hidden" name="op" value="<%out.print(listarPorIdStr);%>">
                        <input type="number" name="id" value="1" min="1" max="<%if (ids.size() > 1) {
                                out.print(ids.getLast());
                            }%>" id="consultaId" placeholder="Digite o ID do <%out.print(target.toLowerCase());%>">
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
                            <th>Título</th>
                            <th>Gênero</th>
                            <th>Duração</th>
                        </tr>

                        <%if (lfilm != null)
                                for (FilmeModel f : lfilm) {%>
                        <tr>
                            <td align="center"><a href="controle?op=<%out.print(deletarStr);%>&id=<%out.print(f.getId());%>&model=<%out.print(target);%>"><img src="images/lixeira01.png" width="25" height="25"></a></td>
                            <%if (!(op.equals(listarPorIdStr))) {%><td align="center"><a href="controle?op=<%out.print(listarPorIdStr);%>&id=<%out.print(f.getId());%>&model=<%out.print(target);%>" ><img src="images/editar01.png" width="25" height="25"></a></td><%}%>
                            <td><%out.print(String.format("%04d", f.getId()));%></td>
                            <td><%out.print(f.getTitulo());%></td>
                            <td><%out.print(f.getGenero());%></td>
                            <td><%out.print(f.getDuracao() + " minutos");%></td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </section>
        </main>
    </body>
</html>