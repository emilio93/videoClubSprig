<%@ page language="java" pageEncoding="UTF-8"%>
<%
String[] uri = request.getRequestURI().split("/");
String pagina = uri[uri.length-1];
String clientes = pagina.equals("clientes.jsp")? "active": "";
String peliculas = pagina.equals("peliculas.jsp")? "active": "";
String prestamos = pagina.equals("prestamos.jsp")? "active": "";
String rCliente = clientes.equals("")? "clientes": "#";
String rPelicula = peliculas.equals("")? "peliculas": "#";
String rPrestamo = prestamos.equals("")? "prestamos": "#";
%>
<header>
    <h1><b>Video Club</b></h1>
</header>
<ul class="nav nav-tabs nav-justified">
  <li role="presentation" class="<%=clientes%>"><a href="<%=rCliente%>">Clientes</a></li>
  <li role="presentation" class="<%=peliculas%>"><a href="<%=rPelicula%>">Películas</a></li>
  <li role="presentation" class="<%=prestamos%>"><a href="<%=rPrestamo%>">Préstamos</a></li>
</ul>
