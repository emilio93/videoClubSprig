$(document).ready( function() {
    /*  Window Toggle. */
    var toggleAgregar = new WToggle('#activador-agregar', '#ventana-agregar', '#chev-agregar');
    var toggleListar = new WToggle('#activador-listar', '#ventana-listar', '#chev-listar');
    $('#activador-agregar').click( function() { toggleAgregar.cambiar(); });
    $('#activador-listar').click( function() { toggleListar.cambiar(); });

    /* HTTP. */
    var httpAgregar = new HttpPrestamosAgregar('api/prestamos/agregar', 'post', {});
    var httpListar = new HttpPrestamosListar('api/prestamos/mostrar', 'get', {});
    $('#activador-listar').click( function() {
        if (toggleListar.estado) {
            httpListar.obtener();
        }
    });
    $('#form-agregar').submit( function() {
        httpAgregar.agregar();
    });

    $('#prestamos-listado-todos').click( function() {
        httpListar.args.params = {
            'conjunto': 'todos'
        };
        $(this).attr('class', 'active');
        $('#prestamos-listado-moras').attr('class', '');
        httpListar.obtener();
    });
    $('#prestamos-listado-moras').click( function() {
        httpListar.args.params = {
            'conjunto': 'moras'
        };
        $(this).attr('class', 'active');
        $('#prestamos-listado-todos').attr('class', '');
        httpListar.obtener();
    });
    $('#prestamos-listado-buscar-cedula').submit( function() {
        httpListar.args.params = {
            'conjunto': 'cedula',
            'cedula': $('#buscar-cedula').val()
        };
        $('#prestamos-listado-todos').attr('class', '');
        $('#prestamos-listado-moras').attr('class', '');
        httpListar.obtener();
    });
    $('#prestamos-listado-buscar-titulo').submit( function() {
        httpListar.args.params = {
            'conjunto': 'titulo',
            'titulo': $('#buscar-titulo').val()
        };
        $('#prestamos-listado-todos').attr('class', '');
        $('#prestamos-listado-moras').attr('class', '');
        httpListar.obtener();
    });

    /* Mostrar Contenido. */
    $('body').css({'display': ''});
});
