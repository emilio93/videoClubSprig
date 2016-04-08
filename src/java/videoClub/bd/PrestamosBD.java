package videoClub.bd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import videoClub.log.Informer;
import videoClub.sistema.Cliente;
import videoClub.sistema.Pelicula;
import videoClub.sistema.Prestamo;

/**
 * Se encarga de realizar las consultas pertinentes a los préstamos de
 * películas.
 * @author Emilio Rojas
 */
public class PrestamosBD extends Consultor{

    public PrestamosBD() {
        inf = Informer.get();
    }

    private ArrayList<Prestamo> rsToListaPrestamos(ResultSet rs) {
        ArrayList<Prestamo> lp = null;
        ClientesBD cbd = new ClientesBD();
        PeliculasBD pbd = new PeliculasBD();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        try {
            lp = new ArrayList<>();
            while(rs.next()) {
                Cliente c = cbd.obtenerConId(rs.getInt("idCliente"));
                Pelicula p = pbd.obtener(rs.getInt("idPelicula"));
                lp.add(new Prestamo(
                    rs.getInt("idPrestamo"),
                    c,
                    p,
                    LocalDate.parse(rs.getString("salida"), formatter),
                    LocalDate.parse(rs.getString("devolucion"), formatter),
                    rs.getBoolean("devuelta")
                ));
            }
        } catch (Exception e) {
            inf.log(setError("No se logró crear la lista de prestamos. " + e.getMessage()));
            inf.log(e.getMessage());
        }
        return lp;
    }

    public boolean agregar(Prestamo prestamo) {
        boolean exito = false;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call addPrestamo(?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, prestamo.getCliente().getIdCliente());
            stmt.setInt(2, prestamo.getPelicula().getIdPelicula());
            stmt.setString(3, prestamo.getSalida().toString());
            stmt.setString(4, prestamo.getDevolucion().toString());
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                exito = rs.getInt("agregado") == 1;
            }
            if (!exito) setError( getError() + " No se pudo agregar el préstamo.");
            inf.log("Agregando préstamo a la base de datos: " + Boolean.toString(exito));
            close();
        } catch (Exception e) {
            inf.log(setError("No se logró agregar el préstamo a la base de datos. " + e.getMessage()));
            inf.log(e.getMessage());
        }
        return exito;
    }
    
    public Prestamo getPrestamo(int idPrestamo) {
        Prestamo prestamo = null;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call getPrestamo(?)");
            stmt.setInt(1, idPrestamo);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                prestamo = new Prestamo(
                    rs.getInt("idPrestamo"),
                    rs.getInt("idCliente"),
                    rs.getInt("idPelicula"),
                    rs.getString("salida"), 
                    rs.getString("devolucion"),
                    rs.getInt("devuelta") == 1
                );
            }
            close();
        } catch (Exception e) {
            inf.log(setError("No se logró obtener el préstamo de la base de datos. " + e.getMessage()));
            inf.log(e.getMessage());
        }
        return prestamo;
    }
    
    public ArrayList<Prestamo> obtener() {
        return obtener(0, 0);
    }
    
    public ArrayList<Prestamo> obtener(int pagina, int cantidad) {
        ArrayList<Prestamo> lp = null;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call getPrestamos()");
            lp = rsToListaPrestamos(stmt.executeQuery());
            close();
        } catch (Exception e) {
            inf.log(setError("No se logró obtener los préstamos de la base de datos."));
            inf.log(e.getMessage());
        }
        return lp;
    }

    public ArrayList<Prestamo> getPrestamosCliente(Cliente cliente) {
        return getPrestamosCliente(cliente.getCedula());
    }

    public ArrayList<Prestamo> getPrestamosCliente(int cedula) {
        ArrayList<Prestamo> lp = null;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call getPrestamosCliente(?)");
            stmt.setInt(1, cedula);
            lp = rsToListaPrestamos(stmt.executeQuery());
            close();
        } catch (Exception e) {
            inf.log(setError("No se logró obtener los préstamos de la base de datos. " + e.getMessage()));
            inf.log(e.getMessage());
        }
        return lp;
    }

    public ArrayList<Prestamo> getPrestamosPelicula(String titulo) {
        ArrayList<Prestamo> lp = null;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call getPrestamosPelicula(?)");
            stmt.setString(1, titulo);
            lp = rsToListaPrestamos(stmt.executeQuery());
            close();
        } catch (Exception e) {
            inf.log(setError("No se logró obtener los préstamos de la base de datos. " + e.getMessage()));
            inf.log(e.getMessage());
        }
        return lp;
    }

    public ArrayList<Prestamo> getPrestamosClientePelicula(Cliente cliente, Pelicula pelicula) {
        return getPrestamosClientePelicula(cliente.getIdCliente(), pelicula.getIdPelicula());
    }

    public ArrayList<Prestamo> getPrestamosClientePelicula(int idCliente, int idPelicula) {
        ArrayList<Prestamo> lp = null;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call getPrestamosClientePelicula(?, ?)");
            stmt.setInt(1, idCliente);
            stmt.setInt(2, idPelicula);
            lp = rsToListaPrestamos(stmt.executeQuery());
            close();
        } catch (Exception e) {
            inf.log(setError("No se logró obtener los préstamos de la base de datos."));
            inf.log(e.getMessage());
        }
        return lp;
    }

    public boolean finalizarPrestamo(Prestamo prestamo) {
        return finalizarPrestamo(prestamo.getIdPrestamo());
    }

    public boolean finalizarPrestamo(int idPrestamo) {
        boolean exito = false;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call finalizarPrestamo(?)");
            stmt.setInt(1, idPrestamo);
            exito = stmt.executeUpdate() == 1;
            inf.log("Finalizando préstamo en la base de datos: " + Boolean.toString(exito));
            close();
        } catch (Exception e) {
            inf.log(setError("No se logró finalizar el préstamo en la base de datos."));
            inf.log(e.getMessage());
        }
        return exito;
    }

    public boolean reactivarPrestamo(Prestamo prestamo) {
        return reactivarPrestamo(prestamo.getIdPrestamo());
    }

    public boolean reactivarPrestamo(int idPrestamo) {
        boolean exito = false;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call reactivarPrestamo(?)");
            stmt.setInt(1, idPrestamo);
            exito = stmt.executeUpdate() == 1;
            inf.log("Reactivando préstamo en la base de datos: " + Boolean.toString(exito));
            close();
        } catch (Exception e) {
            inf.log(setError("No se logró reactivar el préstamo en la base de datos."));
            inf.log(e.getMessage());
        }
        return exito;
    }

    public ArrayList<Prestamo> getMoras() {
        ArrayList<Prestamo> lp = null;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call getPrestamosConMora()");
            lp = rsToListaPrestamos(stmt.executeQuery());
            close();
        } catch (Exception e) {
            inf.log(setError("No se logró obtener los préstamos de la base de datos. " + e.getMessage()));
            inf.log(e.getMessage());
        }
        return lp;
    }
}
