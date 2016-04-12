/* Emilio Rojas 2016. */
HttpPeliculasListar = function(url, metodo, args) {

    this.url = url;
    this.metodo = metodo;

    this.args = args;
    this.args.params = {};

    this.data = null;

    /**
     * Esto es lo que hace el solicitante al obtener una respuesta correcta del
     * pedido http.
     * @param  {Object} data La respuesta del pedido http.
     */
    this.ejecutar = function(data) {
        this.data = data;
        if (this.data.success == true) {
            this.actualizar();
        } else {
            this.error();
        }
    };

    this.error = function() {
        this.data = this.data == null? {}: this.data;
        this.data.peliculas = this.data.peliculas == null? null: null;
        this.actualizar();
    }

    this.obtener = function() {
        var conjunto = typeof this.args.params.conjunto != 'undefined'? this.args.params.conjunto: "";
        var argsObt = {params:{titulo: ''}};
        if (typeof this.args.params.titulo != 'undefined' && this.args.params.titulo != "") {
            argsObt = {params:{titulo: this.args.params.titulo}};
        }
        var http = new Http(this.url + "/" + conjunto, this.metodo, argsObt);
        http.enviar(this);
    };

    this.buscarPelicula = function(id) {
        var pelicula = {};
        for (var i = 0; i < this.data.peliculas.length; i++) {
            if (this.data.peliculas[i].idPelicula == id) {
                pelicula = this.data.peliculas[i];
                break;
            }
        }
        return pelicula;
    };

    this.actualizar = function() {
        var nuevoTexto = this.construirHtmlList();
        var viejoTexto = $('#peliculas-listado').html();
        var esto = this;
        if (nuevoTexto != viejoTexto) {
            $('#peliculas-listado').html(nuevoTexto);
            esto.handleEliminar();
            esto.handleEditar();
        };
    };

    this.handleEliminar = function() {
        var esto = this;
        $('.boton-eliminar').click( function() {
            var id = $(this).attr('id').replace('boton-eliminar-', '');
            var titulo = $(this).attr('titulo');
            var httpEliminar = new HttpPeliculasEliminar('api/peliculas/eliminar', 'post', {});
            httpEliminar.eliminar(id, titulo);
            esto.actualizar();
        });
    };

    this.handleEditar = function() {
        var esto = this;
        $('.boton-editar').click( function() {
            var id = $(this).attr('id').replace('boton-editar-', '');
            var titulo = $(this).attr('titulo');
            var pelicula = esto.buscarPelicula(id);
            $('#row-' + id).html(esto.construirEditRow(pelicula));
            esto.handleGuardar();
            esto.handleCancelar();
        });
    };

    this.handleGuardar = function() {
        var esto = this;
        $('.form-editar').submit( function() {
            var id = $(this).attr('id').replace('form-editar-', '');
            var pelicula = esto.buscarPelicula(id);
            var httpActualizar = new HttpPeliculasActualizar('api/peliculas/actualizar', 'post', {});
            httpActualizar.actualizar(id);
        });
    };

    this.handleCancelar = function() {
        var esto = this;
        $('.boton-cancelar').click( function() {
            var id = $(this).attr('id').replace('boton-cancelar-', '');
            var titulo = $(this).attr('titulo');
            var pelicula = esto.buscarPelicula(id);
            $('#row-' + id).html(esto.construirRow(pelicula));
            esto.handleEliminar();
            esto.handleEditar();
        });
    };

    this.construirHtmlList = function() {
        var html = '';

        if (this.data != null && this.data.peliculas != null) {
            for (var i = 0; i < this.data.peliculas.length; i++) {
                html += this.construirHtmlRow(this.data.peliculas[i]);
            }
        }
        html = html != ''?
               html:
               `<div class='row text-center' style='margin-top: 1em;'>
                    <div class='col-sm-12'>
                        <p>
                            No se han obtenido registros.
                            Puede deberse a un problema técnico o
                            bien no existen registros.
                        </p>
                    </div>
                </div>
                `;
        return html;
    };

    this.construirHtmlRow = function(pelicula) {
        html =  "<div id='row-" + pelicula.idPelicula + "' class='row text-center'>" +
        "    <div class='col-sm-1'>" + pelicula.titulo + "</div>" +
        "    <div class='col-sm-1'>" + pelicula.direccion + "</div>" +
        "    <div class='col-sm-1'>" + pelicula.produccion + "</div>" +
        "    <div class='col-sm-1'>" + pelicula.ano + "</div>" +
        "    <div class='col-sm-1'>" + pelicula.genero + "</div>" +
        "    <div class='col-sm-1'>" + pelicula.duracion + "</div>" +
        "    <div class='col-sm-2'>" + pelicula.sinopsis + "</div>" +
        "    <div class='col-sm-1'>" + pelicula.cantidad + "</div>" +
        "    <div class='col-sm-1'>" +
        "        <button class='btn btn-info btn-sm btn-block boton-info disabled' id='boton-info-" + pelicula.idPelicula + "'>" +
        "            Info <i class='fa fa-info-circle'></i>" +
        "        </button>" +
        "    </div>" +
        "    <div class='col-sm-1'>" +
        "        <button class='btn btn-warning btn-sm btn-block boton-editar' id='boton-editar-" + pelicula.idPelicula + "'>" +
        "           Editar <i class='fa fa-edit'></i>" +
        "        </button>" +
        "    </div>" +
        "    <div class='col-sm-1'>" +
        "        <button class='btn btn-danger btn-sm btn-block boton-eliminar' titulo='" + pelicula.titulo + "' id='boton-eliminar-" + pelicula.idPelicula + "'>" +
        "            Quitar <i class='fa fa-trash'></i>" +
        "        </button>" +
        "    </div>" +
        "</div>" +
        "<hr style='margin: 5px 0 5px 0;'>";

        return html;
    };

    this.construirEditRow = function(pelicula) {
        var html = "<form class='form-editar' id='form-editar-" + pelicula.idPelicula + "' onsubmit='return false;'>" +
        "<div class='col-sm-1'>" +
        "   <input id='titulo-" + pelicula.idPelicula + "' class='form-control input-sm' type='text' value='" + pelicula.titulo + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='direccion-" + pelicula.idPelicula + "' class='form-control input-sm' type='text' value='" + pelicula.direccion + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='produccion-" + pelicula.idPelicula + "' class='form-control input-sm' type='text' value='" + pelicula.produccion + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='ano-" + pelicula.idPelicula + "' class='form-control input-sm' type='number' value='" + pelicula.ano + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='genero-" + pelicula.idPelicula + "' class='form-control input-sm' type='text' value='" + pelicula.genero + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='duracion-" + pelicula.idPelicula + "' class='form-control input-sm' type='number' value='" + pelicula.duracion + "' required>" +
        "</div>" +
        "<div class='col-sm-2'>" +
        "   <input id='sinopsis-" + pelicula.idPelicula + "' class='form-control input-sm' type='text' value='" + pelicula.sinopsis + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='cantidad-" + pelicula.idPelicula + "' class='form-control input-sm' type='number' value='" + pelicula.cantidad + "' required>" +
        "</div>" +
        "<div class='col-sm-3'>" +
        "   <div class='col-sm-6'>" +
        "        <button class='btn btn-success btn-sm btn-block boton-guardar' id='boton-guardar-" + pelicula.idPelicula + "'>" +
        "            Guardar <i class='fa fa-floppy-o'></i>" +
        "        </button>" +
        "   </div>" +
        "</form>" +
        "   <div class='col-sm-6'>" +
        "        <button class='btn btn-warning btn-sm btn-block boton-cancelar' id='boton-cancelar-" + pelicula.idPelicula + "'>" +
        "           Cancelar <i class='fa fa-times'></i>" +
        "        </button>" +
        "   </div>" +
        "</div>";
        return html;
    };

    this.construirRow = function(pelicula) {
        html = "<div class='col-sm-1'>" + pelicula.titulo + "</div>" +
        "<div class='col-sm-1'>" + pelicula.direccion + "</div>" +
        "<div class='col-sm-1'>" + pelicula.produccion + "</div>" +
        "<div class='col-sm-1'>" + pelicula.ano + "</div>" +
        "<div class='col-sm-1'>" + pelicula.genero + "</div>" +
        "<div class='col-sm-1'>" + pelicula.duracion + "</div>" +
        "<div class='col-sm-2'>" + pelicula.sinopsis + "</div>" +
        "<div class='col-sm-1'>" + pelicula.cantidad + "</div>" +
        "<div class='col-sm-1'>" +
        "    <button class='btn btn-info btn-sm btn-block boton-info disabled' titulo='" + pelicula.titulo + "' id='boton-info-" + pelicula.idPelicula + "'>" +
        "        Info <i class='fa fa-info-circle'></i>" +
        "    </button>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "    <button class='btn btn-warning btn-sm btn-block boton-editar' titulo='" + pelicula.titulo + "' id='boton-editar-" + pelicula.idPelicula + "'>" +
        "       Editar <i class='fa fa-edit'></i>" +
        "    </button>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "    <button class='btn btn-danger btn-sm btn-block boton-eliminar' titulo='" + pelicula.titulo + "' id='boton-eliminar-" + pelicula.idPelicula + "'>" +
        "        Quitar <i class='fa fa-trash'></i>" +
        "    </button>" +
        "</div>";
        return html;
    };

    this.cargando = function() {
        $('#peliculas-listado').html(`<div class='text-center' style='margin-top: 1em;'>
            <i class='fa fa-spinner fa-spin fa-2x'></i>
        </div>
        `);
    };
}
