package videoClub.log;

import com.google.gson.Gson;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Informer{
    public static final String basePath = "/home/emilio/logsVideoClub";
    private File baseDirectory;
    private File logDirectory;
    private String logDirectoryPath;
    private File informer;
    private String informerPath;
    private Writer writer;
    
    private String message;
            
    /* 0: none      3:debug  *
     * 1: error     4: spam  *
     * 2: warning   5: all   */
    private int level = 2;
    public static final int LVL_NONE = 0; // min
    public static final int LVL_ERROR = 1;
    public static final int LVL_WARNING = 2;
    public static final int LVL_DEBUG = 3;
    public static final int LVL_SPAM = 4;
    public static final int LVL_ALL = 5; // max
    
    /* 1: json */
    private int formatter = 1;
    
    private static Informer instance = null;
    
    private Informer() {}
    
    public static Informer get() {
        if (instance == null) {
            instance = new Informer();
        }
        return instance;
    }    
    
    public void log(String logMssg) {
        log(logMssg, level);
    }
    
    public void log(String logMssg, int level) {
        setLevel(level);
        Log l = new Log(logMssg, level);
        setMessage(l);
        try {
            write(message);
        } catch (IOException e) {
            // Whos gonna log this anyway?
        }
    }
    
    
    private void setFormatter(int formatter) {
        this.formatter = formatter;
    }
    
    private void setLevel(int level) {
        this.level = level > Informer.LVL_NONE? // lvl greater than lowest allowed
                    level < Informer.LVL_ALL? // lvl lower than greatest allowed
                        level: // lvl is lvl if lvl>none && lvl<all
                        Informer.LVL_ALL // lvl is all if lvl>none && lvl>=all
                    :
                Informer.LVL_NONE; // lvl is all if lvl<=none
    }
    
    private void setMessage(Log logObj) {
        ILogFormatter frmttr = new JsonLogFormatter();
        switch (formatter) {
            case 1:
                frmttr = new JsonLogFormatter();
                break;
        }
        message = frmttr.fromatLog(logObj);
    }
    
    
    private void prepareBaseDir() {
        baseDirectory = new File(basePath + "/" + dNow().getYear() + dNow().getMonthValue());
        if (!baseDirectory.exists()) baseDirectory.mkdir();
    }
    
    private void prepareLogDir() {
        logDirectoryPath = basePath + "/" + dNow().getYear() + "-" + dNow().getMonthValue();
        logDirectory = new File(logDirectoryPath);
        if (!logDirectory.exists()) logDirectory.mkdir();
    }
    
    private void prepareInformer() throws IOException {
        informerPath = logDirectoryPath + "/" + dNow().getDayOfMonth() + "-" + tNow().getHour() + ".txt";
        informer = new File(informerPath);
        if (!informer.exists()) informer.createNewFile();
    }
    
    private void prepare() throws IOException {
        prepareBaseDir();
        prepareLogDir();
        prepareInformer();
    }
    
    private void write(String mssg) throws IOException {
        prepare();
        writer = writer == null? new FileWriter(informerPath, true): writer;
        writer.write(mssg);
        writer.close();
    }

    
    private LocalDate dNow() {
        return LocalDate.now();
    }
    
    private LocalTime tNow() {
        return LocalTime.now();
    }
    
    
    private interface ILogFormatter {
        public String fromatLog(Log log);
    }
    
    private class JsonLogFormatter implements ILogFormatter {
        @Override
        public String fromatLog(Log log) {
            Gson gson = new Gson();
            return gson.toJson(log);
        }
    }
    
    private class Log{
        public LocalDateTime time = LocalDateTime.now();
        public int level;
        public String message;
        public Log(String message, int level) {
            this.level = level;
            this.message = message;
        }
    }
}