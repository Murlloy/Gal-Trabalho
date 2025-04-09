<%@ page import="java.sql.*" %>
<%

    String cpf = request.getParameter("cpf");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/db_pessoa", "root", "admin");

        PreparedStatement stmt = conn.prepareStatement("DELETE FROM tb_contato_pessoa WHERE cpf = ? ");
        stmt.setString(1, cpf);
        stmt.executeUpdate();

        stmt.close();
        conn.close();

        response.sendRedirect("listar.jsp");
    } catch (Exception e) {
        out.println("Erro ao deletar contato: " + e.getMessage());
    }
%>
