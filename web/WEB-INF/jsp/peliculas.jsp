<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Películas</title>
        
        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="resources/swal/sweetalert.css">
        
        <link rel="stylesheet" href="resources/css/style.css">

        <script src="resources/jquery/jquery.min.js"></script>
        <script src="resources/swal/sweetalert.min.js"></script>
        
        <script src="resources/js/WindowToggle.js"></script>
        <script src="resources/js/Http.js"></script>
        <script src="resources/js/peliculas/Peliculas.js"></script>
        <script src="resources/js/peliculas/HttpPeliculasActualizar.js"></script>
        <script src="resources/js/peliculas/HttpPeliculasAgregar.js"></script>
        <script src="resources/js/peliculas/HttpPeliculasEliminar.js"></script>
        <script src="resources/js/peliculas/HttpPeliculasListar.js"></script>
    </head>
    <body style="display: none">
        <div class="container">
            <%@include file="shared/header.jsp" %>
            
            <div>
                <h3>
                    <span class="pointer noselect" id='activador-agregar'>
                        <i id='chev-agregar' class='fa fa-chevron-circle-right'></i>
                        Agregar Nueva Película
                    </span>
                </h3>

                <div id='ventana-agregar'>
                    <form id='form-agregar' class='form-horizontal' onsubmit='return false;'>
                        <div class='form-group form-group-sm'>
                            <label for='titulo' class='col-sm-1 control-label'>Titulo:</label>
                            <div class='col-sm-3'>
                                <input type='text' class='form-control input-sm' id='titulo'>
                            </div>
                            <label for='direccion' class='col-sm-1 control-label'>Dirección:</label>
                            <div class='col-sm-3'>
                                <input type='text' class='form-control input-sm' id='direccion'>
                            </div>
                            <label for='produccion' class='col-sm-1 control-label'>Producción:</label>
                            <div class='col-sm-3'>
                                <input type='text' class='form-control input-sm' id='produccion'>
                            </div>
                        </div>
                        <hr style='margin: 0 0 15px 0;'>
                        <div class='form-group form-group-sm'>

                            <label for='ano' class='col-sm-1 control-label'>Año:</label>
                            <div class='col-sm-2'>
                                <input type='number' class='form-control input-sm' id='ano'>
                            </div>

                            <label for='genero' class='col-sm-1 control-label'>Género:</label>
                            <div class='col-sm-2'>
                                <input type='text' class='form-control input-sm' id='genero'>
                            </div>

                            <label for='duracion' class='col-sm-1 control-label'>Duración:</label>
                            <div class='col-sm-2'>
                                <input type='number' class='form-control input-sm' id='duracion'>
                            </div>

                            <label for='cantidad' class='col-sm-1 control-label'>Cantidad:</label>
                            <div class='col-sm-2'>
                                <input type='number' class='form-control input-sm' id='cantidad'>
                            </div>
                        </div>
                        <hr style='margin: 0 0 15px 0;'>
                        <div class='form-group form-group-sm'>
                            <label for='direccion' class='col-sm-1 control-label'>Sinopsis:</label>
                            <div class='col-sm-11'>
                                <textarea class='form-control' id='sinopsis'></textarea>
                            </div>
                        </div>
                        <button id='boton-agregar' class='btn btn-primary btn-block'>Agregar</button>
                    </form>
                </div>
            </div>
            
            <h3>
                <span class="pointer noselect" id="activador-listar">
                    <i id='chev-listar' class="fa fa-chevron-circle-right"></i>
                    Lista de Películas
                </span>
            </h3>
            <div id="ventana-listar">
                <div class='row'>
                    <div class="col-sm-8">
                        <ul class="nav nav-pills nav-justified">
                            <li role="presentation" id="peliculas-listado-todas"><a href="#">Todas</a></li>
                            <li role="presentation" id="peliculas-listado-moras"><a href="#">En Mora</a></li>

                        </ul>
                    </div>
                    <div class="col-sm-4 text-right">
                        <form class="form-inline" id="peliculas-listado-buscar" onsubmit="return false;">
                            <div class="form-group">
                                <input class="form-control" id="buscar-titulo" type="text" placeholder="Buscar por Título">
                            </div>
                            <button type="submit" class="btn btn-default">Buscar <i class="fa fa-search fa-fw"></i></button></button>
                        </form>
                    </div>
                </div>
                <hr style='margin: 5px 0 5px 0;'>

                <div >
                    <div class="row text-center">
                        <div class="col-sm-1"><b>Titulo</b></div>
                        <div class="col-sm-1"><b>Dirección</b></div>
                        <div class="col-sm-1"><b>Producción</b></div>
                        <div class="col-sm-1"><b>Año</b></div>
                        <div class="col-sm-1"><b>Género</b></div>
                        <div class="col-sm-1"><b>Duración</b></div>
                        <div class="col-sm-2"><b>Sinopsis</b></div>
                        <div class="col-sm-1"><b>Cantidad</b></div>
                        <div class="col-sm-3"><b>Opciones</b></div>
                    </div>
                    <hr style='margin: 5px 0 5px 0;'>

                    <div id="peliculas-listado">
                    </div>
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
