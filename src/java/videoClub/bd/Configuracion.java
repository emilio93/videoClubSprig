package videoClub.bd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import videoClub.log.Informer;

/**
 * Se encarga de manejar los datos de configuración para el sistema.
 * Actualmente se permite únicamente la obtención de datos, estando
 * deshabilitada la actualización y eliminación de registros.
 * @author Emilio Rojas.
 */
public class Configuracion extends Consultor{
    
    /**
     * Inicializa el Logger.
     */
    public Configuracion() {
        inf = Informer.get();
    }

    /**
     * Obtiene el valor como un int.
     */
    public int getInt(String nombre) {
        int valor = 0;
        ResultSet rs = null;
        try {
            PreparedStatement stmt = preparar("call getConfiguracion(?)", nombre);
            rs = stmt.executeQuery();
            if (rs.next()) valor = Integer.parseInt(rs.getString("valor"));
        } catch (Exception e) {
            inf.log(appendError("No se logró leer la configuración solicitada. ") + e.getMessage());
            appendError(debug? e.getMessage() + ". ": "");
        }
        return valor;
    }

    /**
     * Obtiene el valor como un String.
     */
    public String getString(String nombre) {
        String valor = null;
        ResultSet rs = null;
        try {
            PreparedStatement stmt = preparar("call getConfiguracion(?)", nombre);
            rs = stmt.executeQuery();
        } catch (Exception e) {
            inf.log(setError("No se logró leer la configuración solicitada: " + e.getMessage()));
            for (StackTraceElement stackTrace : e.getStackTrace()) {
                setError(getError() + stackTrace + "<br>");
            }
        }
        try {
            if (rs.next()) valor = rs.getString("valor");
        } catch (Exception e) {
            inf.log(setError("No se logró leer la configuración solicitada: " + e.getMessage()));
        }
        return valor;
    }

    /**
     * Obtiene la descripción.
     */
    public String getDescripcion(String nombre) {
        String descripcion = null;
        ResultSet rs = null;
        try {
            PreparedStatement stmt = preparar("call getConfiguracion(?)", nombre);
            rs = stmt.executeQuery();
        } catch (Exception e) {
            inf.log(setError("No se logró leer la configuración solicitada: " + e.getMessage()));
        }
        try {
            if (rs.next()) descripcion = rs.getString("descripcion");
        } catch (Exception e) {
            inf.log(setError("No se logró leer la configuración solicitada: " + e.getMessage()));
        }
        return descripcion;
    }

    /**
     * Obtiene el dato solicitado de configuración almacenado en la base de
     * datos.
     */
    private ResultSet getRs(String nombre) {
        ResultSet rs = null;
        try {
            PreparedStatement stmt = preparar("call getConfiguracion(?)", nombre);
            rs = stmt.executeQuery();
        } catch (Exception e) {
            inf.log(setError("No se logró leer la configuración solicitada: " + e.getMessage()));
        }
        return rs;
    }
}
