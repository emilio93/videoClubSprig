/* Emilio Rojas 2016. */
HttpPrestamosFinalizar = function(url, metodo, args) {
    this.url = url;
    this.metodo = metodo;
    this.args = args;
    this.args.params = {};
    this.data = null;

    this.ejecutar = function(data) {
        if (data.success === true) {
            swal('¡Éxito!', 'Se finalizó el préstamo.', 'success');
            $('#activador-listar').click();
            $('#activador-listar').click();
        } else {
            swal('Error', 'No se ha finalizado el présatamo en la base de datos.', 'error');
        }
    };

    this.error = function() {
        swal('Error', 'No se ha podido comunicar con el servidor.', 'error');
    };

    this.getCobro = function(idPrestamo, cedula, titulo) {
        var args = {'params': {'id': idPrestamo}};
        var httpListar = new Http('api/prestamos/mostrar/cobro', 'get', args);
        var esto = this;
        var solicitante = {
            'ejecutar': function(data) {
                this.cobro = data.cobro;
                console.log(data);
                console.log(this);
            },
            'error': function() {
                this.cobro = 'NaN';
            }
        };
        httpListar.enviar(solicitante);
        console.log(solicitante);
        return solicitante.cobro;
    }

    this.finalizar = function(id, cedula, titulo) {
        this.args.params.id = id;
        var esto = this;
        swal ({
            title: "Calculando Cobro",
            text: "<i class='fa fa-spinner fa-spin fa-2x'></i>",
            html: true,
            showConfirmButton: false
        });
        var args = {'params': {id: id, cedula: 0, titulo: ''}};
        var httpListar = new Http('api/prestamos/mostrar/cobro', 'get', args);
        var esto = this;
        var solicitante = {
            'ejecutar': function(data) {
                console.log('ejecutar');
                swal({
                    title: "Finalizar Préstamo",
                    text: "Se finalizará el préstamo de " + titulo + ", del cliente " + cedula + ". El cobro es de " + data.cobro + " colones.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Finalizar",
                    closeOnConfirm: false
                },
                function() {
                    swal({
                        title: "Finalizando Préstamo",
                        text: "<i class='fa fa-spinner fa-spin fa-2x'></i>",
                        html: true,
                        showConfirmButton: false
                    });
                    var http = new Http(esto.url, esto.metodo, esto.args)
                    http.enviar(esto);
                });
            },
            'error': function() {
                swal('Error', 'No se ha podido calcular el cobro', 'error');
            }
        };
        httpListar.enviar(solicitante);
    };
}
