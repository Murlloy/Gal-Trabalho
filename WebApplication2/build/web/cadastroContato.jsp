<%@ page import="java.sql.*" %>

<%! // Coloque a função dentro de <%! ...
    public boolean validarCPF(String cpfInput) {
        if (cpfInput == null || cpfInput.length() != 11 || cpfInput.matches("(\\d)\\1{10}")) return false;

        try {
            int soma = 0;
            for (int i = 0; i < 9; i++) {
                soma += Character.getNumericValue(cpfInput.charAt(i)) * (10 - i);
            }
            int digito1 = (soma * 10) % 11;
            if (digito1 == 10) digito1 = 0;
            if (digito1 != Character.getNumericValue(cpfInput.charAt(9))) return false;

            soma = 0;
            for (int i = 0; i < 10; i++) {
                soma += Character.getNumericValue(cpfInput.charAt(i)) * (11 - i);
            }
            int digito2 = (soma * 10) % 11;
            if (digito2 == 10) digito2 = 0;
            if (digito2 != Character.getNumericValue(cpfInput.charAt(10))) return false;

            return true;
        } catch (Exception e) {
            return false;
        }
    }
%>

<%
    String cpf = request.getParameter("cpf").replaceAll("\\D", "");
    String ddd = request.getParameter("ddd");

    boolean dddValido = false;
    boolean cpfValido = validarCPF(cpf); // Agora funciona

    if (!cpfValido) {
        out.println("<p style='color:red;'>CPF inválido! Verifique os dígitos.</p>");
        out.println("<a href='cadastro.jsp'>Voltar</a>");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/db_pessoa", "root", "admin");

        // Verificar DDD
        PreparedStatement checkDdd = conn.prepareStatement(
            "SELECT * FROM tb_ddd_pessoa WHERE ddd = ?");
        checkDdd.setString(1, ddd);
        ResultSet rs = checkDdd.executeQuery();
        if (rs.next()) {
            dddValido = true;
        }
        rs.close();
        checkDdd.close();

        if (!dddValido) {
            out.println("<p style='color:red;'>DDD inválido!</p>");
            out.println("<a href='cadastro.jsp'>Voltar</a>");
            return;
        }

        String usuarioLogin = (String) session.getAttribute("usuarioLogado");

        // Inserir contato
        PreparedStatement stmt = conn.prepareStatement(
            "INSERT INTO tb_contato_pessoa (primeiro_nome, ultimo_nome, endereco, cidade, estado, ddd, celular, email, mes_nascimento, cpf, usuario_login) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        stmt.setString(1, request.getParameter("primeiro_nome"));
        stmt.setString(2, request.getParameter("ultimo_nome"));
        stmt.setString(3, request.getParameter("endereco"));
        stmt.setString(4, request.getParameter("cidade"));
        stmt.setString(5, request.getParameter("estado"));
        stmt.setString(6, ddd);
        stmt.setString(7, request.getParameter("celular"));
        stmt.setString(8, request.getParameter("email"));
        stmt.setInt(9, Integer.parseInt(request.getParameter("mes_nascimento")));
        stmt.setString(10, cpf);
        stmt.setString(11, usuarioLogin); 

        stmt.executeUpdate();
        stmt.close();
        conn.close();

        response.sendRedirect("menu.jsp");

    } catch (Exception e) {
        out.println("Erro ao cadastrar: " + e.getMessage());
    }
%>
