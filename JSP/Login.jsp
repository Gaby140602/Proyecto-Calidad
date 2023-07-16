<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="EstiloLogin.css">
<title>Confirmacion_Login</title>
</head>
<body class="mensaje">

<%
    // Crear las variables para las entradas del formulario
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String password = request.getParameter("password");

    // Verificar si los campos están vacíos
    if (nombre == null || apellido == null || password == null) {
        out.println("<h1>Error: Los campos de nombre, apellido y contraseña no pueden estar vacíos.</h1>");
        out.println("<a href='login.html'>Volver al formulario de inicio de sesión</a>");
    } 
    else {
    	Connection dbconnect = null;
        Statement dbstatement = null;
        try {
            // Conexión a la base de datos
            Class.forName("com.mysql.jdbc.Driver");
            dbconnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/semestral", "root", "");
            dbstatement = dbconnect.createStatement();

            // Consulta para verificar datos de inicio de sesión
            String query = "SELECT * FROM login WHERE Nombre=? AND Apellido=? AND Password=?";
            PreparedStatement statement = dbconnect.prepareStatement(query);
            statement.setString(1, nombre);
            statement.setString(2, apellido);
            statement.setString(3, password);
            ResultSet rs = statement.executeQuery();

            // Verificar si se encontró una coincidencia
            if (rs.next()) {
               // Datos válidos, redirigir a la página HOME
                response.sendRedirect("home.html");
            } else {
                // Datos inválidos, mostrar mensaje de error
            	response.sendRedirect("LoginIncorrecto.html");
            }

            // Cerrar conexión a la base de datos
            rs.close();
            statement.close();
            dbconnect.close();
        } catch (Exception e) {
            // Manejo de excepciones
            e.printStackTrace();
            out.println("<h2>Error de conexión a la base de datos.</h2>");
        }
    }
%>

</body>
</html>
