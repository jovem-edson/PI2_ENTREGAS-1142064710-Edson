<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remover Fruta</title>
        <link href="css/style.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
    integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
    crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"
    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="js/script.js"></script>
    </head>
    <body>
        <main class="container flex-column align-content-center justify-content-center">
            <%
                //recebe o numero do registro a ser excluido
                int cod;
                cod = Integer.parseInt(request.getParameter("codigo"));

                try {
                    //conexão com o BD
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/horta", "root", "mitonomice");
                    //Excluindo os dados
                    PreparedStatement st = conecta.prepareStatement("DELETE FROM fruta WHERE codigo=?");
                    st.setInt(1, cod);

                    //executa o comando DELETE
                    int resultado = st.executeUpdate();

                    //verifica se o animal foi removido
                    if (resultado == 0) {
                        out.print("<p style='color:#212529;font-size:15px'>Fruta não encontrada</p>");
                    } else {
                        out.print("<p style='color:#212529;font-size:15px'>A fruta com o código: " + cod + " foi removida com sucesso</p>");
                    }

                } catch (Exception erro) {
                    out.print("<p style='color:#212529;font-size:15px'>O seguinte erro foi apresentado:" + erro.getMessage() + " Entre em contato com o suporte</p>");
                }


            %>    
        </main>
    </body>
</html>