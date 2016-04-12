<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clientes</title>
        
        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="resources/swal/sweetalert.css">
        
        <link rel="stylesheet" href="resources/css/style.css">

        <script src="resources/jquery/jquery.min.js"></script>
        <script src="resources/swal/sweetalert.min.js"></script>
        
        <script src="resources/js/WindowToggle.js"></script>
        <script src="resources/js/Http.js"></script>
        <script src="resources/js/clientes/Clientes.js"></script>
        <script src="resources/js/clientes/HttpClientesActualizar.js"></script>
        <script src="resources/js/clientes/HttpClientesAgregar.js"></script>
        <script src="resources/js/clientes/HttpClientesEliminar.js"></script>
        <script src="resources/js/clientes/HttpClientesListar.js"></script>
    </head>
    <body style="display: none">
        <div class="container">
            <%@include file="shared/header.jsp" %>
            
            <div>
                <h3>
                    <span class='noselect pointer' id='activador-agregar'>
                        <i id='chev-agregar' class='fa fa-chevron-circle-right'></i>
                        Agregar Nuevo Cliente
                    </span>
                </h3>

                <div id='ventana-agregar'>
                    <form id='form-agregar' onsubmit='return false;'>
                        <div class='form-group form-group-sm col-sm-2'>
                            <label for='nombre' class='control-label'>Nombre:</label>
                            <input type='text' class='form-control input-sm' id='nombre' required>
                        </div>
                        <div class='form-group form-group-sm col-sm-2'>
                            <label for='apellido1' class='control-label'>Apellido1:</label>
                            <input type='text' class='form-control input-sm' id='apellido1' required>
                        </div>
                        <div class='form-group form-group-sm col-sm-2'>
                            <label for='apellido2' class='control-label'>Apellido2:</label>
                            <input type='text' class='form-control input-sm' id='apellido2' required>
                        </div>
                        <div class='form-group form-group-sm col-sm-2'>
                            <label for='cedula' class='control-label'>Cédula:</label>
                            <input type='number' class='form-control input-sm' id='cedula' required>
                        </div>
                        <div class='form-group form-group-sm col-sm-2'>
                            <label for='email' class='control-label'>Email:</label>
                            <input type='email' class='form-control input-sm' id='email' required>
                        </div>
                        <div class='form-group form-group-sm col-sm-2'">
                            <label for='telefono' class='control-label'>Teléfono:</label>
                            <input type='number' class='form-control input-sm' id='telefono' required>
                        </div>
                        <hr style='margin: 5px 0 10px 0;'>
                        <div class='form-group form-group-sm'>
                            <label for='direccion' class='col-sm-1 control-label'>Dirección:</label>
                            <textarea class='form-control' id='direccion' required></textarea>
                        </div>
                        <button id='boton-agregar' class='btn btn-primary btn-block'>Agregar</button>
                    </form>
                </div>
            </div>
            
            
            <h3>
                <span class="noselect pointer" id='activador-listar'>
                    <i id='chev-listar' class='fa fa-chevron-circle-right'></i>
                    Lista de Clientes
                </span>
            </h3>
            <div id='ventana-listar'>
                <div class='row'>
                    <div class="col-sm-8">
                        <ul class="nav nav-pills nav-justified">
                            <li role="presentation" id="clientes-listado-todos"><a href="#">Todos</a></li>
                            <li role="presentation" id="clientes-listado-morosos"><a href="#">Morosos</a></li>

                        </ul>
                    </div>
                    <div class="col-sm-4 text-right">
                        <form class="form-inline" id="clientes-listado-buscar" onsubmit="return false;">
                            <div class="form-group">
                                <input class="form-control" id="buscar-cedula" type="number" placeholder="Buscar por Cédula">
                            </div>
                            <button type="submit" class="btn btn-default">Buscar <i class="fa fa-search fa-fw"></i></button></button>
                        </form>
                    </div>
                </div>
                <hr style='margin: 5px 0 5px 0;'>

                <div class='row text-center'>
                    <div class='col-sm-1'><b>Cédula</b></div>
                    <div class='col-sm-1'><b>Nombre</b></div>
                    <div class='col-sm-2'><b>Apellidos</b></div>
                    <div class='col-sm-2'><b>Email</b></div>
                    <div class='col-sm-1'><b>Teléfono</b></div>
                    <div class='col-sm-2'><b>Dirección</b></div>
                    <div class='col-sm-3'><b>Opciones</b></div>
                </div>
                <hr style='margin: 5px 0 5px 0;'>

                <div id="clientes-listado">
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
