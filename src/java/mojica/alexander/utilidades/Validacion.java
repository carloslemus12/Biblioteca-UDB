/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mojica.alexander.utilidades;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
/**
 *
 * @author MekakuZero
 */
public class Validacion {
    
    // Metodo para comprobar los email
    public static boolean validarEmail(String msg){
        return validacion(msg, "^[a-zA-Z][a-zA-Z.]+@[a-zA-Z]+.com$");
    }
    
    // Metodo base de la validacion
    private static boolean validacion(String msg, String patron){
        Pattern ptn = Pattern.compile(patron);
        Matcher m = ptn.matcher(msg);
        
        return m.matches();
    }
    
    public static final String requerid = "Requerid";
    public static final String email = "Email";
    
    // Datos de los campos
    private Map<String, List<String>> campos;
    private Map<String, String> field;
    private List<String> errores;
    private Map<String, String> comparar;
    
    // Obtenemos los string
    public Validacion(){
        campos = new HashMap<String, List<String>>();
        field = new HashMap<>();
        comparar = new HashMap<>();
        errores = new ArrayList<String>();
    }
    
    public void setField(String field, String value)
    {
        if (!this.field.containsKey(field))
            this.field.put(field, value);
    }
    
    // Añadir campo
    public void addRule(String field, String rule)
    {
        if (this.field.containsKey(field)) {
            if (!this.campos.containsKey(field)) {
                List<String> rules = new ArrayList<>();
                rules.add(rule);
                this.campos.put(field, rules);
            } else {
                List<String> rules = this.campos.get(field);
                if (!rules.contains(rule))
                    rules.add(rule);
            }
        }
    }
    
    public void compareFields(String field, String field_to_compare)
    {
        if (this.field.containsKey(field) && this.field.containsKey(field_to_compare)) {
            if (!this.comparar.containsKey(field)) {
                this.comparar.put(field, field_to_compare);
            } 
        }
    }
    
    public boolean valido(){
        boolean estado = true;
        errores = new ArrayList<String>();
        
        for(Map.Entry<String, List<String>> fields : this.campos.entrySet()){
            List<String> rules = fields.getValue();
            String value = this.field.get(fields.getKey());
            
            for (String rule : rules) {
                switch(rule){
                    case Validacion.requerid:
                        if (value == null || value.isEmpty())
                        {
                            errores.add("El campo " + fields.getKey() + " es requerido");
                            estado = false;
                        }
                        break;
                        
                    case Validacion.email:
                        if (!Validacion.validarEmail(value))
                        {
                            errores.add("El campo " + fields.getKey() + " debe de ser un correro electronico valido");
                            estado = false;
                        }
                        break;
                }
            }
            
            if (this.comparar.containsKey(fields.getKey()))
            {
                String key_compare = this.comparar.get(fields.getKey());
                String value_compare = this.field.get(key_compare);
                
                if (!value.equals(value_compare)) {
                    errores.add("El campo " + fields.getKey() + " debe de ser igual al campo " + key_compare);
                    estado = false;
                }
            }
        }
        
        return estado;
    }
    
    public String erroresJSON(){
        String json = "[";
        
        boolean estado = true;
        for(String error : this.errores){
            if(!estado) json += ",";
            json += "\"" + error + "\"";
            estado = false;
        }
            
        json += "]";
        return json;
    }
}
