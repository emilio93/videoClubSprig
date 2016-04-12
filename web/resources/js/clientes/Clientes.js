$(document).ready( function() {
    /* Window Toggle. */
    var toggleAgregar = new WToggle('#activador-agregar', '#ventana-agregar', '#chev-agregar');
    var toggleListar = new WToggle('#activador-listar', '#ventana-listar', '#chev-listar');
    $('#activador-agregar').click( function() { toggleAgregar.cambiar(); });
    $('#activador-listar').click( function() { toggleListar.cambiar(); });

    /* HTTP. */
    var httpAgregar = new HttpClientesAgregar('api/clientes/agregar', 'post', {});
    var httpListar = new HttpClientesListar('api/clientes/mostrar', 'get', {});

    $('#form-agregar').submit( function() {
        httpAgregar.agregar();
    });

    $('#activador-listar').click( function() {
        if (toggleListar.estado) httpListar.obtener();
    });

    $('#clientes-listado-todos').click( function() {
        httpListar.args.params = {
            'conjunto': 'todos'
        };
        $(this).attr('class', 'active');
        $('#clientes-listado-morosos').attr('class', '');
        httpListar.obtener();
    });

    $('#clientes-listado-morosos').click( function() {
        httpListar.args.params = {
            'conjunto': 'morosos'
        };
        $(this).attr('class', 'active');
        $('#clientes-listado-todos').attr('class', '');
        httpListar.obtener();
    });

    $('#clientes-listado-buscar').submit( function() {
        httpListar.args.params = {
            'conjunto': 'cedula',
            'cedula': $('#buscar-cedula').val()
        };
        $('#clientes-listado-todos').attr('class', '');
        $('#clientes-listado-morosos').attr('class', '');
        httpListar.obtener();
    });

    /* Mostrar Contenido. */
    $('body').css({'display': ''});
});
