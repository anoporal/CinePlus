<%-- 
    Document   : TelaCartaz
    Created on : 1 de abr. de 2026, 17:25:54
    Author     : PC
--%>

<%@page import="java.util.Date"%>
<%@page import="model.FilmeModel"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.SessaoModel"%>
<%@page import="model.SalaModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cartaz</title>
        <link rel="stylesheet" href="view/style/listaSessoes.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>

    <body>
        <%
            String op = request.getParameter("op");
            String target = "Sessao";
            String targetSala = "Sala";
            String targetFilme = "Filme";
            String listarTodosStr = "ConsultarTodos";
            String listarPorIdStr = "ConsultarId";
            String deletarStr = "Deletar";
            String consultarCadastroStr = "ConsultarCadastro";
            List<Hashtable> lsessao = (List<Hashtable>) request.getAttribute("sessoes");
        %>
        <div class="container-geral">

            <header class="cabecalho">
                <div class="letreiro-iluminado">
                    <h1>EM CARTAZ</h1>
                </div>

                <div class="decoracao-topo">
                    <img src="images/icone.png" alt="Desenho Claquete">
                </div>
            </header>

            <main class="layout-principal">

                <section class="area-tabela">
                    <table class="tabela-cineplus">

                        <thead>
                            <tr>
                                <th>
                                    <div>Filme<a href="controle?op=<%out.print(listarTodosStr);%>&model=<%out.print(targetFilme);%>" class="btn-add">+</a></div>
                                </th>
                                <th>
                                    <div>Sess&atilde;o<a href="controle?model=<%out.print(target);%>&op=<%out.print(consultarCadastroStr);%>" class="btn-add">+</a></div>
                                </th>
                                <th>Dura&ccedil;&atilde;o</th>
                                <th>G&ecirc;nero</th>
                                <th>Sala<a href="controle?op=<%out.print(listarTodosStr);%>&model=<%out.print(targetSala);%>" class="btn-add">+</a></th>
                                <th>Capacidade</th>
                                <th>A&ccedil;&otilde;es</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%if (lsessao != null)
                                    for (Hashtable se : lsessao) {
                                        SessaoModel sessao = (SessaoModel) se.get("sessao");
                                        FilmeModel filme = (FilmeModel) se.get("filme");
                                        SalaModel sala = (SalaModel) se.get("sala");
                                        String padraoData = "HH:mm (dd/MM/yyyy)";
                                        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(padraoData);
                            %>
                            <tr>
                                <td>
                                    <div class="celula-filme">
                                        <img src="images/icone.png" class="mini-poster">
                                        <span><%out.print(filme.getTitulo());%></span>
                                    </div>
                                </td>
                                <td><%out.print(simpleDateFormat.format(sessao.getDataHora()));%></td>
                                <td><%out.print(String.format("%sh %sm", filme.getDuracao() / 60, filme.getDuracao() % 60));%></td>
                                <td><span class="tag-genero"><%out.print(filme.getGenero());%></span></td>
                                <td>Sala <%out.print(sala.getId());%></td>
                                <td><i class="fas fa-users"></i> <%out.print(sala.getCapacidade());%></td>
                                <td>
                                    <div class="coluna-acoes">
                                        <!-- ?? EXCLUIR (ESQUERDA) -->
                                        <%if (!(op.equals(listarPorIdStr))) {%>
                                        <a href="controle?op=<%out.print(deletarStr);%>&id=<%out.print(sessao.getId());%>&model=<%out.print(target);%>" class="btn-acao btn-excluir">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                        <%}%>
                                        <!-- ?? EDITAR (DIREITA) -->
                                        <div class="menu-editar">
                                            <button class="btn-acao btn-editar">
                                                <i class="fas fa-edit"></i></button>

                                            <div class="opcoes">
                                                <a href="controle?op=<%out.print(listarPorIdStr);%>&id=<%out.print(filme.getId());%>&model=<%out.print(targetFilme);%>">Filme</a>
                                                <a href="controle?op=<%out.print(listarPorIdStr);%>&id=<%out.print(sessao.getId());%>&model=<%out.print(target);%>">Sess&atilde;o</a>
                                                <a href="controle?op=<%out.print(listarPorIdStr);%>&id=<%out.print(sala.getId());%>&model=<%out.print(targetSala);%>">Sala</a>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </section>

                <aside class="menu-lateral-cine"></aside>
            </main>
        </div>
    </body>
</html>
