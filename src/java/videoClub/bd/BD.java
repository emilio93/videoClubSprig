package videoClub.bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import videoClub.log.Informer;

/**
 * Maneja la conexión con la base de datos.
 * @author Emilio Rojas
 */
@Configuration
@PropertySource("classpath:dbconfig.properties")
public final class BD {
    private boolean debug = false;
    private Connection con;
    private Properties config; // parámetros para conexión con la base de datos.
    private String url; // url para el jdbc.
    private String user;
    private String pass;
    private String error = "";
    private Informer inf; // logueo para la aplicación.

    @Autowired
    Environment dbconfig;
    class ConfigTemplate {
        private String driver, host, name, pass, port, user;

        public String getDriver() { return driver; }
        public void setDriver(String driver) { this.driver = driver; }

        public String getHost() { return host; }
        public void setHost(String host) { this.host = host; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public String getPass() { return pass; }
        public void setPass(String pass) { this.pass = pass; }

        public String getPort() { return port; }
        public void setPort(String port) { this.port = port; }

        public String getUser() { return user; }
        public void setUser(String user) { this.user = user; }
    }

    @Bean
    public ConfigTemplate getConfig() {
        ConfigTemplate valores = new ConfigTemplate();
        valores.setDriver(dbconfig.getProperty("driver"));
        valores.setHost(dbconfig.getProperty("host"));
        valores.setName(dbconfig.getProperty("name"));
        valores.setPass(dbconfig.getProperty("pass"));
        valores.setPort(dbconfig.getProperty("port"));
        valores.setUser(dbconfig.getProperty("user"));
        return valores;
     }

    /**
    * Inicia un objeto BD con o sin conexión establecida según el parámetro
    * <pre>conectar</pre>.
    * @param conectar True para crear la conexión, false para no crearla.
    */
    public BD(boolean conectar) {
        inf = Informer.get();
        try {
            // Se indica que el driver a utilizar es el de mysql.
            // Requiere el jdbc para mysql en el proyecto.
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            error += debug? "Driver registrado. ": "";
        } catch (SQLException e) {
            inf.log("Driver no registrado. " + e.getMessage(), Informer.LVL_ERROR);
            error += "Driver no registrado. ";
            error += debug? e.getMessage(): "";
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
        // ConfigTemplate valores = getConfig();
        String driver = "jdbc:mysql://"; // valores.getDriver();
        String host = "127.0.0.1"; // valores.getHost();
        String port = "3306"; // valores.getPort();
        String name = "videoclub"; // valores.getName();
        user = "emilio"; // valores.getUser();
        pass = "pass"; // valores.getPass();
        url = driver + host + ":" + port + "/" + name;
    }

    /**
     * Se conecta con la base de datos según los parámetros establecidos.
     * @return La conexión a la base de datos.
     */
    public Connection conectar() {
        setConfig();
        con = null;
        try {
            con = DriverManager.getConnection(url, user, pass);
            inf.log("Conexión con la bse de datos creada.", Informer.LVL_DEBUG);
            error += debug? "Conexión con la base de datos creada. ": "";
        } catch (Exception e) {
            inf.log("Conexión con la base de datos no creada. " + e.getMessage(), Informer.LVL_ERROR);
            error += "Conexión con la base de datos no creada. ";
            error += debug? e.getMessage(): "";
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
