package videoClub.bd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import videoClub.log.Informer;

/**
 * Un consultor es una entidad encargada de realizar consultas a la base de
 * datos. Idealmente se quiere que estas entidades tengan un cierto rango de
 * consultas que tengan características comunes.
 * @author Emilio Rojas
 */
public abstract class Consultor {
    protected Connection con = null;
    private String error;
    protected Informer inf;

    /**
     * Obtiene el string de error al instante solicitado.
     * @return 
     */
    public String getError() { return error; }

    /**
     * Se crea una conexión con la base de datos si es necesario, y se obtiene
     * esta.
     * @return 
     */
    protected Connection getCon() {
        if (con == null) {
            BD bd;
            bd = new BD(true);
            con = bd.getCon();
        }
        return con;
    }

    /**
     * Asigna y devuelve el string de error.
     * Se devuelve el string asignado.
     * Notese que si se quisiera concatenar con el error anterior, debe hacerse
     * lo siguiente: <tt>setError(getError()+"mi error");</tt>.
     * @param error
     * @return 
     */
    protected String setError(String error) {
        this.error = error;
        return error;
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
        } catch (Exception e) {
            inf.log(setError("No se logró crear la seentencia sql. " + e.getMessage()));
            inf.log(e.getMessage());
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
        } catch (Exception e) {
            inf.log(setError("No se logró cerrar la conexión con la base de datos."));
            inf.log(e.getMessage());
        }
        return r;
    }
}
