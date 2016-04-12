/* Emilio Rojas 2016. */
HttpPrestamosListar = function(url, metodo, args) {

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
        this.data.prestamos = this.data.prestamos == null? null: null;
        this.actualizar();
    }

    this.obtener = function() {
        var conjunto = typeof this.args.params.conjunto != 'undefined'? this.args.params.conjunto: "";
        var argsObt = {params:{id: 0, cedula: 0, titulo: ''}};
        if (typeof this.args.params.id != 'undefined' && this.args.params.id != "") {
            argsObt.params.id = this.args.params.id;
        }
        if (typeof this.args.params.cedula != 'undefined' && this.args.params.cedula != "") {
            argsObt.params.cedula = this.args.params.cedula;
        }
        if (typeof this.args.params.titulo != 'undefined' && this.args.params.titulo != "") {
            argsObt.params.titulo = this.args.params.titulo;
        }
        var http = new Http(this.url + "/" + conjunto, this.metodo, argsObt);
        http.enviar(this);
    };

    this.buscarPrestamo = function(id) {
        var prestamo = {};
        for (var i = 0; i < this.data.prestamos.length; i++) {
            if (this.data.prestamos[i].idPrestamo == id) {
                prestamo = this.data.prestamos[i];
                break;
            }
        }
        return prestamo;
    };

    this.actualizar = function() {
        var nuevoTexto = this.construirHtmlList();
        var viejoTexto = $('#prestamos-listado').html();
        var esto = this;
        if (nuevoTexto != viejoTexto) {
            $('#prestamos-listado').html(nuevoTexto);
            esto.handleFinalizar();
        };
    };

    this.handleFinalizar = function() {
        var esto = this;
        $('.boton-finalizar').click( function() {
            var id = $(this).attr('id').replace('boton-finalizar-', '');
            var cedula = $(this).attr('cedula');
            var titulo = $(this).attr('titulo');
            var prestamo = esto.buscarPrestamo(id);
            var httpFinalizar = new HttpPrestamosFinalizar('api/prestamos/finalizar', 'post', {});
            httpFinalizar.finalizar(id, cedula, titulo);
        });
    };

    this.construirHtmlList = function() {
        var html = '';

        if (this.data != null && this.data.prestamos != null) {
            for (var i = 0; i < this.data.prestamos.length; i++) {
                if (this.data.prestamos[i].devuelta == 0)
                    html += this.construirHtmlRow(this.data.prestamos[i]);
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

    this.construirHtmlRow = function(prestamo) {

        var dPrestamo = new Date(prestamo.devolucion.year, prestamo.devolucion.month-1, prestamo.devolucion.day);
        var hoy = new Date();
        var estilo = dPrestamo > hoy? 'primary': 'danger';

        html =  "<div id='row-" + prestamo.idPrestamo + "' class='row text-center'>" +
        "   <div class='col-sm-2'>" + prestamo.cliente.cedula + "</div>" +
        "   <div class='col-sm-2'>" + prestamo.cliente.nombre + " " + prestamo.cliente.apellido1 + " " + prestamo.cliente.apellido2 + "</div>" +
        "   <div class='col-sm-2'>" + prestamo.pelicula.titulo + "</div>" +
        "   <div class='col-sm-1'>" + prestamo.salida.day + "/" + prestamo.salida.month + "/" + prestamo.salida.year + "</div>" +
        "   <div class='col-sm-1'>" + prestamo.devolucion.day + "/" + prestamo.devolucion.month + "/" + prestamo.devolucion.year + "</div>" +
        "   <div class='col-sm-2'>" +
        "        <button class='btn btn-info btn-sm btn-block boton-info disabled' id='boton-info-" + prestamo.idPrestamo + "'>" +
        "            Info <i class='fa fa-info-circle'></i>" +
        "        </button>" +
        "   </div>" +
        "   <div class='col-sm-2'>" +
        "        <button class='btn btn-" + estilo + " btn-sm btn-block boton-finalizar' titulo='" + prestamo.pelicula.titulo + "' cedula='" + prestamo.cliente.cedula + "' id='boton-finalizar-" + prestamo.idPrestamo + "'>" +
        "           Finalizar <i class='fa fa-check'></i>" +
        "        </button>" +
        "    </div>" +
        "</div>" +
        "<hr style='margin: 5px 0 5px 0;'>";



        return html;
    };

    this.construirRow = function(prestamo) {
        var txtFinalizar = prestamo.devuelta == 1? 'Finalizada': 'Finalizar';
        var classFinalizar =
        html = "<div class='col-sm-2'>" + prestamo.cliente.cedula + "</div>" +
        "<div class='col-sm-2'>" + prestamo.cliente.nombre + " " + prestamo.cliente.apellido1 + " " + prestamo.cliente.apellido2 + "</div>" +
        "<div class='col-sm-2'>" + prestamo.pelicula.titulo + "</div>" +
        "<div class='col-sm-1'>" + prestamo.salida.day + "/" + prestamo.salida.month + "/" + prestamo.salida.year + "</div>" +
        "<div class='col-sm-1'>" + prestamo.devolucion.day + "/" + prestamo.devolucion.month + "/" + prestamo.devolucion.year + "</div>" +
        "<div class='col-sm-2'>" +
        "    <button class='btn btn-info btn-sm btn-block boton-info disabled' id='boton-info-" + prestamo.idPrestamo + "'>" +
        "        Info <i class='fa fa-info-circle'></i>" +
        "    </button>" +
        "</div>" +
        "<div class='col-sm-2'>" +
        "    <button class='btn btn-primary btn-sm btn-block boton-finalizar' titulo='" + prestamo.pelicula.titulo + "' cedula='" + prestamo.cliente.cedula + "' id='boton-finalizar-" + prestamo.idPrestamo + "'>" +
        "       Finalizar <i class='fa fa-check'></i>" +
        "    </button>" +
        "</div>";
        return html;
    };

    this.cargando = function() {
        $('#prestamos-listado').html(`<div class='text-center' style='margin-top: 1em;'>
            <i class='fa fa-spinner fa-spin fa-2x'></i>
        </div>
        `);
    };
}
