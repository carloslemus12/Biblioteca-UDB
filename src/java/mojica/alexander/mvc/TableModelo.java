/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mojica.alexander.mvc;

import java.util.List;
import java.util.Vector;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author MekakuZero
 */
public class TableModelo extends DefaultTableModel {
    
    // Lista de los modeladores
    private List<Modelador> modelos;

    // Constructores sin cambio
    public TableModelo(int rowCount, int columnCount) {
        super(rowCount, columnCount);
    }
    public TableModelo(Vector columnNames, int rowCount) {
        super(columnNames, rowCount);
    }
    public TableModelo(Object[] columnNames, int rowCount) {
        super(columnNames, rowCount);
    }
    public TableModelo(Vector data, Vector columnNames) {
        super(data, columnNames);
    }
    public TableModelo(Object[][] data, Object[] columnNames) {
        super(data, columnNames);
    }
    
    // Constructor para usar con los modelos
    public TableModelo(List<Modelador> modelos, Object[] columnNames) {
        super(null, columnNames);
        this.modelos = modelos;
        
        for (Modelador modelado : modelos) 
            this.addRow(modelado.crearFila());
    }
    
    public Modelador obtenerModelador(int fila){
        if (this.modelos == null)
            return null;
        else
            return this.modelos.get(fila); 
    }
    
    // Para que no pueda editar las filas
    @Override
    public boolean isCellEditable(int row, int column) {
        return false;
    }
}
