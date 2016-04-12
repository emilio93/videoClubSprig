package videoClub.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Inicio {
    @RequestMapping(value="clientes")
    public ModelAndView clientes() {
        ModelAndView mv = new ModelAndView("clientes");
        return mv;
    }
    
    @RequestMapping(value="peliculas")
    public ModelAndView peliculas() {
        ModelAndView mv =  new ModelAndView("peliculas");
        return mv;
    }
    
    @RequestMapping(value="prestamos")
    public ModelAndView prestamos() {
        ModelAndView mv =  new ModelAndView("prestamos");
        return mv;
    }
}