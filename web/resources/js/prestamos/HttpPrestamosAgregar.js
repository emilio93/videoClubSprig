/* Emilio Rojas 2016. */
HttpPrestamosAgregar = function(url, metodo, args) {

    this.url = url;
    this.metodo = metodo;
    this.args = args;

    /**
     * Esto es lo que hace el solicitante al obtener una respuesta correcta del
     * pedido http.
     * @param  {Object} data La respuesta del pedido http.
     */
    this.ejecutar = function(data) {
        if (data.success == true) {
            swal('¡Éxito!', 'Se añadió el préstamo a la base de datos.', 'success');
            $('#cedula').val('');
            $('#titulo').val('');
        } else {
            swal('Error', 'No se ha añadido el préstamo a la base de datos.', 'error');
        }
    };

    this.error = function() {
        swal('Error', 'No se ha podido comunicar con el servidor.', 'error');
    }

    this.getParams = function() {
        var params = {
            pedido: 'agregar',
            cedula: $('#cedula').val(),
            titulo: $('#titulo').val()
        };
        return params;
    };

    this.validar = function() {
        var check = $('#cedula').val() != '' && $('#titulo').val() != '' && /^\d+$/.test($('#cedula').val());
        return check;
    }

    this.agregar = function() {
        this.args.params = this.getParams();
        var http = new Http(this.url, this.metodo, this.args);
        if (this.validar()) {
            swal({
                title: "Agregando Préstamo",
                text: "<i class='fa fa-spinner fa-spin fa-2x'></i>",
                html: true,
                showConfirmButton: false
            });
            http.enviar(this);
        }
    };
};
