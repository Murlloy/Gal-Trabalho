
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <title>Cadastro de Contato</title>
  <link rel="stylesheet" href="cadastro.css"/>
</head>
<body>
  <div id="register-page" class="auth-container">
    <div class="auth-box">
        <h2>Cadastro de Contato</h2>
        <form id="register-form" action="cadastroContato.jsp" method="post">

            <section class="form-row">
                <div class="form-group half-width">
                    <label for="primeiro_nome">Primeiro Nome</label>
                    <input type="text" id="primeiro_nome" name="primeiro_nome" required>
                </div>
                <div class="form-group half-width">
                    <label for="ultimo_nome">Último Nome</label>
                    <input type="text" id="ultimo_nome" name="ultimo_nome" required>
                </div>
            </section>

            <section class="form-row">
                <div class="form-group half-width">
                    <label for="endereco">Endereço</label>
                    <input type="text" id="endereco" name="endereco" required>
                </div>
                <div class="form-group half-width">
                    <label for="cidade">Cidade</label>
                    <input type="text" id="cidade" name="cidade" required>
                </div>
            </section>

            <section class="form-row">
                <div class="form-group half-width">
                    <label for="estado">Estado (UF)</label>
                    <input type="text" id="estado" name="estado" maxlength="2" required>
                </div>
                <div class="form-group half-width">
                    <label for="ddd">DDD</label>
                    <input type="text" id="ddd" name="ddd" maxlength="2" required>
                </div>
            </section>

            <section class="form-row">
                <div class="form-group half-width">
                    <label for="celular">Celular</label>
                    <input type="text" id="celular" name="celular" maxlength="9" required>
                </div>
                <div class="form-group half-width">
                    <label for="email">E-mail</label>
                    <input type="email" id="email" name="email" required>
                </div>
            </section>

            <section class="form-row">
                <div class="form-group half-width">
                    <label for="mes_nascimento">Mês de Nascimento</label>
                    <input type="number" id="mes_nascimento" name="mes_nascimento" min="1" max="12" required>
                </div>
                <div class="form-group half-width">
                    <label for="cpf">CPF</label>
                    <input type="text" id="cpf" name="cpf" maxlength="14" required>
                </div>
            </section>

            <button type="submit" class="btn btn-block">Cadastrar</button>
        </form>
    </div>
</div>

</body>
</html>
