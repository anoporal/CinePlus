<%--
    Document   : TelaCliente
    Created on : 30 de mar. de 2026, 14:27:07
    Author     : PC
--%>

<%@page import="java.text.SimpleDateFormat" %>
<%@page import="model.SessaoModel" %>
<%@page import="model.SalaModel" %>
<%@page import="java.util.List" %>
<%@ page import="util.NomesModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinePlus</title>
    <link rel="stylesheet" href="view/style/botaoAdicionar.css">
    <link rel="stylesheet" href="view/style/menuModel.css">
    <link rel="stylesheet" href="view/style/listaSalas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<%
    NomesModel model = NomesModel.Sala;
    String listarPorIdStr = "ConsultarId";
    String listarTodosStr = "ConsultarTodos";
    String consultarCadastroStr = "ConsultarCadastro";
    String deletarStr = "Deletar";
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

<div class="container-geral">
    <header class="header-topo"></header>

    <main class="layout-principal">

        <section class="area-tabela">
            <table class="tabela-sala">
                <thead>
                <tr>
                    <th>ID<a href="controle?model=<%out.print(model);%>&from=<%out.print(model);%>" class="btn-add">+</a></th>
                    <th>Capacidade</th>
                    <th>Sessões<a href="controle?model=<%out.print(NomesModel.Sessao);%>&op=<%out.print(consultarCadastroStr);%>&from=<%out.print(model);%>" class="btn-add">+</a></th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (lsala != null)
                        for (SalaModel sa : lsala) {
                %>
                <tr>
                    <td><%out.print(String.format("%04d", sa.getId()));%></td>
                    <td><%out.print(sa.getCapacidade());%></td>
                    <td class="coluna-sessoes">
                        <%if (sa.getSessoes().isEmpty()) {%>
                        Nenhuma Sessão
                        <%} else if (!lsala.isEmpty()) {%>
                        <div class="info-sessao-column">
                            <%
                                String padraoData = "HH:mm (dd/MM/yyyy)";
                                SimpleDateFormat simpleDateFormat = new SimpleDateFormat(padraoData);
                                for (SessaoModel sessao : sa.getSessoes()) {%>
                                <div class="info-sessao-group">
                                    <p class="info-sessao">
                                        <%out.print("ID: " + sessao.getId());%>
                                    </p>
                                    <p class="info-sessao">
                                        <%out.print("Filme: " + sessao.getFilme().getTitulo());%>
                                    </p>
                                    <p class="info-sessao">
                                        <%out.print("Horário: " + simpleDateFormat.format(sessao.getDataHora()));%>
                                    </p>
                                </div>
                            <%}%>
                        </div>
                        <%}%>
                        <a href="controle?model=<%out.print(NomesModel.Sessao);%>&op=<%out.print(consultarCadastroStr);%>&from=<%out.print(model);%>&idSala=<%out.print(sa.getId());%>" class="btn-add">+</a>
                    </td>
                    <td class="coluna-acoes">
                        <a href="controle?op=<%out.print(listarPorIdStr);%>&id=<%out.print(sa.getId());%>&model=<%out.print(model);%>&from=<%out.print(model);%>"
                           class="btn-tabela btn-editar" title="Editar">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="controle?op=<%out.print(deletarStr);%>&id=<%out.print(sa.getId());%>&model=<%out.print(model);%>&from=<%out.print(model);%>"
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