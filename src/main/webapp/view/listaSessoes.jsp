<%--
    Document   : TelaCartaz
    Created on : 1 de abr. de 2026, 17:25:54
    Author     : PC
--%>

<%@page import="model.FilmeModel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.SessaoModel"%>
<%@page import="model.SalaModel"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="util.NomesModel" %>
<%@ page import="util.AcoesCommand" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cartaz</title>
        <link rel="stylesheet" href="view/style/botaoAdicionar.css">
        <link rel="stylesheet" href="view/style/listaSessoes.css">
        <link rel="stylesheet" href="view/style/menuModel.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>

    <body>
        <%
            String op = request.getParameter("op");
            NomesModel sessaoEnum = NomesModel.SESSAO;
            List<HashMap<String, Object>> lsessao = (List<HashMap<String, Object>>) request.getAttribute("sessoes");
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
                                    <div>Filme<a href="controle?model=<%out.print(NomesModel.FILME.getSingular());%>&from=<%out.print(sessaoEnum.getSingularSemAcento());%>" class="btn-add">+</a></div>
                                </th>
                                <th>
                                    <div>Sess&atilde;o<a href="controle?model=<%out.print(sessaoEnum.getSingularSemAcento());%>&op=<%out.print(AcoesCommand.CADASTRAR.getAcao());%>&from=<%out.print(sessaoEnum.getSingularSemAcento());%>" class="btn-add">+</a></div>
                                </th>
                                <th>Dura&ccedil;&atilde;o</th>
                                <th>G&ecirc;nero</th>
                                <th>Sala<a href="controle?model=<%out.print(NomesModel.SALA.getSingular());%>&from=<%out.print(sessaoEnum.getSingularSemAcento());%>" class="btn-add">+</a></th>
                                <th>Capacidade</th>
                                <th>A&ccedil;&otilde;es</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%if (lsessao != null)
                                    for (HashMap<String, Object> se : lsessao) {
                                        SessaoModel sessao = (SessaoModel) se.get("sessao");
                                        FilmeModel filme = (FilmeModel) se.get("filme");
                                        SalaModel sala = (SalaModel) se.get("sala");
                                        String padraoData = "HH:mm (dd/MM/yyyy)";
                                        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(padraoData);
                            %>
                            <tr>
                                <td>
                                    <div class="celula-filme">
                                        <img src="images/icone.png" class="mini-poster" alt="miniposter">
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
                                        <%if (!(op.equals(AcoesCommand.CONSULTAR_ID.getAcao()))) {%>
                                        <a href="controle?op=<%out.print(AcoesCommand.DELETAR.getAcao());%>&id=<%out.print(sessao.getId());%>&model=<%out.print(sessaoEnum.getSingularSemAcento());%>" class="btn-acao btn-excluir">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                        <%}%>
                                        <!-- ?? EDITAR (DIREITA) -->
                                        <div class="menu-editar">
                                            <button class="btn-acao btn-editar">
                                                <i class="fas fa-edit"></i></button>

                                            <div class="opcoes">
                                                <a href="controle?op=<%out.print(AcoesCommand.CONSULTAR_ID.getAcao());%>&id=<%out.print(filme.getId());%>&model=<%out.print(NomesModel.FILME.getSingularSemAcento());%>&from=<%out.print(sessaoEnum.getSingularSemAcento());%>">Filme</a>
                                                <a href="controle?op=<%out.print(AcoesCommand.CONSULTAR_ID.getAcao());%>&id=<%out.print(sessao.getId());%>&model=<%out.print(sessaoEnum.getSingularSemAcento());%>&from=<%out.print(sessaoEnum.getSingularSemAcento());%>">Sess&atilde;o</a>
                                                <a href="controle?op=<%out.print(AcoesCommand.CONSULTAR_ID.getAcao());%>&id=<%out.print(sala.getId());%>&model=<%out.print(NomesModel.SALA.getSingularSemAcento());%>&from=<%out.print(sessaoEnum.getSingularSemAcento());%>">Sala</a>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </section>

            </main>
        </div>
    </body>
</html>