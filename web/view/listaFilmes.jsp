<%--
    Document   : TelaCliente
    Created on : 30 de mar. de 2026, 14:27:07
    Author     : PC
--%>

<%@page import="model.FilmeModel" %>
<%@page import="java.util.List" %>
<%@ page import="util.NomesModel" %>
<%@ page import="util.AcoesCommand" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlus</title>
    <link rel="stylesheet" href="view/style/botaoAdicionar.css">
    <link rel="stylesheet" href="view/style/menuModel.css">
    <link rel="stylesheet" href="view/style/listaFilmes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<%
    NomesModel filmeEnum = NomesModel.FILME;
    List<FilmeModel> lfilm = (List<FilmeModel>) request.getAttribute("filmes");
%>

<div class="menu-models">
    <button class="btn-menu">
        📲</button>

    <div class="menu-opcoes">
        <%for (NomesModel nomeModel : NomesModel.values()) {
            if (nomeModel.getSingular().equals(filmeEnum.getSingular())) continue;
            if (nomeModel.getSingular().equals(NomesModel.INGRESSO.getSingular())) continue;%>
        <a href="controle?op=<%out.print(AcoesCommand.CONSULTAR_TODOS.getAcao());%>&model=<%out.print(nomeModel.getSingularSemAcento());%>"><%out.print(nomeModel.getPlural());%></a>
        <%}%>
    </div>
</div>

<div class="container-geral">
    <header class="header-topo"></header>

    <main class="layout-principal">

        <section class="area-tabela">
            <table class="tabela-filme">
                <thead>
                <tr>
                    <th>ID<a href="controle?model=<%out.print(filmeEnum.getSingularSemAcento());%>&from=<%out.print(filmeEnum.getSingularSemAcento());%>" class="btn-add">+</a></th>
                    <th>Título</th>
                    <th>Gênero</th>
                    <th>Duração</th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (lfilm != null)
                        for (FilmeModel f : lfilm) {
                %>
                <tr>
                    <td><%out.print(String.format("%04d", f.getId()));%></td>
                    <td><%out.print(f.getTitulo());%></td>
                    <td><%out.print(f.getGenero());%></td>
                    <td><%out.print(f.getDuracao() + " minutos");%></td>
                    <td class="coluna-acoes">
                        <a href="controle?op=<%out.print(AcoesCommand.CONSULTAR_ID.getAcao());%>&id=<%out.print(f.getId());%>&model=<%out.print(filmeEnum.getSingularSemAcento());%>&from=<%out.print(filmeEnum.getSingularSemAcento());%>"
                           class="btn-tabela btn-editar" title="Editar">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="controle?op=<%out.print(AcoesCommand.DELETAR.getAcao());%>&id=<%out.print(f.getId());%>&model=<%out.print(filmeEnum.getSingularSemAcento());%>&from=<%out.print(filmeEnum.getSingularSemAcento());%>"
                           class="btn-tabela btn-excluir" title="Excluir">
                            <i class="fas fa-trash-alt"></i>
                        </a>
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