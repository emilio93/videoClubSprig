/* Emilio Rojas 2016. */
HttpClientesAgregar = function(url, metodo, args) {
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
            swal('¡Éxito!', 'Se añadió el cliente a la base de datos.', 'success');
            $('#nombre').val('');
            $('#apellido1').val('');
            $('#apellido2').val('');
            $('#cedula').val('');
            $('#email').val('');
            $('#telefono').val('');
            $('#direccion').val('');
        } else {
            swal('Error', 'No se ha añadido el cliente a la base de datos.', 'error');
        }
    };

    /**
     * Muestra mensaje de error en caso de fallos en comunicación con servidor.
     */
    this.error = function() {
        swal('Error', 'No se ha podido comunicar con el servidor.', 'error');
    }

    /**
     * Asigna los valores del nuevo cliente a agregar.
     * @return {Object} La configuración para que el cliente sea agregado.
     */
    this.getParams = function() {
        var params = {
            pedido: 'agregar',
            nombre: $('#nombre').val(),
            apellido1: $('#apellido1').val(),
            apellido2: $('#apellido2').val(),
            cedula: $('#cedula').val(),
            email: $('#email').val(),
            telefono: $('#telefono').val(),
            direccion: $('#direccion').val()
        };
        return params;
    };

    /**
     * Se asegura que los valores del cliente sean adecuados.
     * @return {boolean} Indica si los valores son adecuados.
     */
    this.validar = function() {
        var check = $('#nombre').val() != '' && $('#apellido1').val() != '' &&
                    $('#apellido2').val() != '' && $('#cedula').val() != '' &&
                    $('#email').val() != '' && $('#telefono').val() != '' &&
                    $('#direccion').val() != '' &&
                    /^\d+$/.test(cedula.value) && /^\d+$/.test(telefono.value);
        return check;
    }

    /**
     * Agrega el cliente a la base de datos.
     */
    this.agregar = function() {
        this.args.params = this.getParams();
        var http = new Http(this.url,this.metodo, this.args);
        if (this.validar()) {
            swal({
                title: "Agregando Cliente",
                text: "<i class='fa fa-spinner fa-spin fa-2x'></i>",
                html: true,
                showConfirmButton: false
            });
            http.enviar(this);
        }
    };
};
