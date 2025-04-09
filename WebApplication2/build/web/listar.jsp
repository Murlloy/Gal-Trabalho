<%@ page import="java.sql.*" %>
<%
    String ordenarPor = request.getParameter("ordenarPor");
    String ordemSql = "primeiro_nome"; // padrão

    if ("estado".equals(ordenarPor)) {
        ordemSql = "estado";
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Contatos</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body class="container">

    <div class="header">
        <h1>Lista de Contatos</h1>
        <a href="menu.jsp" class="action-btn logout-btn">Voltar ao Menu</a>
    </div>

    <div class="contacts-header">
        <form method="get" action="listar.jsp" style="display: flex; gap: 10px; align-items: center;">
            <label for="ordenarPor">Ordenar por:</label>
            <select name="ordenarPor" id="ordenarPor" style="padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
                <option value="nome" <%= "nome".equals(ordenarPor) ? "selected" : "" %>>Nome</option>
                <option value="estado" <%= "estado".equals(ordenarPor) ? "selected" : "" %>>Estado</option>
            </select>
            <button type="submit" class="action-btn edit-btn">Ordenar</button>
        </form>
    </div>

    <table class="contacts-table">
        <thead>
            <tr>
                <th>Nome</th>
                <th>Endereço</th>
                <th>Cidade</th>
                <th>Estado</th>
                <th>Celular</th>
                <th>Email</th>
                <th>CPF</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_pessoa", "root", "admin");

                    String sql = "SELECT * FROM tb_contato_pessoa ORDER BY " + ordemSql + " ASC";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        String cpf = rs.getString("cpf");
            %>
            <tr>
                <td><%= rs.getString("primeiro_nome") %> <%= rs.getString("ultimo_nome") %></td>
                <td><%= rs.getString("endereco") %></td>
                <td><%= rs.getString("cidade") %></td>
                <td><%= rs.getString("estado") %></td>
                <td>(<%= rs.getString("ddd") %>) <%= rs.getString("celular") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= cpf %></td>
                <td>
                    <form action="editar.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="cpf" value="<%= cpf %>">
                        <button type="submit" class="action-btn edit-btn">Editar</button>
                    </form>
                    <form action="deletar.jsp" method="post" style="display:inline;" onsubmit="return confirm('Tem certeza que deseja deletar?');">
                        <input type="hidden" name="cpf" value="<%= cpf %>">
                        <button type="submit" class="action-btn delete-btn">Deletar</button>
                    </form>
                </td>
            </tr>
            <%
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='8'>Erro ao listar contatos: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>
</body>
</html>
