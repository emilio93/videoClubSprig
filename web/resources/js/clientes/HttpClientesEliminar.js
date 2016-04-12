/* Emilio Rojas 2016. */
HttpClientesEliminar = function(url, metodo, args) {
    this.url = url;
    this.metodo = metodo;
    this.args = args;
    this.args.params = {};
    this.args.params.pedido = 'eliminar';
    this.data = null;

    this.ejecutar = function(data) {
        if (data.success == true) {
            swal('¡Éxito!', 'Se eliminó el cliente a la base de datos.', 'success');
            $('#activador-listar').click();
            $('#activador-listar').click();
        } else {
            swal('Error', 'No se ha eliminado el cliente en la base de datos.', 'error');
        }
    };

    this.error = function() {
        swal('Error', 'No se ha podido comunicar con el servidor.', 'error');
    }

    this.eliminar = function(id, cedula) {
        this.args.params.id = id;
        var http = new Http(this.url, this.metodo, this.args);
        var esto = this;
        swal({
            title: "Eliminar Cliente",
            text: "Se eliminará el cliente con cédula " + cedula + ".",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Eliminar",
            closeOnConfirm: false },
            function(){
                swal({
                    title: "Eliminando Cliente",
                    text: "<i class='fa fa-spinner fa-spin fa-2x'></i>",
                    html: true,
                    showConfirmButton: false
                });
                http.enviar(esto);
            });
    };
}
