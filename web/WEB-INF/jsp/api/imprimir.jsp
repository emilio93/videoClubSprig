<%@page contentType="application/json" pageEncoding="UTF-8"%><%=new com.google.gson.Gson().toJson(request.getAttribute("data"))%>
