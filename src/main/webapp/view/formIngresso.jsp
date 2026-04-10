<%-- 
    Document   : listaSalas
    Created on : 30 de mar. de 2026, 17:46:25
    Author     : lucas
--%>

<%@page import="model.SalaModel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.ClienteModel"%>
<%@page import="model.FilmeModel"%>
<%@page import="model.SessaoModel"%>
<%@page import="java.util.Hashtable"%>
<%@page import="model.IngressoModel"%>
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
            String target = "Ingresso";
            String targetSessao = "Sessao";
            String targetFilme = "Filme";
            String targetSala = "Sala";
            String targetCliente = "Cliente";
            String[] formasPagamento = {"Crédito", "Débito", "Dinheiro", "PIX"};
            String cadastrarStr = "Cadastrar";
            String listarTodosStr = "ConsultarTodos";
            ClienteModel cliente = (ClienteModel) request.getAttribute("cliente");
            List<Hashtable> opcoes = (List<Hashtable>) request.getAttribute("opcoes");
        %>
        <header>
            <h1 class="logo">CinePlus</h1>
            <nav class="menu">
                <a href="controle?model=<%out.print(targetCliente);%>&op=<%out.print(listarTodosStr);%>">🤵 Clientes</a>
                <a href="controle?model=<%out.print(targetSala);%>&op=<%out.print(listarTodosStr);%>">💺️ Salas</a>
                <a href="controle?model=<%out.print(targetSessao);%>&op=<%out.print(listarTodosStr);%>">📅️ Em Cartaz</a>
                <a href="controle?model=<%out.print(targetFilme);%>&op=<%out.print(listarTodosStr);%>">🎞️️ Filmes</a>
            </nav>
        </header>
        <main>
            <h2>Cadastrar Ingresso</h2>

            <form method="GET" action="controle" class="form_cadastro">
                <input type="hidden" name="idCliente" value="<%out.print(cliente.getId());%>">
                <input type="hidden" name="model" value="<%out.print(target);%>">
                <input type="hidden" name="op" value="<%out.print(cadastrarStr);%>">
                <div id="inputs-form">
                    <div class="campo-form">
                        <label for="cliente">
                            Cliente:  <h3><%out.println(cliente.getNome());%></h3>
                        </label>
                    </div>
                    <div class="campo-form">
                        <label for="sessao">Sessão:  </label>
                        <select id="sessao" name="idSessao" required>
                            <option value="">
                                <%if (opcoes.isEmpty()) {
                                        out.print("Capacidades esgotadas");
                                    } else {
                                        out.print("Selecione");
                                    }%>
                            </option>
                            <%for (Hashtable sessaoInfo : opcoes) {
                                    SessaoModel sessao = (SessaoModel) sessaoInfo.get("sessao");
                                    FilmeModel filme = (FilmeModel) sessaoInfo.get("filme");
                                    SalaModel sala = (SalaModel) sessaoInfo.get("sala");
                                    String padraoData = "HH:mm (dd/MM/yyyy)";
                                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(padraoData);
                            %>
                            <option value="<%out.print(sessao.getId());%>"><%out.print(String.format("\"%s\" - %s vagas na Sala %s às %s", filme.getTitulo(), sala.getCapacidade(), sala.getId(), simpleDateFormat.format(sessao.getDataHora())));%></option>
                            <%}%>
                        </select>
                    </div>
                        
                    <div class="campo-form">
                        <label for="formaPagamento">Forma de Pagamento:  </label>
                        <select id="formaPagamento" name="formaPagamento" required>
                            <option value="">Selecione</option>
                            <%for (String formapagamento : formasPagamento) {
                            %>
                            <option value="<%out.print(formapagamento);%>"><%out.print(formapagamento);%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="campo-form">
                        <label for="valor">Valor do Pagamento:  </label>
                        <input type="number" id="valor" name="valor" placeholder="R$" required min="1" step=".5"/>
                    </div>
                </div>
                <input type="submit" value="Comprar Ingresso">
            </form>
        </main>
    </body>
</html>