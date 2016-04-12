/* Emilio Rojas 2016. */
HttpClientesListar = function(url, metodo, args) {
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
        this.data.clientes = this.data.clientes == null? null: null;
        this.actualizar();
    }

    this.obtener = function() {
        var conjunto = typeof this.args.params.conjunto != 'undefined'? this.args.params.conjunto: "";
        var argsObt = {params:{cedula: 0}};
        if (typeof this.args.params.cedula != 'undefined' && this.args.params.cedula != "") {
            argsObt = {params:{cedula: this.args.params.cedula}};
        }
        var http = new Http(this.url + "/" + conjunto, this.metodo, argsObt);
        http.enviar(this);
    };

    this.buscarCliente = function(id) {
        var cliente = {};
        for (var i = 0; i < this.data.clientes.length; i++) {
            if (this.data.clientes[i].idCliente == id) {
                cliente = this.data.clientes[i];
                break;
            }
        }
        return cliente;
    };

    this.actualizar = function() {
        var nuevoTexto = this.construirHtmlList();
        var viejoTexto = $('#clientes-listado').html();
        var esto = this;
        if (nuevoTexto != viejoTexto) {
            $('#clientes-listado').html(nuevoTexto);
            this.handleEditar();
            this.handleEliminar();
        };
    };

    this.handleEditar = function() {
        var esto = this;
        $('.boton-editar').click( function() {
            var id = $(this).attr('id').replace('boton-editar-', '');
            var cedula = $(this).attr('cedula');
            var cliente = esto.buscarCliente(id);
            $('#row-' + id).html(esto.construirEditRow(cliente));
            esto.handleGuardar();
            esto.handleCancelar();
        });
    };

    this.handleEliminar = function() {
        var esto = this;
        $('.boton-eliminar').click( function() {
            var id = $(this).attr('id').replace('boton-eliminar-', '');
            var cedula = $(this).attr('cedula');
            var cliente = esto.buscarCliente(id);
            var httpEliminar = new HttpClientesEliminar('api/clientes/eliminar', 'post', {});
            httpEliminar.eliminar(id, cedula);
            $('#row-' + id).html(esto.construirRow(cliente));
            esto.actualizar();
        });
    };

    this.handleGuardar = function() {
        var esto = this;
        $('.form-editar').submit( function() {
            console.log("form sent with id: " + $(this).attr('id').replace('form-editar-', ''));
            var id = $(this).attr('id').replace('form-editar-', '');
            var cliente = esto.buscarCliente(id);
            var httpActualizar = new HttpClientesActualizar('api/clientes/actualizar', 'post', {});
            httpActualizar.actualizar(id);
            esto.handleEditar();
        });
    };

    this.handleCancelar = function() {
        var esto = this;
        $('.boton-cancelar').click( function() {
            var id = $(this).attr('id').replace('boton-cancelar-', '');
            var cedula = $(this).attr('cedula');
            var cliente = esto.buscarCliente(id);
            $('#row-' + id).html(esto.construirRow(cliente));
            esto.handleEditar();
            esto.handleEliminar();
        });
    };

    this.construirHtmlList = function() {
        var html = '';

        if (this.data != null && this.data.clientes != null) {
            for (var i = 0; i < this.data.clientes.length; i++) {
                html += this.construirHtmlRow(this.data.clientes[i]);

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

    this.construirHtmlRow = function(cliente) {
        html =  "<div class='row text-center' id='row-" + cliente.idCliente + "'>" +
        "    <div class='col-sm-1'>" + cliente.cedula + "</div>" +
        "    <div class='col-sm-1'>" + cliente.nombre + "</div>" +
        "    <div class='col-sm-1'>" + cliente.apellido1 + "</div>" +
        "    <div class='col-sm-1'>" + cliente.apellido2 + "</div>" +
        "    <div class='col-sm-2'>" + cliente.email + "</div>" +
        "    <div class='col-sm-1'>" + cliente.telefono + "</div>" +
        "    <div class='col-sm-2'>" + cliente.direccion + "</div>" +
        "    <div class='col-sm-1'>" +
        "        <button class='btn btn-info btn-sm btn-block boton-info disabled' cedula='" + cliente.cedula + "' id='boton-info-" + cliente.idCliente + "'>" +
        "            Info <i class='fa fa-info-circle'></i>" +
        "        </button>" +
        "    </div>" +
        "    <div class='col-sm-1'>" +
        "        <button class='btn btn-warning btn-sm btn-block boton-editar' cedula='" + cliente.cedula + "' id='boton-editar-" + cliente.idCliente + "'>" +
        "           Editar <i class='fa fa-edit'></i>" +
        "        </button>" +
        "    </div>" +
        "    <div class='col-sm-1'>" +
        "        <button class='btn btn-danger btn-sm btn-block boton-eliminar' cedula='" + cliente.cedula + "' id='boton-eliminar-" + cliente.idCliente + "'>" +
        "            Quitar <i class='fa fa-trash'></i>" +
        "        </button>" +
        "    </div>" +
        "</div>" +
        "<hr style='margin: 5px 0 5px 0;'>";

        return html;
    };

    this.construirEditRow = function(cliente) {
        var cedula = cliente.cedula;
        var nombre = cliente.nombre;
        var apellido1 = cliente.apellido1;
        var apellido2 = cliente.apellido2;
        var email = cliente.email;
        var telefono = cliente.telefono;
        var direccion = cliente.direccion;
        var idCliente = cliente.idCliente;
        var html = "<form class='form-editar' id='form-editar-" + idCliente + "' onsubmit='return false;'>" +
        "<div class='col-sm-1'>" +
        "   <input id='cedula-" + idCliente + "' class='form-control input-sm' type='number' value='" + cedula + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='nombre-" + idCliente + "' class='form-control input-sm' type='text' value='" + nombre + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='apellido1-" + idCliente + "' class='form-control input-sm' type='text' value='" + apellido1 + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='apellido2-" + idCliente + "' class='form-control input-sm' type='text' value='" + apellido2 + "' required>" +
        "</div>" +
        "<div class='col-sm-2'>" +
        "   <input id='email-" + idCliente + "' class='form-control input-sm' type='email' value='" + email + "' required>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "   <input id='telefono-" + idCliente + "' class='form-control input-sm' type='number' value='" + telefono + "' required>" +
        "</div>" +
        "<div class='col-sm-2'>" +
        "   <input id='direccion-" + idCliente + "' class='form-control input-sm' type='text' value='" + direccion + "' required>" +
        "</div>" +
        "<div class='col-sm-3'>" +
        "   <div class='col-sm-6'>" +
        "        <button class='btn btn-success btn-sm btn-block boton-guardar' id='boton-guardar-" + idCliente + "'>" +
        "            Guardar <i class='fa fa-floppy-o'></i>" +
        "        </button>" +
        "   </div>" +
        "</form>" +
        "   <div class='col-sm-6'>" +
        "        <button class='btn btn-warning btn-sm btn-block boton-cancelar' id='boton-cancelar-" + idCliente + "'>" +
        "           Cancelar <i class='fa fa-times'></i>" +
        "        </button>" +
        "   </div>" +
        "</div>";
        return html;
    };

    this.construirRow = function(cliente) {
        html = "<div class='col-sm-1'>" + cliente.cedula + "</div>" +
        "<div class='col-sm-1'>" + cliente.nombre + "</div>" +
        "<div class='col-sm-1'>" + cliente.apellido1 + "</div>" +
        "<div class='col-sm-1'>" + cliente.apellido2 + "</div>" +
        "<div class='col-sm-2'>" + cliente.email + "</div>" +
        "<div class='col-sm-1'>" + cliente.telefono + "</div>" +
        "<div class='col-sm-2'>" + cliente.direccion + "</div>" +
        "<div class='col-sm-1'>" +
        "    <button class='btn btn-info btn-sm btn-block boton-info disabled' cedula='" + cliente.cedula + "' id='boton-info-" + cliente.idCliente + "'>" +
        "        Info <i class='fa fa-info-circle'></i>" +
        "    </button>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "    <button class='btn btn-warning btn-sm btn-block boton-editar' cedula='" + cliente.cedula + "' id='boton-editar-" + cliente.idCliente + "'>" +
        "       Editar <i class='fa fa-edit'></i>" +
        "    </button>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "    <button class='btn btn-danger btn-sm btn-block boton-eliminar' cedula='" + cliente.cedula + "' id='boton-eliminar-" + cliente.idCliente + "'>" +
        "        Quitar <i class='fa fa-trash'></i>" +
        "    </button>" +
        "</div>";
        return html;
    };

    this.cargando = function() {
        $('#clientes-listado').html(`<div class='text-center' style='margin-top: 1em;'>
            <i class='fa fa-spinner fa-spin fa-2x'></i>
        </div>
        `);
    };
}
