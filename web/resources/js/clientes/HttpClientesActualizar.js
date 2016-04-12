/* Emilio Rojas 2016. */
HttpClientesActualizar = function(url, metodo, args) {
    this.url = url;
    this.metodo = metodo;
    this.args = args;
    this.args.params = {};
    this.args.params.pedido = 'actualizar';
    this.data = null;

    this.ejecutar = function(data) {
        if (data.success == true) {
            swal('¡Éxito!', 'Se actualizó el cliente en la base de datos.', 'success');
            $('#activador-listar').click();
            $('#activador-listar').click();
        } else {
            swal('Error', 'No se ha actualizado el cliente en la base de datos.', 'error');
        }
    };

    this.error = function() {
        swal('Error', 'No se ha podido comunicar con el servidor.', 'error');
    }

    this.getParams = function(id) {
        var params = {
            pedido: 'actualizar',
            id: id,
            cedula: $('#cedula-' + id).val(),
            nombre: $('#nombre-' + id).val(),
            apellido1: $('#apellido1-' + id).val(),
            apellido2: $('#apellido2-' + id).val(),
            email: $('#email-' + id).val(),
            telefono: $('#telefono-' + id).val(),
            direccion: $('#direccion-' + id).val()
        };
        return params;
    };

    this.actualizar = function(id) {
        this.args.params = this.getParams(id);
        var http = new Http(this.url, this.metodo, this.args);
        swal({
            title: "Actualizando Cliente",
            text: "<i class='fa fa-spinner fa-spin fa-2x'></i>",
            html: true,
            showConfirmButton: false
        });
        http.enviar(this);
    };
}
