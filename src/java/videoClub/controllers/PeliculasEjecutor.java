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
import videoClub.bd.PeliculasBD;
import videoClub.sistema.Pelicula;

@Controller
@RequestMapping("/api/peliculas")
public class PeliculasEjecutor {
    private PeliculasBD pbd;
    private boolean exito;
    private Gson gson;
    
    
    public PeliculasEjecutor() {
        pbd = new PeliculasBD();
        gson = new Gson();
    }
    
    @RequestMapping(
            value="mostrar", 
            method=RequestMethod.GET, 
            produces="application/json")
    public ModelAndView mostrar() {
        ModelAndView mv = new ModelAndView();
        ArrayList peliculas = pbd.obtener();
        exito = peliculas != null;
        
        JsonObject jo = new JsonObject();
        jo.add("peliculas", gson.toJsonTree(peliculas, new TypeToken<ArrayList<Pelicula> >(){}.getType()));
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
            @RequestParam(value="titulo")String titulo
    ) {
        ModelAndView mv = new ModelAndView();
        
        ArrayList peliculas = null;
        exito = false;
        switch (conjunto) {
            // Obtiene las peliculas en mora.
            case "moras":
                peliculas = pbd.peliculasEnMora();
                exito = peliculas != null;
                break;

            // Obtiene pelicula por titulo.
            case "titulo":
                peliculas = new ArrayList<>();
                peliculas.add(pbd.obtener(titulo));
                exito = peliculas != null && peliculas.size() > 0 && peliculas.get(0) != null;
                break;

            // Obtiene todos los clientes.
            case "todas":
                peliculas = pbd.obtener();
                exito = peliculas != null;
                break;
        }
        JsonObject jo = new JsonObject();
        jo.add("peliculas", gson.toJsonTree(peliculas, new TypeToken<ArrayList<Pelicula> >(){}.getType()));
        jo.addProperty("success", exito);
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
            @RequestParam(value="titulo") String titulo,
            @RequestParam(value="direccion") String direccion,
            @RequestParam(value="produccion") String produccion,
            @RequestParam(value="ano") int ano,
            @RequestParam(value="genero") String genero,
            @RequestParam(value="duracion") int duracion,
            @RequestParam(value="sinopsis") String sinopsis,
            @RequestParam(value="cantidad") int cantidad
    ) {
        ModelAndView mv = new ModelAndView();
        Pelicula pelicula = new Pelicula(titulo, direccion, produccion, ano, genero, duracion, sinopsis, cantidad);
        exito = pbd.agregar(pelicula);
        JsonObject jo = new JsonObject();
        jo.addProperty("success", exito);
        jo.addProperty("error", pbd.getError());
        
        mv.addObject("data", jo);
        mv.setViewName("api/imprimir");
        return mv;
    }
    
    @RequestMapping(
            value="actualizar", 
            method=RequestMethod.POST, 
            produces="application/json")
    public ModelAndView actualizar(
            @RequestParam(value="id") int id,
            @RequestParam(value="titulo") String titulo,
            @RequestParam(value="direccion") String direccion,
            @RequestParam(value="produccion") String produccion,
            @RequestParam(value="ano") int ano,
            @RequestParam(value="genero") String genero,
            @RequestParam(value="duracion") int duracion,
            @RequestParam(value="sinopsis") String sinopsis,
            @RequestParam(value="cantidad") int cantidad
    ) {
        ModelAndView mv = new ModelAndView();
        
        Pelicula pelicula = new Pelicula(id, titulo, direccion, produccion, ano, genero, duracion, sinopsis, cantidad);
        exito = pbd.actualizar(pelicula);
        JsonObject jo = new JsonObject();
        jo.addProperty("success", exito);
        jo.addProperty("error", pbd.getError());
        
        mv.addObject("data", jo);
        mv.setViewName("api/imprimir");
        return mv;
    }
    
    @RequestMapping(
            value="eliminar", 
            method=RequestMethod.POST, 
            produces="application/json")
    public ModelAndView eliminar(
            @RequestParam(value="id") int id
    ) {
        ModelAndView mv = new ModelAndView();
        exito = pbd.eliminar(id);
        JsonObject jo = new JsonObject();
        jo.addProperty("success", exito);
        jo.addProperty("error", pbd.getError());
        
        mv.addObject("data", jo);
        mv.setViewName("api/imprimir");
        return mv;
    }
}