package videoClub.bd;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
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
    
    public ConfigTemplate getConfig() {
        Properties env = new Properties();
    	InputStream fis = null;
        ConfigTemplate valores = null;
    	try {
            fis = BD.class.getClassLoader().getResourceAsStream("dbconfig.properties");
            if(fis==null){
                error += "Archivo de configuraciones de base de datos no encontrado. ";
                error += debug? "FileNotFound@getConfig(). ": "";
                valores = new ConfigTemplate("jdbc:mysql://", "127.0.0.1", "videoclub", "pass", "3306", "user");
            }
            env.load(fis);
            try {
                valores = new ConfigTemplate(
                    env.getProperty("driver"),
                    env.getProperty("host"),
                    env.getProperty("name"),
                    env.getProperty("pass"),
                    env.getProperty("port"),
                    env.getProperty("user"));
                error += debug? "Configuraciones de base de datos cargadas. ": "";
            } catch (NullPointerException e) {
                error += "Configuraciones de base de datos por defecto cargadas. ";
                error += debug? "NullPointer@getConfig(). ": "";
                valores = new ConfigTemplate("jdbc:mysql://", "127.0.0.1", "videoclub", "pass", "3306", "emilio");
            }
    	} catch (IOException ex) {
            ex.printStackTrace();
        } finally{
            if (fis != null){
                try { fis.close(); } 
                catch (IOException e) { ; }
            }
        }
        return valores;
    }
    
        /**
     * Asigna los parámetros para la conexión con la base de datos.
     */
    private void setConfig() {
        ConfigTemplate valores = getConfig();
        String driver = valores.getDriver();
        String host = valores.getHost();
        String port = valores.getPort();
        String name = valores.getName();
        user = valores.getUser();
        pass = valores.getPass();
        url = driver + host + ":" + port + "/" + name;
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

class ConfigTemplate {
    private String driver, host, name, pass, port, user;
    public ConfigTemplate(String driver, String host, String name, 
            String pass, String port,String user) {
        setDriver(driver);
        setHost(host);
        setName(name);
        setPass(pass);
        setPort(port);
        setUser(port);

    }

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