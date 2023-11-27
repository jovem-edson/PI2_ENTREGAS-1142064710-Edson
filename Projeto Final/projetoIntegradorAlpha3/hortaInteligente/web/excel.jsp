<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <meta charset="ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <title>Cadastro Via Excel</title>
    </head>
    <body>
        
        <%
            String sql = "";
            PreparedStatement st;
            try {
                //Conectar ao Banco de Dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/horta", "root", "mitonomice");

                //Ler o arquivo Excel
                FileReader arquivo = new FileReader("C://Users//edson//OneDrive//Documentos//frutas.csv");
                BufferedReader br = new BufferedReader(arquivo);

                //Se o valor de linha do arquivo frutas não for nula
                String linha;
                while ((linha = br.readLine()) != null) {
                    //Pegam os valores da tabela em linhas e separam pela vírgula
                    String[] dados = linha.split(",");
                    //limpa o valor de caracteres ocultos contidos na posição 0
                    
                    String t = dados[0].replaceAll("[^a-zA-Z]", "");
                    String d = dados[1];
                    String s = dados[2];

                    SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
                    Date data_tabela = formato.parse(d);

                    
                        //Prepara o comando insert
                        sql = "INSERT INTO fruta (tipo, data_registro, status_fruta) VALUES(?, ?, ?)";
                        st = conecta.prepareStatement(sql);

                        st.setString(1, t);
                        st.setDate(2, new java.sql.Date(data_tabela.getTime()));
                        st.setString(3, s);
                        st.executeUpdate(); //Executa comando insert
                        out.print("A fruta do tipo: <b>" + t + "</b> foi cadastrada com sucesso<br>");
                    
                }
                br.close();
            } catch (Exception erro) {
                out.print("Entre em contato com o suporte e informe o erro: " + erro.getMessage());
            }
        %>
    </body>
</html>
