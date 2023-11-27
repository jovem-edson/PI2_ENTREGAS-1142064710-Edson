<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Listar Animais</title>
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
            //recebe o nome do animal para a consulta
            String tipo;
            tipo = request.getParameter("tipo");
            
            try {
                //conexão com o BD
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/horta", "root", "mitonomice");
                //Listando os dados
                st = conecta.prepareStatement("SELECT * FROM fruta WHERE tipo LIKE ? ORDER BY codigo");
                st.setString(1, "%" + tipo + "%");
                
                //executa o comando select
                ResultSet rs = st.executeQuery();
                %>
                <!--Criando uma tabela para mostrar a listagem-->
                <div id="divTabela" class="table-responsive">
                <table class="table table-bordered table-hover align-middle table-striped">
                    <thead class="text-center align-middle fundo-personalizado text-light">
                        <tr>
                            <th scope="col">Código</th>
                            <th scope="col">Tipo de Fruta</th>
                            <th scope="col">Data de Registro</th>
                            <th scope="col">Status</th>
                            <th scope="col">Remover</th>   
                        </tr>
                    </thead>
                <%
                //laço para verificar se há itens na variável rs
                while (rs.next()) {
                %>
                <tbody class="text-center align-middle">     
                    <tr>
                        <td><%=rs.getString("codigo")%></td>
                        <td><%=rs.getString("tipo")%></td>
                        <td><%=rs.getString("data_registro")%></td>
                        <td><%=rs.getString("status_fruta")%></td>
                        <td><a class="alert-link text-success" href="excHor.jsp?codigo=<%=rs.getString("codigo")%>">Remover</a></td>
                    </tr>
                </tbody>    
            <%
            }
            %>
            </table>
                </div>
            <%
        } catch (Exception x) {
            out.print("<p style='color:#212529;font-size:15px'>Mensagem de erro:" + x.getMessage() + "</p>");
        }


    %>
            </main>
        </body>
</html>
