package videoClub.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import videoClub.bd.ClientesBD;

@Controller
public class Clientes {
    private ClientesBD cbd;
    
    public Clientes() {
        cbd = new ClientesBD();
    }
    
    @RequestMapping("clientes/show")
    public ModelAndView showClientes() {
        
        ModelAndView mv =  new ModelAndView();
        mv.setViewName("showClientes");
        return mv;
    }
    
    @RequestMapping("cliente/add")
    public ModelAndView addCliente() {
        ModelAndView mv =  new ModelAndView();
        mv.setViewName("clientes/add");
        return mv;
    }
    
    @RequestMapping("cliente/update")
    public ModelAndView updateCliente() {
        ModelAndView mv =  new ModelAndView();
        mv.setViewName("clientes/delete");
        return mv;
    }
    
    @RequestMapping("cliente/delete")
    public ModelAndView deleteCliente() {
        ModelAndView mv =  new ModelAndView();
        mv.setViewName("deleteCliente");
        return mv;
    }
    
    @RequestMapping("index")
    public ModelAndView index() {
        ModelAndView mv =  new ModelAndView();
        mv.setViewName("index");
        return mv;
    }
    
}