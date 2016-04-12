<%@page import="java.time.LocalDate"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
    LocalDate date = LocalDate.now();
    String dia = Integer.toString(date.getDayOfMonth());
    String mes = Integer.toString(date.getMonthValue());
    String ano = Integer.toString(date.getYear());
%>
<script>
    $(document).ready(function() {
        var fecha = <%=dia%> + '/' + <%=mes%> + '/' + <%=ano%>;
        $('footer')
        .html('Fecha del sistema: ' + fecha)
        .attr('class','text-center')
        .css({
            'backgroundColor': '#343434',
            'color': '#cecece',
            'padding': '1em',
            'margin-top': '1em'
        });
    });
</script>
<footer>
</footer>
