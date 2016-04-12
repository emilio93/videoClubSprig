/* Emilio Rojas 2016. */
HttpPeliculasEliminar = function(url, metodo, args) {
    this.url = url;
    this.metodo = metodo;
    this.args = args;
    this.args.params = {};
    this.args.params.pedido = 'eliminar';
    this.data = null;

    this.ejecutar = function(data) {
        if (data.success == true) {
            swal('¡Éxito!', 'Se eliminó la película a la base de datos.', 'success');
            $('#activador-listar').click();
            $('#activador-listar').click();
        } else {
            swal('Error', 'No se ha eliminado la película de la base de datos.', 'error');
        }
    };

    this.error = function() {
        swal('Error', 'No se ha podido comunicar con el servidor.', 'error');
    }

    this.eliminar = function(id, titulo) {
        this.args.params.id = id;
        var http = new Http(this.url, this.metodo, this.args);
        var esto = this;
        swal({
            title: "Eliminar Película",
            text: "Se eliminará la película " + titulo + ".",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Eliminar",
            closeOnConfirm: false },
            function(){
                swal({
                    title: "Eliminando Película",
                    text: "<i class='fa fa-spinner fa-spin fa-2x'></i>",
                    html: true,
                    showConfirmButton: false
                });
                http.enviar(esto);
            });
    };
}
