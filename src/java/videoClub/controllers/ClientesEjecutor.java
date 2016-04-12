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
import videoClub.sistema.Cliente;

@Controller
@RequestMapping("/api/clientes")
public class ClientesEjecutor {
    private ClientesBD cbd;
    private boolean exito;
    private Gson gson;
    
    
    public ClientesEjecutor() {
        cbd = new ClientesBD();
        gson = new Gson();
    }
    
    @RequestMapping(
            value="mostrar", 
            method=RequestMethod.GET, 
            produces="application/json")
    public ModelAndView mostrar() {
        ModelAndView mv = new ModelAndView();
        ArrayList clientes = cbd.obtener();
        exito = clientes != null;
        
        JsonObject jo = new JsonObject();
        jo.add("clientes", gson.toJsonTree(clientes, new TypeToken<ArrayList<Cliente> >(){}.getType()));
        jo.addProperty("success", exito);
        String error = cbd.getError() == null? "": cbd.getError();
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
            @RequestParam(value="cedula")int cedula
    ) {
        ModelAndView mv = new ModelAndView();
        
        ArrayList clientes = null;
        switch (conjunto) {
            // Obtiene los clientes morosos.
            case "morosos":
                clientes = cbd.clientesMorosos();
                exito = clientes != null;
                break;

            // Obtiene cliente por cedula.
            case "cedula":
                clientes = new ArrayList<>();
                clientes.add(cbd.obtener(cedula));
                exito = clientes != null && clientes.size() > 0 && clientes.get(0) != null;
                break;

            // Obtiene clientes según cantidad y página.
            case "pagina":
                //clientes = cbd.obtener(
                //        Integer.parseInt(request.getParameter("cantidad")), 
                //        Integer.parseInt(request.getParameter("pagina")));
                exito = clientes != null;
                break;

            // Obtiene todos los clientes.
            case "todos":
                clientes = cbd.obtener();
                exito = clientes != null;
                break;

            case "":
                clientes = cbd.obtener();
                exito = clientes != null;
                break;
        }
        JsonObject jo = new JsonObject();
        jo.add("clientes", gson.toJsonTree(clientes, new TypeToken<ArrayList<Cliente> >(){}.getType()));
        jo.addProperty("success", exito);
        jo.addProperty("error", cbd.getError());
        
        
        mv.addObject("data", jo);
        mv.setViewName("api/imprimir");
        return mv;
    }
    
    @RequestMapping(
            value="agregar", 
            method=RequestMethod.POST, 
            produces="application/json")
    public ModelAndView agregar(
            @RequestParam(value="cedula") int cedula,
            @RequestParam(value="nombre") String nombre,
            @RequestParam(value="apellido1") String apellido1,
            @RequestParam(value="apellido2") String apellido2,
            @RequestParam(value="telefono") int telefono,
            @RequestParam(value="email") String email,
            @RequestParam(value="direccion") String direccion
    ) {
        ModelAndView mv = new ModelAndView();
        
        Cliente cliente = new Cliente(cedula, nombre, apellido1, apellido2, telefono, email, direccion);
        exito = cbd.agregar(cliente);
        JsonObject jo = new JsonObject();
        jo.addProperty("success", exito);
        jo.addProperty("error", cbd.getError());
        
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
            @RequestParam(value="cedula") int cedula,
            @RequestParam(value="nombre") String nombre,
            @RequestParam(value="apellido1") String apellido1,
            @RequestParam(value="apellido2") String apellido2,
            @RequestParam(value="telefono") int telefono,
            @RequestParam(value="email") String email,
            @RequestParam(value="direccion") String direccion
    ) {
        ModelAndView mv = new ModelAndView();
        
        Cliente cliente = new Cliente(id, cedula, nombre, apellido1, apellido2, telefono, email, direccion);
        exito = cbd.actualizar(cliente);
        JsonObject jo = new JsonObject();
        jo.addProperty("success", exito);
        jo.addProperty("error", cbd.getError());
        
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
        exito = cbd.eliminar(id);
        JsonObject jo = new JsonObject();
        jo.addProperty("success", exito);
        jo.addProperty("error", cbd.getError());
        
        mv.addObject("data", jo);
        mv.setViewName("api/imprimir");
        return mv;
    }
}