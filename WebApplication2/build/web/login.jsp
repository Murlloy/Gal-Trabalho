<%@ page import="java.sql.*" %>
<%
    String usuario = request.getParameter("usuario");
    String senha = request.getParameter("senha");

    boolean loginValido = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/db_login", "root", "admin");

        PreparedStatement stmt = conn.prepareStatement(
            "SELECT * FROM tb_login WHERE usuario = ? AND senha = ?");
        stmt.setString(1, usuario);
        stmt.setString(2, senha);

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            loginValido = true;
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("Erro: " + e.getMessage());
    }

    if (loginValido) {
        response.sendRedirect("cadastro.jsp");
    } else {
%>
        <p style="color: red;">Usuário ou senha inválidos!</p>
        <a href="index.html">Voltar</a>
<%
    }
%>
