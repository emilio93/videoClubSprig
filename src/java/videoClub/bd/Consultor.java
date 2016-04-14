package videoClub.bd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import videoClub.log.Informer;

/**
 * Un consultor es una entidad encargada de realizar consultas a la base de
 * datos. Idealmente se quiere que estas entidades tengan un cierto rango de
 * consultas que tengan características comunes.
 * @author Emilio Rojas
 */
public abstract class Consultor {
    protected final boolean debug = false;
    protected Connection con = null;
    private String error = "";
    protected Informer inf;

    /**
     * Asigna y devuelve el string de error.
     * @param error El error a asignar
     * @return El error asignado.
     */
    protected String setError(String error) {
        this.error = error != null? error: "";
        return this.error;
    }

    /**
     * Agrega al string de error y devuelve el string de error.
     * @param error El error a agregar.
     * @return El error asignado.
     */
    protected String appendError(String error) {
        this.error += error != null? error: "";
        return error;
    }

    /**
     * Obtiene el string de error al instante solicitado.
     * @return El error.
     */
    public String getError() { return error; }

    /**
     * Se crea una conexión con la base de datos si es necesario, y se obtiene
     * esta.
     * @return la conexión a la base de datos.
     */
    protected Connection getCon() {
        BD bd;
        bd = new BD();
        con = bd.getCon();
        setError(bd.getError());
        return con;
    }

    /**
     * Crea un PreparedStatement con los valores dados.
     * @param sql
     * @param params
     * @return
     */
    protected PreparedStatement preparar(String sql, Object... params) {
        PreparedStatement stmt = null;
        try {
            stmt = getCon().prepareStatement(sql);
            int i = 0;
            for (Object p : params) {
                i++;
                if (p.getClass() == String.class) stmt.setString(i, p.toString());
                else if (p.getClass() == Short.class) stmt.setShort(i, (Short) p);
                else if (p.getClass() == Integer.class) stmt.setInt(i, (Integer) p);
                else if (p.getClass() == Long.class) stmt.setLong(i, (Long) p);
                else if (p.getClass() == Float.class) stmt.setFloat(i, (Float) p);
                else if (p.getClass() == Double.class) stmt.setDouble(i, (Double) p);
                else if (p.getClass() == Boolean.class) stmt.setBoolean(i, (Boolean) p);
                else stmt.setObject(i, p);
            }
            appendError(debug? "Se creó el PreparedStatement. ": "");
        } catch (SQLException e) {
            inf.log(appendError("No se creó el PreparedStatement. ") + e.getMessage(), Informer.LVL_ERROR);
            appendError(debug? e.getMessage() + ". ": "");
        }
        return stmt;
    }

    /**
     * Cierra la conexión con la base de datos.
     * @return
     */
    protected boolean close() {
        boolean r = false;
        try {
            con.close();
            r = true;
        } catch (SQLException e) {
            inf.log(appendError("No se logró cerrar la conexión con la base de datos.") + e.getMessage(), Informer.LVL_WARNING);
            appendError(debug? e.getMessage(): "");
        }
        return r;
    }
}
