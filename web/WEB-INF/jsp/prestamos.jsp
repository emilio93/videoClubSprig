<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Préstamos</title>

        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="resources/swal/sweetalert.css">

        <link rel="stylesheet" href="resources/css/style.css">

        <script src="resources/jquery/jquery.min.js"></script>
        <script src="resources/swal/sweetalert.min.js"></script>

        <script src="resources/js/WindowToggle.js"></script>
        <script src="resources/js/Http.js"></script>
        <script src="resources/js/prestamos/Prestamos.js"></script>
        <script src="resources/js/prestamos/HttpPrestamosListar.js"></script>
        <script src="resources/js/prestamos/HttpPrestamosAgregar.js"></script>
        <script src="resources/js/prestamos/HttpPrestamosFinalizar.js"></script>
    </head>
    <body style="display: none">
        <div class="container">
            <%@include file="shared/header.jsp" %>

            <h3>
                <span style='cursor: pointer;' id='activador-agregar'>
                    <i id='chev-agregar' class='fa fa-chevron-circle-right'></i>
                    Agregar Préstamo
                </span>
            </h3>
            <div id='ventana-agregar'>
                <form class='form-horizontal' id='form-agregar' onsubmit='return false;'>
                    <div class='form-group form-group-sm'>
                        <label for='cedula' class='col-sm-2 control-label'>Cédula del Cliente:</label>
                        <div class='col-sm-4'>
                            <input type='number' class='form-control input-sm' id='cedula' required>
                        </div>

                        <label for='cedula' class='col-sm-2 control-label'>Título de la Película:</label>
                        <div class='col-sm-4'>
                            <input type='text' class='form-control input-sm' id='titulo' required>
                        </div>
                    </div>
                    <hr style='margin: 0 0 15px 0;'>
                    <button id='boton-agregar' class='btn btn-primary btn-block'>Agregar</button>
                </form>
            </div>

            <h3>
                <span style='cursor: pointer' id='activador-listar'>
                    <i id='chev-listar' class='fa fa-chevron-circle-right'></i>
                    Lista de Préstamos
                </span>
            </h3>
            <div id='ventana-listar'>
                <div class='row'>
                    <div class="col-sm-6" >
                        <ul class="nav nav-pills nav-justified">
                            <li role="presentation" id="prestamos-listado-todos"><a href="#">Todos</a></li>
                            <li role="presentation" id="prestamos-listado-moras"><a href="#">Moras</a></li>
                        </ul>
                    </div>
                    <div class="col-sm-6">
                        <form class="form-horizontal form-sm" id="prestamos-listado-buscar-titulo" onsubmit="return false;">
                            <div class="form-group">
                                <div class="col-sm-7">
                                    <input class="form-control input-sm" id="buscar-titulo" type="text" placeholder="Buscar por titulo de película">
                                </div>
                                <div class="col-sm-5">
                                    <button type="submit" class="btn btn-default btn-sm">Buscar por Película<i class="fa fa-search fa-fw"></i></button></button>
                                </div>
                            </div>
                        </form>
                        <form class="form-horizontal form-sm" id="prestamos-listado-buscar-cedula" onsubmit="return false;">
                            <div class="form-group">
                                <div class="col-sm-7">
                                    <input class="form-control input-sm" id="buscar-cedula" type="number" placeholder="Buscar por cédula de cliente">
                                </div>
                                <div class="col-sm-5">
                                    <button type="submit" class="btn btn-default btn-sm">Buscar por Cliente<i class="fa fa-search fa-fw"></i></button></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <hr style='margin: 5px 0 5px 0;'>

                <div class='row text-center'>
                    <div class='col-sm-2'><b>Cédula</b></div>
                    <div class='col-sm-2'><b>Cliente</b></div>
                    <div class='col-sm-2'><b>Película</b></div>
                    <div class='col-sm-1'><b>Fecha de Salida</b></div>
                    <div class='col-sm-1'><b>Fecha de Devolución</b></div>
                    <div class='col-sm-4'><b>Opciones</b></div>
                </div>
                <hr style='margin: 5px 0 5px 0;'>
                <div id="prestamos-listado">
                </div>
            </div>

            <%@include file="shared/footer.jsp" %>
        </div>
    </body>
    <script>
    $(document).ready( function() {
        // Mostrar Contenido.
        $('body').css({'display': ''});
    });
    </script>
</html>
