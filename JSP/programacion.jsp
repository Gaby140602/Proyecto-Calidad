<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Registro_programacion</title>
<link rel="stylesheet" type="text/css" href="CSS/default.css">
</head>
<body>
    <% 
    String Nombre = request.getParameter("participante");
    String Cedula = request.getParameter("cedula");
    String Fecha = request.getParameter("fecha");

     if (Nombre == null || Cedula == null || Fecha == null ||  Nombre.isEmpty() || Cedula.isEmpty() || Fecha.isEmpty()) {
    	out.println("<h1>Error: Los campos de Nombre, Cedula y Fecha no pueden estar vacios.</h1>");
        out.println("<a href='home.html'>Volver a la pagina de inicio</a>");
    }

    Connection dbconnect = null;
    Statement dbstatement = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        dbconnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/semestral","root","");
        dbstatement = dbconnect.createStatement();
        String insertarsql = "INSERT INTO programacion (nombre, cedula, fecha) VALUES ('" + Nombre + "', '" + Cedula + "', '" + Fecha + "')";
        dbstatement.executeUpdate(insertarsql);
        response.sendRedirect("../home.html");
        
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        response.getWriter().print("Error al insertar en la base de datos. Por favor, inténtalo de nuevo.");
    } catch (SQLException e) {
        e.printStackTrace();
        response.getWriter().print("Error al insertar en la base de datos. Por favor, inténtalo de nuevo.");
    } finally {
        // Cerrar la conexión y el statement en el bloque finally
        if (dbstatement != null) {
            try {
                dbstatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (dbconnect != null) {
            try {
                dbconnect.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    %>
</body>
</html>
