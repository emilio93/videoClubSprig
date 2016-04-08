package videoClub.sistema;

/**
 * Representación de un cliente.
 * @author Emilio Rojas
 */
public class Cliente {
    
    /**
     * Id del cliente.
     */
    private int idCliente;
    
    /**
     * Cédula del cliente.
     */
    private int cedula;
    
    /**
     * Nombre del cliente.
     */
    private String nombre;
    /**
     * Primer apellido del cliente.
     */
    private String apellido1;
    
    /**
     * Segundo apellido del cliente.
     */
    private String apellido2;
    
    /**
     * Teléfono del cliente.
     */
    private int telefono;
    
    /**
     * Email del cliente.
     */
    private String email;
    
    /**
     * Dirección del cliente.
     */
    private String direccion;
    
    /**
     * Permite la instanciación vacía de un cliente.
     */
    public Cliente() {}
    
    /**
     * Instanciación de un cliente con todos sus atributos.
     * @param id Id del cliente.
     * @param cedula Cedula del cliente.
     * @param nombre Nombre del cliente.
     * @param apellido1 Primer apellido del cliente.
     * @param apellido2 Segundo apellido del cliente.
     * @param telefono Teléfono del cliente.
     * @param email Email del cliente.
     * @param direccion Dirección del cliente.
     */
    public Cliente(
            int id, 
            int cedula, 
            String nombre, 
            String apellido1, 
            String apellido2, 
            int telefono, 
            String email, 
            String direccion
    ) {
        this.idCliente = id;
        this.cedula = cedula;
        this.nombre = nombre;
        this.apellido1 = apellido1;
        this.apellido2 = apellido2;
        this.telefono = telefono;
        this.email = email;
        this.direccion = direccion;
    }
    
    public Cliente(
            int cedula, 
            String nombre, 
            String apellido1, 
            String apellido2, 
            int telefono, 
            String email, 
            String direccion
    ) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.apellido1 = apellido1;
        this.apellido2 = apellido2;
        this.telefono = telefono;
        this.email = email;
        this.direccion = direccion;
    }
    
    /**
     * Método get para el id.
     * @return Id del cliente.
     */
    public int getIdCliente() {
        return idCliente;
    }
    
    /**
     * Método set para el id.
     * @param idCliente Id del cliente.
     */
    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getCedula() {
        return cedula;
    }

    public void setCedula(int cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido1() {
        return apellido1;
    }

    public void setApellido1(String apellido1) {
        this.apellido1 = apellido1;
    }

    public String getApellido2() {
        return apellido2;
    }

    public void setApellido2(String apellido2) {
        this.apellido2 = apellido2;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
}
