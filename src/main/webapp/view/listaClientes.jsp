<%@page import="model.IngressoModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.ClienteModel"%>
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
            String target = "Cliente";
            String targetSessao = "Sessao";
            String targetFilme = "Filme";
            String targetSala = "Sala";
            String targetIngresso = "Ingresso";
            String listarTodosStr = "ConsultarTodos";
            String listarPorIdStr = "ConsultarId";
            String listarCadastroStr = "ConsultarCadastro";
            String deletarStr = "Deletar";
            List<ClienteModel> lcli = (List<ClienteModel>) request.getAttribute("clientes");
        %>
        <header>
            <h1 class="logo">CinePlus</h1>
            <nav class="menu">
                <a href="controle?model=<%out.print(target);%>&op=<%out.print(listarTodosStr);%>">🤵 Clientes</a>
                <a href="controle?model=<%out.print(targetSala);%>&op=<%out.print(listarTodosStr);%>">💺️ Salas</a>
                <a href="controle?model=<%out.print(targetSessao);%>&op=<%out.print(listarTodosStr);%>">📅️ Em Cartaz</a>
                <a href="controle?model=<%out.print(targetFilme);%>&op=<%out.print(listarTodosStr);%>">🎞️️ Filmes</a>
            </nav>
        </header>
        <main>

            <%
                ArrayList<Integer> ids = new ArrayList<>();
                if (lcli != null) {
                    for (int index = 0; index < lcli.size(); index++) {
                        ids.add(lcli.get(index).getId());
                    }
                }
            %>

            <%if (op.equals(listarTodosStr) || lcli.isEmpty()) {%>
            <section>
                <div class="consulta">
                    <h3>Consultar <%out.print(target);%> por ID</h3>
                    <form method="GET" action="controle">
                        <input type="hidden" name="model" value="<%out.print(target);%>">
                        <input type="hidden" name="op" value="<%out.print(listarPorIdStr);%>">
                        <input type="number" name="id" value="1" min="1" max="<%if (ids.size() > 1) {
                                out.print(ids.getLast());
                            }%>" id="consultaId" placeholder="Digite o ID de <%out.print(target.toLowerCase());%>">
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
                            <th>Nome</th>
                            <th>Email</th>
                            <th>Telefone</th>
                            <th>Ingressos</th>
                        </tr>

                        <%if (lcli != null)
                                for (ClienteModel c : lcli) {%>
                        <tr>
                            <td align="center"><a href="controle?op=<%out.print(deletarStr);%>&id=<%out.print(c.getId());%>&model=<%out.print(target);%>"><img src="images/lixeira01.png" width="25" height="25"></a></td>
                            <%if (!(op.equals(listarPorIdStr))) {%><td align="center"><a href="controle?op=<%out.print(listarPorIdStr);%>&id=<%out.print(c.getId());%>&model=<%out.print(target);%>" ><img src="images/editar01.png" width="25" height="25"></a></td><%}%>
                            <td><%out.print(String.format("%04d", c.getId()));%></td>
                            <td><%out.print(c.getNome());%></td>
                            <td><%out.print(c.getEmail());%></td>
                            <td><%out.print(c.getTelefone());%></td>
                            <%if (c.getIngressos() == null || c.getIngressos().isEmpty()) {%>
                            <td><a href="controle?op=<%out.print(listarPorIdStr);%>&idCliente=<%out.print(c.getId());%>&model=<%out.print(targetIngresso);%>"><button>Comprar Ingresso</button></a></td>
                            <%} else {%>
                            <td><%
                                    ArrayList<Integer> listaIngressos = new ArrayList<>();
                                    for (IngressoModel ingresso : c.getIngressos()) {
                                        listaIngressos.add(ingresso.getId());
                                    }
                                    out.print(listaIngressos.toString());
                                    %><a href="controle?op=<%out.print(listarCadastroStr);%>&idCliente=<%out.print(c.getId());%>&model=<%out.print(targetIngresso);%>"><button>+</button></a><%
                                }%></td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </section>
        </main>
    </body>
</html>