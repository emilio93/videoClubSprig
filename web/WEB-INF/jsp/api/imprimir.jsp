<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%Gson gson = new Gson();%><%=gson.toJson(request.getAttribute("data"))%>
