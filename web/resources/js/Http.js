/* Emilio Rojas 2016. */
var Http = function(url, metodo, args) {
    this.url = url;

    this.metodo = metodo.toUpperCase(); // get, post, put, delete

    /* {expectedStatus int, params Array: {name String, value String} }
     * params requiere 'pedido' que indica el pedido que se hace. */
    this.args = args;

    /* Tiene almenos
     * {'success': boolean requerido, 'error': string requerido} */
    this.data = null;

    this.enviar = function(solicitante) {
        if (typeof solicitante.cargando == 'function') solicitante.cargando();
        $.ajax({
            type: this.metodo,
            url: this.url,
            data: this.args.params
        }).done(function(data) {
            this.data = data;
            if (typeof solicitante.ejecutar == 'function') solicitante.ejecutar(this.data);
        }).fail(function() {
            if (typeof solicitante.error == 'function') solicitante.error();
        });
    };
};
