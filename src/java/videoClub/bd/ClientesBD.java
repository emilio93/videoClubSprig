package videoClub.bd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import videoClub.sistema.Cliente;
import videoClub.log.Informer;

public class ClientesBD extends Consultor{
    public ClientesBD() { inf = Informer.get(); }

    public boolean agregar(Cliente cliente) {
        boolean exito = false;
        try {
            PreparedStatement stmt = preparar(
                "call addCliente(?, ?, ?, ?, ?, ?, ?)",
                cliente.getCedula(),
                cliente.getNombre(),
                cliente.getApellido1(),
                cliente.getApellido2(),
                cliente.getTelefono(),
                cliente.getEmail(),
                cliente.getDireccion()
            );
            exito = stmt.executeUpdate() == 1;
            inf.log("Agregando cliente a la base de datos: " +
                Boolean.toString(exito), Informer.LVL_DEBUG);
        } catch (SQLException e) {
            inf.log(appendError("No se agregó el cliente a la base de datos. ") +
                    e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage(): "");
        }
        return exito;
    }

    public Cliente obtenerConId(int id) {
        Cliente cliente = null;
        try {
            PreparedStatement stmt = preparar("call getCliente(?)", id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                cliente = new Cliente(
                    rs.getInt("idCliente"),
                    rs.getInt("cedula"),
                    rs.getString("nombre"),
                    rs.getString("apellido1"),
                    rs.getString("apellido2"),
                    rs.getInt("telefono"),
                    rs.getString("email"),
                    rs.getString("direccion")
                );
            }
        } catch (SQLException e) {
            inf.log(appendError("No se obtuvo el cliente con id " + id +
                    " de la base de datos. "
                ) +
                e.getMessage(), Informer.LVL_ERROR
            );
            appendError(debug? e.getMessage(): "");
        }
        return cliente;
    }

    public ArrayList<Cliente> obtener() { return obtener(0, 0); }

    public Cliente obtener(int cedula) { return obtenerConId(obtenerConCedula(cedula)); }

    public ArrayList<Cliente> obtener(int cantidad, int pagina) {
        ArrayList<Cliente> lc = null;
        try {
            PreparedStatement stmt = preparar("call getClientes(?, ?)", cantidad, pagina);
            lc = rsToListaClientes(stmt.executeQuery());
            appendError(debug? "Clientes obtenidos. ": "");
        } catch (SQLException e) {
            inf.log(appendError("No se leyeron los clientes de la base de datos. ") +
            e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage(): "");
        }
        catch (NullPointerException e) {
            inf.log(appendError("NullPointerException. ") +
            e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage(): "");
        }
        return lc;
    }

    public ArrayList<Cliente> clientesMorosos() {
        ArrayList<Cliente> lc = null;
        try {
            PreparedStatement stmt = getCon().prepareStatement("call getClientesMorosos()");
            lc = rsToListaClientes(stmt.executeQuery());
        } catch (SQLException e) {
            inf.log(appendError("No se logró obtener la lista de los clientes morosos. ") +
            e.getMessage(), Informer.LVL_ERROR);
        }
        return lc;
    }

    public boolean actualizar(Cliente cliente) {
        boolean exito = false;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call updateCliente (?, ?, ?, ?, ?, ?, ?, ?)");
            stmt.setInt(1, cliente.getIdCliente());
            stmt.setInt(2, cliente.getCedula());
            stmt.setString(3, cliente.getNombre());
            stmt.setString(4, cliente.getApellido1());
            stmt.setString(5, cliente.getApellido2());
            stmt.setInt(6, cliente.getTelefono());
            stmt.setString(7, cliente.getEmail());
            stmt.setString(8, cliente.getDireccion());

            exito = stmt.executeUpdate() == 1;
            inf.log("Actualizando cliente en la base de datos: " +
                Boolean.toString(exito), Informer.LVL_DEBUG);
        } catch (SQLException e) {
            inf.log(appendError("No se actualizó el cliente con cedula " +
                cliente.getCedula() + " de la base de datos.") + e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage(): "");
        }
        return exito;
    }

    public boolean eliminar(int id) {
        boolean exito = false;
        try {
            PreparedStatement stmt = getCon().prepareStatement("call deleteCliente(?)");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                exito = rs.getInt("eliminado") >= 1;
            }
            if (!exito) {
                appendError(!exito? "No se eliminó el cliente de la base de datos. ": "");
            }
            inf.log("Eliminando cliente en la base de datos: " + Boolean.toString(exito), Informer.LVL_DEBUG);
        } catch (SQLException e) {
            inf.log(appendError("No se eliminó el cliente con id " + id + " de la base de datos.") +
                e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage(): "");
        }
        return exito;
    }

    public boolean esMoroso(int cedula) {
        boolean moroso = false;
        try {
            PreparedStatement stmt = getCon()
                    .prepareStatement("call esMoroso(?)");
            stmt.setInt(1, obtenerConCedula(cedula));
            moroso = stmt.executeQuery().getInt("moroso") > 0;
        } catch (SQLException e) {
            inf.log(appendError("No se determinó la morosidad del cliente con cédula " + cedula) +
                e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage(): "");
        }
        return moroso;
    }

    public int contarPrestamosCliente(int cedula) {
        int prestamos = 0;
        try {
            PreparedStatement stmt = getCon().prepareStatement("call contarPrestamosCliente(?)");
            stmt.setInt(1, obtenerConCedula(cedula));
            prestamos = stmt.executeQuery().getInt("prestamos");
        } catch (SQLException e) {
            inf.log(appendError("No se logró contar los prestamos del cliente con cedula " + cedula + ". ") +
                e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage(): "");
        }
        return prestamos;
    }

    private int obtenerConCedula(int cedula) {
        int id = 0;
        try {
            PreparedStatement stmt = getCon().prepareStatement("call getIdFromCedula(?)");
            stmt.setInt(1, cedula);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                id = rs.getInt("idCliente");
            }
            if (id <= 0) {
                inf.log(appendError("No se encontró el cliente con cédula " + cedula + ". "), Informer.LVL_ERROR);
            }
        } catch (SQLException e) {
            inf.log(appendError("No se logró crear la lista de clientes. ") +
                e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage(): "");
        }
        return id;
    }

    private ArrayList<Cliente> rsToListaClientes(ResultSet rs) {
        ArrayList<Cliente> lc = null;
        try {
            lc = new ArrayList<>();
            while (rs.next()) {
                lc.add(new Cliente(
                        rs.getInt("idCliente"),
                        rs.getInt("cedula"),
                        rs.getString("nombre"),
                        rs.getString("apellido1"),
                        rs.getString("apellido2"),
                        rs.getInt("telefono"),
                        rs.getString("email"),
                        rs.getString("direccion")
                ));
            }
            appendError(debug? "Se convirtió el ResultSet a una lista de clientes. ": "");
        } catch (SQLException e) {
            inf.log(appendError("No se logró crear la lista de clientes. ") +
                e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage() + ". ": "");
        }
        return lc;
    }
}
