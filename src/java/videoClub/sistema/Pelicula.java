package videoClub.sistema;

/**
 * Representación de una película.
 * @author Emilio Rojas
 */
public class Pelicula {
    
    private int idPelicula;
    private String titulo;
    private String direccion;
    private String produccion;
    private int ano;
    private String genero;
    private int duracion; // En minutos.
    private String sinopsis;
    private int cantidad; // De ejemplares.

    public Pelicula() {}

    public Pelicula(
            int idPelicula, 
            String titulo, 
            String direccion, 
            String produccion, 
            int ano, 
            String genero, 
            int duracion, 
            String sinopsis, 
            int cantidad
    ) {
        this.idPelicula = idPelicula;
        this.titulo = titulo;
        this.direccion = direccion;
        this.produccion = produccion;
        this.ano = ano;
        this.genero = genero;
        this.duracion = duracion;
        this.sinopsis = sinopsis;
        this.cantidad = cantidad;
    }
    
    public Pelicula(
            String titulo, 
            String direccion, 
            String produccion, 
            int ano, 
            String genero, 
            int duracion, 
            String sinopsis, 
            int cantidad
    ) {
        this.titulo = titulo;
        this.direccion = direccion;
        this.produccion = produccion;
        this.ano = ano;
        this.genero = genero;
        this.duracion = duracion;
        this.sinopsis = sinopsis;
        this.cantidad = cantidad;
    }

    public int getIdPelicula() {
        return idPelicula;
    }

    public void setIdPelicula(int idPelicula) {
        this.idPelicula = idPelicula;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String dirección) {
        this.direccion = dirección;
    }

    public String getProduccion() {
        return produccion;
    }

    public void setProduccion(String produccion) {
        this.produccion = produccion;
    }

    public int getAno() {
        return ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    public String getSinopsis() {
        return sinopsis;
    }

    public void setSinopsis(String sinopsis) {
        this.sinopsis = sinopsis;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}

