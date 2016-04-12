package videoClub.bd;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.util.Properties;

import videoClub.log.Informer;

/**getMySQLDataSource
 * Maneja la conexión con la base de datos.
 * @author Emilio Rojas
 */
public final class BD {
    private Connection con;
    private Properties config;
    private String url;
    private String user;
    private String pass;
    private String error;
    
    private Informer inf;
    /**
    * Inicia un objeto BD con o sin conexión establecida según el parámetro
    * <pre>conectar</pre>.
    * @param conectar True para crear la conexión, false para no crearla.
    */
    public BD(boolean conectar) {
        inf = Informer.get();
        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
        } catch (SQLException e) {
            inf.log("No se logró registrar el driver.", Informer.LVL_WARNING);
            inf.log(e.getMessage(), Informer.LVL_ERROR);
            error = "Driver no registrado: " + e.getMessage();
        }
        if (conectar) conectar();
    }

    /**
     * Inicia un objeto BD sin una conexión establecida.
     */
    public BD() { this(false); }

    /**
     * Obtiene el url para la conexión con la base de datos.
     */
    public String getUrl() { return url; }

    /**
     * Obtiene el string de error al instante solicitado.
     */
    public String getError() { return error; }

    /**
     * Asigna los parámetros para la conexión con la base de datos.
     */
    private void setConfig() {
        /*
        Idealmente los parámetros se obtienen de un archivo editable, esto
        no está funcionando. QUeda previsto utilizarse de esta manera.
        */
        /*
        Properties conf = new Properties();
        try (InputStream p = this.getClass().getClassLoader().getResourceAsStream("db.properties")) {
            conf.load(p);
        } catch (Exception e) {
            error = e.getMessage();
            log.warning("No se logró obtener la configuración de la base de datos.");
            log.info(e.getMessage());
        }
        */

        String driver = "jdbc:mysql://"; // conf.getProperty("db.driver");
        String host = "127.0.0.1"; // conf.getProperty("db.host");
        String port = "3306"; // conf.getProperty("db.port");
        String name = "videoclub"; // conf.getProperty("db.name");
        user = "emilio"; // conf.getProperty("db.user");
        pass = "pass"; // conf.getProperty("db.pass");
        url = driver + host + ":" + port + "/" + name;
    }

    /**
     * Se conecta con la base de datos según los parámetros establecidos.
     * @return La conexión a la base de datos.
     */
    public Connection conectar() {
        setConfig();
        try {
            con = DriverManager.getConnection(url, user, pass);
            inf.log("Conexión con la bse de datos creada.", Informer.LVL_DEBUG);
        } catch (Exception e) {
            inf.log("No se logró conectar a la base de datos.", Informer.LVL_WARNING);
            inf.log(e.getMessage(), Informer.LVL_ERROR);
            error = "Conexión no creada" + e.getMessage();
        }
        return con;
    }

    /**
     * Devuelve el objeto Connection con la conexión a la base de datos. De ser
     * necesario se hace la conexión.
     * @return La conexión a la base de datos.
     */
    public Connection getCon() {
        conectar();
        return con;
    }
}
