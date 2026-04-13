<%--
    Document   : TelaIngresso
    Created on : 30 de mar. de 2026, 14:27:36
    Author     : PC
--%>

<%@page import="model.SalaModel" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="model.ClienteModel" %>
<%@page import="model.FilmeModel" %>
<%@page import="model.SessaoModel" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
<%@ page import="util.NomesModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CinePlus</title>
    <link rel="stylesheet" href="view/style/menuModel.css">
    <link rel="stylesheet" href="view/style/cadastroIngresso.css">
</head>
<body>
<%
    NomesModel model = NomesModel.Ingresso;
    String[] formasPagamento = {"Crédito", "Débito", "Dinheiro", "PIX"};
    String cadastrarStr = "Cadastrar";
    String listarTodosStr = "ConsultarTodos";
    ClienteModel cliente = (ClienteModel) request.getAttribute("cliente");
    List<HashMap<String, Object>> opcoes = (List<HashMap<String, Object>>) request.getAttribute("opcoes");
%>

<div class="menu-models">
    <button class="btn-menu">
        📲
    </button>

    <div class="menu-opcoes">
        <%
            for (NomesModel nomeModel : NomesModel.values()) {
                if (nomeModel == model) continue;
        %>
        <a href="controle?op=<%out.print(listarTodosStr);%>&model=<%out.print(nomeModel);%>"><%
            out.print(nomeModel);%></a>
        <%}%>
    </div>
</div>

<div class="main-container">
    <header class="ingresso-header"></header>

    <form method="GET" action="controle" class="ingresso-form">
        <input type="hidden" name="idCliente" value="<%out.print(cliente.getId());%>">
        <input type="hidden" name="model" value="<%out.print(model);%>">
        <input type="hidden" name="op" value="<%out.print(cadastrarStr);%>">
        <div class="col-client-value">
            <div class="info-group margin-top-20">
                <label for="valor" class="label-pill">Valor (R$)</label>
                <div class="value-wrapper input-gold">
                    <input type="number" id="valor" name="valor" placeholder="R$" required min="1" step=".5"
                           class="input-gold-inner"/>
                </div>
            </div>

            <div class="info-group">
                <span class="label-pill">Cliente: <h3><%out.println(cliente.getNome());%></h3></span>
            </div>
        </div>

        <div class="col-sessao">
            <label for="sessao" class="label-pill">Sessão</label>
            <div class="custom-select-wrapper">
                <select id="sessao" name="idSessao" class="input-gold" required>
                    <option value="">
                        <%
                            if (opcoes.isEmpty()) {
                                out.print("Capacidades esgotadas");
                            } else {
                                out.print("Selecione");
                            }
                        %>
                    </option>
                    <%
                        for (HashMap sessaoInfo : opcoes) {
                            SessaoModel sessao = (SessaoModel) sessaoInfo.get("sessao");
                            FilmeModel filme = (FilmeModel) sessaoInfo.get("filme");
                            SalaModel sala = (SalaModel) sessaoInfo.get("sala");
                            String padraoData = "HH:mm (dd/MM/yyyy)";
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(padraoData);
                    %>
                    <option value="<%out.print(sessao.getId());%>"><%
                        out.print(String.format("\"%s\" - %s vagas na Sala %s às %s", filme.getTitulo(), sala.getCapacidade(), sala.getId(), simpleDateFormat.format(sessao.getDataHora())));%></option>
                    <%}%>
                </select>
                <i class="icon-dropdown">⬇️</i>
            </div>
        </div>

        <div class="col-pagamento">
            <label for="formaPagamento" class="label-pill">Pagamento</label>
            <div class="custom-select-wrapper">
                <select id="formaPagamento" name="formaPagamento" class="input-gold" required>
                    <option value="">Selecione</option>
                    <%
                        for (String formapagamento : formasPagamento) {
                    %>
                    <option value="<%out.print(formapagamento);%>"><%out.print(formapagamento);%></option>
                    <%}%>
                </select>
                <i class="icon-dropdown">️️⬇️</i>
            </div>
        </div>

        <footer class="action-buttons">
            <a href="controle?model=<%out.print(NomesModel.Cliente);%>&op=<%out.print(listarTodosStr);%>">
                <button type="button" class="btn-ticket">
                    Voltar
                </button>
            </a>
            <button type="submit" class="btn-ticket">Confirmar</button>
        </footer>
    </form>
</div>
</body>
</html>