$(document).ready( function() {
    /* Window Toggle. */
    var toggleAgregar = new WToggle('#activador-agregar', '#ventana-agregar', '#chev-agregar');
    var toggleListar = new WToggle('#activador-listar', '#ventana-listar', '#chev-listar');
    $('#activador-agregar').click( function() { toggleAgregar.cambiar(); });
    $('#activador-listar').click( function() { toggleListar.cambiar(); });

    /* HTTP. */
    var httpAgregar = new HttpPeliculasAgregar('api/peliculas/agregar', 'post', {});
    var httpListar = new HttpPeliculasListar('api/peliculas/mostrar', 'get', {});
    $('#activador-listar').click( function() {
        if (toggleListar.estado) {
            httpListar.obtener();
        }
    });
    $('#form-agregar').submit( function() {
        httpAgregar.agregar();
    });

    $('#peliculas-listado-todas').click( function() {
        httpListar.args.params = {
            'conjunto': 'todas'
        };
        $(this).attr('class', 'active');
        $('#peliculas-listado-moras').attr('class', '');
        httpListar.obtener();
    });
    $('#peliculas-listado-moras').click( function() {
        httpListar.args.params = {
            'conjunto': 'moras'
        };
        $(this).attr('class', 'active');
        $('#peliculas-listado-todas').attr('class', '');
        httpListar.obtener();
    });
    $('#peliculas-listado-buscar').submit( function() {
        httpListar.args.params = {
            'conjunto': 'titulo',
            'titulo': $('#buscar-titulo').val()
        };
        $('#peliculas-listado-todas').attr('class', '');
        $('#peliculas-listado-moras').attr('class', '');
        httpListar.obtener();
    });


    /*
     * Mostrar Contenido.
     */
    $('body').css({'display': ''});
});
