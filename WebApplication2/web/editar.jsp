<%@ page import="java.sql.*" language="java" %>
<%

    String cpf = request.getParameter("cpf");
    String msg = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/db_pessoa", "root", "admin");

            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE tb_contato_pessoa SET primeiro_nome=?, ultimo_nome=?, endereco=?, cidade=?, estado=?, ddd=?, celular=?, email=?, mes_nascimento=? WHERE cpf=?");

            stmt.setString(1, request.getParameter("primeiro_nome"));
            stmt.setString(2, request.getParameter("ultimo_nome"));
            stmt.setString(3, request.getParameter("endereco"));
            stmt.setString(4, request.getParameter("cidade"));
            stmt.setString(5, request.getParameter("estado"));
            stmt.setString(6, request.getParameter("ddd"));
            stmt.setString(7, request.getParameter("celular"));
            stmt.setString(8, request.getParameter("email"));
            stmt.setString(9, request.getParameter("mes_nascimento"));
            stmt.setString(10, cpf);

            int rows = stmt.executeUpdate();
            stmt.close();
            conn.close();

            msg = rows > 0 ? "Contato atualizado com sucesso!" : "Erro ao atualizar.";
        } catch (Exception e) {
            msg = "Erro: " + e.getMessage();
        }
    }

    String primeiro_nome = "", ultimo_nome = "", endereco = "", cidade = "", estado = "", ddd = "", celular = "", email = "", mes_nascimento = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/db_pessoa", "root", "admin");

        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM tb_contato_pessoa WHERE cpf=?");
        stmt.setString(1, cpf);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            primeiro_nome = rs.getString("primeiro_nome");
            ultimo_nome = rs.getString("ultimo_nome");
            endereco = rs.getString("endereco");
            cidade = rs.getString("cidade");
            estado = rs.getString("estado");
            ddd = rs.getString("ddd");
            celular = rs.getString("celular");
            email = rs.getString("email");
            mes_nascimento = rs.getString("mes_nascimento");
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        msg = "Erro ao carregar dados: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Contato</title>
    <link rel="stylesheet" href="cadastro.css"/>
</head>
<body>
<div id="edit-page" class="auth-container">
    <div class="auth-box">
        <h2>Editar Contato</h2>
        <% if (!msg.isEmpty()) { %>
            <p><%= msg %></p>
        <% } %>
        <form id="edit-form" method="post">
            <section class="form-row">
                <div class="form-group half-width">
                    <label for="primeiro_nome">Primeiro Nome</label>
                    <input type="text" id="primeiro_nome" name="primeiro_nome" value="<%= primeiro_nome %>" required>
                </div>
                <div class="form-group half-width">
                    <label for="ultimo_nome">Último Nome</label>
                    <input type="text" id="ultimo_nome" name="ultimo_nome" value="<%= ultimo_nome %>" required>
                </div>
            </section>

            <section class="form-row">
                <div class="form-group half-width">
                    <label for="endereco">Endereço</label>
                    <input type="text" id="endereco" name="endereco" value="<%= endereco %>" required>
                </div>
                <div class="form-group half-width">
                    <label for="cidade">Cidade</label>
                    <input type="text" id="cidade" name="cidade" value="<%= cidade %>" required>
                </div>
            </section>

            <section class="form-row">
                <div class="form-group half-width">
                    <label for="estado">Estado (UF)</label>
                    <input type="text" id="estado" name="estado" maxlength="2" value="<%= estado %>" required>
                </div>
                <div class="form-group half-width">
                    <label for="ddd">DDD</label>
                    <input type="text" id="ddd" name="ddd" maxlength="2" value="<%= ddd %>" required>
                </div>
            </section>

            <section class="form-row">
                <div class="form-group half-width">
                    <label for="celular">Celular</label>
                    <input type="text" id="celular" name="celular" maxlength="9" value="<%= celular %>" required>
                </div>
                <div class="form-group half-width">
                    <label for="email">E-mail</label>
                    <input type="email" id="email" name="email" value="<%= email %>" required>
                </div>
            </section>

            <section class="form-row">
                <div class="form-group half-width">
                    <label for="mes_nascimento">Mês de Nascimento</label>
                    <input type="number" id="mes_nascimento" name="mes_nascimento" min="1" max="12" value="<%= mes_nascimento %>" required>
                </div>
                <div class="form-group half-width">
                    <label for="cpf">CPF</label>
                    <input type="text" id="cpf" name="cpf" value="<%= cpf %>" readonly>
                </div>
            </section>

            <button type="submit" class="btn btn-block">Salvar Alterações</button>
            <a href="listar.jsp" class="btn btn-secondary btn-block">Cancelar</a>
        </form>
    </div>
</div>
</body>
</html>
