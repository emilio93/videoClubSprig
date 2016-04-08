package videoClub.log;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Permite inicializar el Logger(java.util.logging.Logger) de manera sencilla.
 * @author Emilio Rojas
 * @version 1.0 9/2/2016.
 */
public class Log {
    /**
     * El nivel al cual se realizan los logs.<br>
     * El valor predeterminado es <pre>Level.ALL</pre>.
     */
    private static final Level LEVEL = Level.ALL;

    /**
     * La ruta donde se almacenaran los logs.<br>
     * El valor predeterminado es logs.
     */
    private static final String LOG_PATH = "logs";


    /**
     * Intenta asegurarse que el directorio para los logs exista, sino se logra
     * devuelve false.
     *
     * @return True si existe el directorio, false en caso contrario.
     */
    private static boolean checkDir() {
        File f = new File(LOG_PATH);
        if (!f.exists()) {
            try {
                f.mkdir();
            } catch (SecurityException e) {
                System.err.println(e.getMessage());
            }
        }
        return f.exists();
    }

    /**
     * Inicializa el archivo donde se escribirá el log, y lo agrega al Logger.
     * <br>
     * El archivo será nombrado con el formato yyyy.mm.dd_hh:mm:ss.log.xml
     * <br>
     * Se recomienta utilizar de la siguiente manera:<br>
     * <pre>
     * public class MiClase{
     *     private static final Logger log = Logger.getLogger(MiClase.class.getName());
     *     public static main(String[] args) {
     *         Log.start(log);
     *         // ...
     *         log.warning("mensaje de cuidado");
     *         log.info("mensaje de información");
     *         // ...
     *     }
     *     // ...
     * }
     * </pre>
     *
     * @param log El objeto Logger al cual se le asigna un archivo para guardar
     * el log.
     */
    public static void start(Logger log) {
        // Se obtiene la fecha con el formato deseado.
        SimpleDateFormat d = new SimpleDateFormat("yyyy.MM.dd_HH:mm:ss:SSS");
        String n = d.format(Calendar.getInstance().getTime());

        // Se inicia en null el FileHandler para el Logger.
        FileHandler fh = null;

        // Crea el directorio para los logs.
        // Si no se crea finaliza la ejecución de la función.
        if (!checkDir()) {
            System.err.println("Log directory does not exist and could not be created");
            return;
        }

        // Se intenta crear el FileHandler.
        try {
            fh = new FileHandler(LOG_PATH + "/" + n + ".log.xml");
        } catch (Exception e) {
            // En caso que no se pueda crear se informa mediante 'System.err'.
            System.err.println("Could not create the FileHandler");
            System.err.println("FileHandler won't be added to the Logger");
        }

        // En caso que se haya creado el FileHandler se le asigna al Logger.
        if (fh != null) log.addHandler(fh);
        // Se le asigna el nivel al cual se realizan los logs al Logger.
        log.setLevel(LEVEL);
    }
}
