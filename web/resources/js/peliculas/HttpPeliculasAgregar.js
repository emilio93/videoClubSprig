/*
 * Emilio Rojas 2016.
 */
HttpPeliculasAgregar = function(url, metodo, args) {

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
            swal('¡Éxito!', 'Se añadió la película a la base de datos.', 'success');
            $('#titulo').val('');
            $('#direccion').val('');
            $('#produccion').val('');
            $('#ano').val('');
            $('#genero').val('');
            $('#duracion').val('');
            $('#cantidad').val('');
            $('#sinopsis').val('');
        } else {
            swal('Error', 'No se ha añadido la película a la base de datos.', 'error');
        }
    };

    this.error = function() {
        swal('Error', 'No se ha podido comunicar con el servidor.', 'error');
    }

    this.getParams = function() {
        var params = {
            titulo: $('#titulo').val(),
            direccion: $('#direccion').val(),
            produccion: $('#produccion').val(),
            ano: $('#ano').val(),
            genero: $('#genero').val(),
            duracion: $('#duracion').val(),
            cantidad: $('#cantidad').val(),
            sinopsis: $('#sinopsis').val()
        };
        return params;
    };

    this.validar = function() {
        var check = $('#titulo').val() != '' && $('#direccion').val() != '' &&
                    $('#produccion').val() != '' && $('#ano').val() != '' &&
                    $('#genero').val() != '' && $('#duracion').val() != '' &&
                    $('#cantidad').val() != '' && $('#sinopsis').val() != '' &&
                    /^\d+$/.test(ano.value) && /^\d+$/.test(duracion.value) && /^\d+$/.test(cantidad.value);
        return check;
    }

    this.agregar = function() {
        this.args.params = this.getParams();
        var http = new Http(this.url,this.metodo, this.args);
        if (this.validar()) {
            swal({
                title: "Agregando Película",
                text: "<i class='fa fa-spinner fa-spin fa-2x'></i>",
                html: true,
                showConfirmButton: false
            });
            http.enviar(this);
        }
    };
};
