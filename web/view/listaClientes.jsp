<%--
    Document   : TelaCliente
    Created on : 30 de mar. de 2026, 14:27:07
    Author     : PC
--%>

<%@page import="model.IngressoModel" %>
<%@page import="java.util.ArrayList" %>
<%@page import="model.ClienteModel" %>
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
    <link rel="stylesheet" href="view/style/listaClientes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<%
    NomesModel model = NomesModel.Cliente;
    String listarPorIdStr = "ConsultarId";
    String listarTodosStr = "ConsultarTodos";
    String listarCadastroStr = "ConsultarCadastro";
    String deletarStr = "Deletar";
    List<ClienteModel> lcli = (List<ClienteModel>) request.getAttribute("clientes");
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
            <table class="tabela-cliente">
                <thead>
                <tr>
                    <th>Cliente<a href="controle?model=<%out.print(model);%>&from=<%out.print(model);%>" class="btn-add">+</a></th>
                    <th>Telefone</th>
                    <th>E-mail</th>
                    <th>Ingressos</th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (lcli != null)
                        for (ClienteModel c : lcli) {
                %>
                <tr>
                    <td><%out.print(c.getNome());%></td>
                    <td><%out.print(c.getTelefone());%></td>
                    <td><%out.print(c.getEmail());%></td>
                    <td>
                    <%if (c.getIngressos() == null || c.getIngressos().isEmpty()) {%>
                        Nenhum
                    <%} else {%>
                    <%
                        ArrayList<Integer> listaIngressos = new ArrayList<>();
                        for (IngressoModel ingresso : c.getIngressos()) {
                            listaIngressos.add(ingresso.getId());
                        }
                        out.print(listaIngressos.toString());
                    %><%
                        }%>
                        <a href="controle?op=<%out.print(listarCadastroStr);%>&idCliente=<%out.print(c.getId());%>&model=<%out.print(NomesModel.Ingresso);%>"
                           class="btn-add-ingresso" title="Novo Ingresso">+</a>
                    </td>
                    <td class="coluna-acoes">
                        <a href="controle?op=<%out.print(listarPorIdStr);%>&id=<%out.print(c.getId());%>&model=<%out.print(model);%>"
                           class="btn-tabela btn-editar" title="Editar">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="controle?op=<%out.print(deletarStr);%>&id=<%out.print(c.getId());%>&model=<%out.print(model);%>"
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