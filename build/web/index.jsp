<%-- 
    Document   : index
    Created on : 20 de fev de 2023, 16:08:08
    Author     : user
--%>

<%@page import="web.*"%>
<%@page import="db.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<%
    String addException = null;
    ArrayList<Container> containers = new ArrayList<>();
    ArrayList<Movimentacao> movimentacoes = new ArrayList<>();
    try {
        containers = Container.getContainer();

        if (request.getParameter("addCon") != null) {
            int identificacao = Integer.parseInt(request.getParameter("idenCon"));
            String nomeCliente = request.getParameter("nomeCliente");
            String codigo = request.getParameter("codigo");
            int tipo = Integer.parseInt(request.getParameter("tipo"));
            String status = request.getParameter("status");
            String categoria = request.getParameter("categoria");
            Container container = new Container(
                    identificacao,
                    nomeCliente,
                    codigo,
                    tipo,
                    status,
                    categoria
            );
            Container.addContainer(container);
            response.sendRedirect(request.getRequestURI());
        }

        movimentacoes = Movimentacao.getMovimentacoes();

        if (request.getParameter("addMov") != null) {
            int idenMov = Integer.parseInt(request.getParameter("idenMov"));
            int idenCon = Integer.parseInt(request.getParameter("idenCon"));
            String movimentacao = request.getParameter("movimentacao");
            String dtIni = request.getParameter("dtIni");
            String dtFim = request.getParameter("dtFim");
            String hrIni = request.getParameter("hrIni");
            String hrFim = request.getParameter("hrFim");
            Movimentacao movi = new Movimentacao(
                    idenMov,
                    idenCon,
                    movimentacao,
                    dtIni,
                    dtFim,
                    hrIni,
                    hrFim
            );
            Movimentacao.addMovimentacao(movi);
            response.sendRedirect(request.getRequestURI());
        }

    } catch (Exception ex) {
        addException = ex.getMessage();
    }

    String altException = null;
    try {
        if (request.getParameter("delCon") != null) {
            int identificacao = Integer.parseInt(request.getParameter("idenCon"));
            Container.deleteContainer(identificacao);
            response.sendRedirect(request.getRequestURI());
        }

        if (request.getParameter("altCon") != null) {
            int identificacao = Integer.parseInt(request.getParameter("idenCon"));
            String nomeCliente = request.getParameter("nomeCliente");
            String codigo = request.getParameter("codigo");
            int tipo = Integer.parseInt(request.getParameter("tipo"));
            String status = request.getParameter("status");
            String categoria = request.getParameter("categoria");
            Container.alterarContainer(nomeCliente, codigo, tipo, status, categoria, identificacao);
            response.sendRedirect(request.getRequestURI());
        }

        if (request.getParameter("delMov") != null) {
            int idenMov = Integer.parseInt(request.getParameter("idenMov"));
            Movimentacao.deleteMovimentacao(idenMov);
            response.sendRedirect(request.getRequestURI());
        }

        if (request.getParameter("altMov") != null) {
            int idenMov = Integer.parseInt(request.getParameter("idenMov"));
            int idenCon = Integer.parseInt(request.getParameter("idenCon"));
            String movimentcao = request.getParameter("movimentacao");
            String dtIni = request.getParameter("dtIni");
            String dtFim = request.getParameter("dtFim");
            String hrIni = request.getParameter("hrIni");
            String hrFim = request.getParameter("hrFim");
            Movimentacao.alterarMovimentacao(idenCon, movimentcao, dtIni, dtFim, hrIni, hrFim, idenMov);
            response.sendRedirect(request.getRequestURI());
        }

    } catch (Exception ex) {
        altException = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body>
        <%if (addException != null) {%>
        <%= addException%>
        <%}%>
        <div class="container-fluid">
            <div><h3 style="margin-top: 42px; text-align: center;">Controle de Contêineres e Movimentações</h3></div>
            <div class="row" style="text-align: center">
                <div class="col">
                    <h4>Lista de Contêineres</h4>
                    <table class="table table-secondary table-bordered">
                        <thead>
                            <tr class="table-secondary">
                                <th>ID</th>
                                <th>Cliente</th>
                                <th>Cod Contêiner</th>
                                <th>Tipo</th>
                                <th>Status</th>
                                <th>Categoria</th>
                                <th>Ação</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (Container c : containers) {%>
                            <tr class="table-secondary">
                                <td><%= c.getIdentificacao()%></td>
                                <td><%= c.getNomeCliente()%></td>
                                <td><%= c.getCodContainer()%></td>
                                <td><%= c.getTipo()%></td>
                                <td><%= c.getStatus()%></td>
                                <td><%= c.getCategoria()%></td>
                                <td>
                                    <form>
                                        <button class="btn btn-primary" style="margin-right: 10%">
                                            <a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#altCon"
                                               onclick="setaIdCon('<%= c.getIdentificacao()%>')"> Alterar</a>
                                        </button>
                                        <input type="hidden" name="idenCon" value="<%= c.getIdentificacao()%>" />
                                        <input type="submit" name="delCon" value="Remover" class="btn btn-danger"/>
                                    </form>
                                </td>
                            </tr>

                        <div class="modal fade" id="altCon" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-sm text-center">
                                <div class="modal-content">
                                    <div class="modal-body">                    
                                        <h4 class="modal-title" id="exampleModalLabel" style="margin: auto;">Alterar Contêiner</h4><hr>
                                        <form method="post">                                                     
                                            <input type="hidden" name="idenCon" id="idenCon" class="form-control">
                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Nome do Cliente</span>
                                                <input type="text" name="nomeCliente" class="form-control"required>
                                            </div>

                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Código do Contêiner</span>
                                                <input type="text" name="codigo" pattern="[A-Z]{4}[0-9]{7}" placeholder="TEST1234567"
                                                       title="Código do Contêiner (4 letras e 7 números. Ex: TEST1234567)" class="form-control"required>
                                            </div>

                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Tipo</span>
                                                <select name="tipo" required>
                                                    <option value="20">20</option>
                                                    <option value="40">40</option>
                                                </select>
                                            </div>

                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Status</span>
                                                <select name="status" required>
                                                    <option value="Cheio">Cheio</option>
                                                    <option value="Vazio">Vazio</option>
                                                </select>
                                            </div>

                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Categoria</span>
                                                <select name="categoria" required>
                                                    <option value="Importação">Importação</option>
                                                    <option value="Exportação">Exportação</option>
                                                </select>
                                            </div>

                                            <input type="submit" name="altCon" value="Alterar" class="btn btn-primary" style="margin-right: 20%">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>      
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        </tbody>
                    </table>
                    <button class=" btn btn-primary"><a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#addCon">Adcionar Contêiner</a></button>
                </div>
            </div>

            <hr>

            <div class="row" style="text-align: center">
                <div class="col">
                    <h4>Lista de Movimentações</h4>
                    <table class="table table-secondary table-bordered">
                        <thead>
                            <tr class="table-secondary">
                                <th>ID Mov</th>
                                <th>ID Con</th>
                                <th>Cliente</th>
                                <th>Movimentção</th>
                                <th>Data Ini</th>
                                <th>Data Fim</th>
                                <th>Hora Ini</th>
                                <th>Hora Fim</th>
                                <th>Ação</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (Movimentacao m : movimentacoes) {%>
                            <tr class="table-secondary">
                                <td><%= m.getIdenMov()%></td>
                                <td><%= m.getIdenCon()%></td>
                                <td><%= m.getNomeCliente()%></td>
                                <td><%= m.getMovimentacao()%></td>
                                <td><%= m.getDtIni()%></td>
                                <td><%= m.getDtFim()%></td>
                                <td><%= m.getHrIni()%></td>
                                <td><%= m.getHrFim()%></td>
                                <td>
                                    <form>
                                        <button class="btn btn-primary" style="margin-right: 10%">
                                            <a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#altMov"
                                               onclick="setaIdMov('<%= m.getIdenMov()%>')"> Alterar</a>
                                        </button>
                                        <input type="hidden" name="idenMov" value="<%= m.getIdenMov()%>" />
                                        <input type="submit" name="delMov" value="Remover" class="btn btn-danger"/>
                                    </form>
                                </td>
                            </tr>

                        <div class="modal fade" id="altMov" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-sm text-center">
                                <div class="modal-content">
                                    <div class="modal-body">                    
                                        <h4 class="modal-title" id="exampleModalLabel" style="margin: auto;">Alterar Movimentação</h4><hr>
                                        <form method="post">                                                     
                                            <input type="hidden" name="idenMov" id="idenMov" class="form-control">
                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Id do Container</span>
                                                <input type="number" min="1" name="idenCon" class="form-control"required>
                                            </div>

                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Tipo</span>
                                                <select name="movimentacao" required>
                                                    <option value="Embarque">Embarque</option>
                                                    <option value="Descarga">Descarga</option>
                                                    <option value="Gate In">Gate In</option>
                                                    <option value="Gate Out">Gate Out</option>
                                                    <option value="Reposicionamento">Reposicionamento</option>
                                                    <option value="Pesagem">Pesagem</option>
                                                    <option value="Scanner">Scanner</option>
                                                </select>
                                            </div>

                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Data Ini.</span>
                                                <input type="text" name="dtIni" pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}"
                                                       title="Insira uma data no formato: DD/MM/AAAA" placeholder="DD/MM/AAAA" class="form-control" required>
                                            </div>

                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Data Fim</span>
                                                <input type="text" name="dtFim" pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}"
                                                       title="Insira uma data no formato: DD/MM/AAAA" placeholder="DD/MM/AAAA" class="form-control" required>
                                            </div>

                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Hora Ini.</span>
                                                <input type="text" name="hrIni" pattern="[0-9]{2}:[0-9]{2}:[0-9]{2}"
                                                       title="Insira uma data no formato: HH:MM:SS" placeholder="HH:MM:SS" class="form-control" required>
                                            </div>

                                            <div class="input-group input-group-sm mb-3">
                                                <span class="input-group-text" id="inputGroup-sizing-sm">Hora Fim</span>
                                                <input type="text" name="hrFim" pattern="[0-9]{2}:[0-9]{2}:[0-9]{2}"
                                                       title="Insira uma data no formato: HH:MM:SS" placeholder="HH:MM:SS" class="form-control" required>
                                            </div>

                                            <input type="submit" name="altMov" value="Alterar" class="btn btn-primary" style="margin-right: 20%">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>      
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        </tbody>
                    </table>
                    <button class=" btn btn-primary"><a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#addMov">Adcionar Movimentção</a></button>
                </div>
            </div>

            <hr>

            <div class="row" style="text-align: center;">
                <div class="col">
                    <button class=" btn btn-success"><a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#report">Gerar Relatório</a></button>
                    <div class="modal fade" id="report" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg text-center">
                            <div class="modal-content">
                                <div class="modal-body">                    
                                    <h4 class="modal-title" id="exampleModalLabel" style="margin: auto;">Realatório</h4><hr>
                                    <%
                                        int impor = 0;
                                        int expor = 0;
                                        Connection con = DatabaseListener.getConnection();
                                        Statement stmt = con.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT ic_categoria_importacao_exportacao FROM container");
                                        while (rs.next()) {
                                            String ie = rs.getString("ic_categoria_importacao_exportacao");
                                            if (ie.charAt(0) == 'I') {
                                                impor++;
                                            } else {
                                                expor++;
                                            }
                                        }
                                        rs.close();

                                        int qtcli = 0;
                                        ArrayList<String> clientes = new ArrayList<>();
                                        rs = stmt.executeQuery("SELECT DISTINCT nm_cliente FROM container");
                                        while (rs.next()) {
                                            qtcli++;
                                            clientes.add(rs.getString("nm_cliente"));
                                        }
                                        rs.close();
                                        stmt.close();
                                        con.close();
                                    %>
                                    <h4 class="modal-title" id="exampleModalLabel" style="margin: auto;">Total de Importações e Exportações</h4><hr>
                                    <%for (int a = 0; a < qtcli; a++) {%>
                                    <div class="row">
                                        <h5> Movimentações de <%=clientes.get(a)%>: </h5>
                                        <hr>
                                    </div>
                                    <%}%>
                                    <div class="row">
                                        <div class="col-6">
                                            <h5>Importações:</h5>
                                            <%= impor%>
                                        </div>
                                        <div class="col-6">
                                            <h5>Exportações:</h5>
                                            <%= expor%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="modal fade" id="addCon" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-sm text-center">
                <div class="modal-content">
                    <div class="modal-body">                    
                        <h4 class="modal-title" id="exampleModalLabel" style="margin: auto;">Adicionar Contêiner</h4><hr>
                        <form method="post">                                                     
                            <input type="hidden" value="0" name="idenCon" class="form-control">
                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Nome do Cliente</span>
                                <input type="text" name="nomeCliente" class="form-control"required>
                            </div>

                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Código do Contêiner</span>
                                <input type="text" name="codigo" pattern="[A-Z]{4}[0-9]{7}" placeholder="TEST1234567"
                                       title="Código do Contêiner (4 letras e 7 números. Ex: TEST1234567)" class="form-control"required>
                            </div>

                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Tipo</span>
                                <select name="tipo" required>
                                    <option value="20">20</option>
                                    <option value="40">40</option>
                                </select>
                            </div>

                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Status</span>
                                <select name="status" required>
                                    <option value="Cheio">Cheio</option>
                                    <option value="Vazio">Vazio</option>
                                </select>
                            </div>

                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Categoria</span>
                                <select name="categoria" required>
                                    <option value="Importação">Importação</option>
                                    <option value="Exportação">Exportação</option>
                                </select>
                            </div>

                            <input type="submit" name="addCon" value="Adicionar" class="btn btn-primary" style="margin-right: 20%">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>      
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addMov" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-sm text-center">
                <div class="modal-content">
                    <div class="modal-body">                    
                        <h4 class="modal-title" id="exampleModalLabel" style="margin: auto;">Realizar Movimentação</h4><hr>
                        <form method="post">                                                     
                            <input type="hidden" value="0" name="idenMov" class="form-control">
                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Id do Container</span>
                                <input type="number" min="1" name="idenCon" class="form-control"required>
                            </div>

                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Tipo</span>
                                <select name="movimentacao" required>
                                    <option value="Embarque">Embarque</option>
                                    <option value="Descarga">Descarga</option>
                                    <option value="Gate In">Gate In</option>
                                    <option value="Gate Out">Gate Out</option>
                                    <option value="Reposicionamento">Reposicionamento</option>
                                    <option value="Pesagem">Pesagem</option>
                                    <option value="Scanner">Scanner</option>
                                </select>
                            </div>

                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Data Ini.</span>
                                <input type="text" name="dtIni" pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}"
                                       title="Insira uma data no formato: DD/MM/AAAA" placeholder="DD/MM/AAAA" class="form-control" required>
                            </div>

                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Data Fim</span>
                                <input type="text" name="dtFim" pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}"
                                       title="Insira uma data no formato: DD/MM/AAAA" placeholder="DD/MM/AAAA" class="form-control" required>
                            </div>

                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Hora Ini.</span>
                                <input type="text" name="hrIni" pattern="[0-9]{2}:[0-9]{2}:[0-9]{2}"
                                       title="Insira uma data no formato: HH:MM:SS" placeholder="HH:MM:SS" class="form-control" required>
                            </div>

                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-sm">Hora Fim</span>
                                <input type="text" name="hrFim" pattern="[0-9]{2}:[0-9]{2}:[0-9]{2}"
                                       title="Insira uma data no formato: HH:MM:SS" placeholder="HH:MM:SS" class="form-control" required>
                            </div>

                            <input type="submit" name="addMov" value="Adicionar" class="btn btn-primary" style="margin-right: 20%">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>      
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function setaIdCon(val) {
                document.getElementById('idenCon').value = val;
            }
            function setaIdMov(val) {
                document.getElementById('idenMov').value = val;
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    </body>
</html>
