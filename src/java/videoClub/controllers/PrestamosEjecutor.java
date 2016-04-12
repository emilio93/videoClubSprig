package videoClub.controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import java.util.ArrayList;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import videoClub.bd.ClientesBD;
import videoClub.bd.PeliculasBD;
import videoClub.bd.PrestamosBD;
import videoClub.sistema.Cliente;
import videoClub.sistema.Pelicula;
import videoClub.sistema.Prestamo;

@Controller
@RequestMapping("/api/prestamos")
public class PrestamosEjecutor {
    private PrestamosBD pbd;
    private boolean exito;
    private Gson gson;


    public PrestamosEjecutor() {
        pbd = new PrestamosBD();
        gson = new Gson();
    }

    @RequestMapping(
            value="mostrar",
            method=RequestMethod.GET,
            produces="application/json")
    public ModelAndView mostrar() {
        ModelAndView mv = new ModelAndView();
        ArrayList prestamos = pbd.obtener();
        exito = prestamos != null;

        JsonObject jo = new JsonObject();
        jo.add("prestamos", gson.toJsonTree(prestamos, new TypeToken<ArrayList<Prestamo> >(){}.getType()));
        jo.addProperty("success", exito);
        String error = pbd.getError() == null? "": pbd.getError();
        jo.addProperty("error", error);

        mv.addObject("data", jo);
        mv.setViewName("api/imprimir");
        return mv;
    }

    @RequestMapping(
            value="mostrar/{conjunto}",
            method=RequestMethod.GET,
            produces="application/json")
    public ModelAndView mostrar(
            @PathVariable("conjunto") String conjunto,
            @RequestParam(value="id", required=false) int id,
            @RequestParam(value="cedula", required=false) int cedula,
            @RequestParam(value="titulo", required=false) String titulo
    ) {
        ModelAndView mv = new ModelAndView();

        ArrayList prestamos = null;
        exito = false;
        double cobro = 0;
        switch (conjunto) {
            // Obtiene los prestamos en mora.
            case "cobro":
                Prestamo prestamo = pbd.getPrestamo(id);
                cobro = prestamo == null? 1: prestamo.obtenerCobro();
                exito = cobro != 0;
                break;
            case "moras":
                prestamos = pbd.getMoras();
                exito = prestamos != null;
                break;

            case "cedula":
                prestamos = pbd.getPrestamosCliente(cedula);
                exito = prestamos != null && prestamos.size() > 0 && prestamos.get(0) != null;
                break;

            case "titulo":
                prestamos = pbd.getPrestamosPelicula(titulo);
                exito = prestamos != null && prestamos.size() > 0 && prestamos.get(0) != null;
                break;

            case "todos":
                prestamos = pbd.obtener();
                exito = prestamos != null;
                break;
        }
        JsonObject jo = new JsonObject();
        jo.add("prestamos", gson.toJsonTree(prestamos, new TypeToken<ArrayList<Prestamo> >(){}.getType()));
        jo.addProperty("success", exito);
        jo.addProperty("cobro", cobro);
        jo.addProperty("error", pbd.getError());


        mv.addObject("data", jo);
        mv.setViewName("api/imprimir");
        return mv;
    }

    @RequestMapping(
            value="agregar",
            method=RequestMethod.POST,
            produces="application/json")
    public ModelAndView agregar(
            @RequestParam(value="titulo", required=false) String titulo,
            @RequestParam(value="cedula", required=false) int cedula
    ) {
        ModelAndView mv = new ModelAndView();
        Cliente c = new ClientesBD().obtener(cedula);
        Pelicula p = new PeliculasBD().obtener(titulo);
        
        Prestamo prestamo = new Prestamo(c, p);
        exito = pbd.agregar(prestamo);
        JsonObject jo = new JsonObject();
        jo.addProperty("success", exito);
        jo.addProperty("error", pbd.getError());

        mv.addObject("data", jo);
        mv.setViewName("api/imprimir");
        return mv;
    }

    @RequestMapping(
            value="finalizar",
            method=RequestMethod.POST,
            produces="application/json")
    public ModelAndView finalizar(
            @RequestParam(value="id") int id
    ) {
        ModelAndView mv = new ModelAndView();
        exito = pbd.finalizarPrestamo(id);
        JsonObject jo = new JsonObject();
        jo.addProperty("success", exito);
        jo.addProperty("error", pbd.getError());

        mv.addObject("data", jo);
        mv.setViewName("api/imprimir");
        return mv;
    }
}
