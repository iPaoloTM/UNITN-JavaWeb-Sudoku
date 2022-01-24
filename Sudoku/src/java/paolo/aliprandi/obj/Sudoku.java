/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package paolo.aliprandi.obj;

import java.io.Serializable;

/**
 *
 * @author paoloaliprandi
 */
public class Sudoku implements Serializable {
    
    private String index;
    private String fixed_cells;
    private String solution;
    
    public Sudoku() {}
    
    public Sudoku(String index, String fixed_cells, String solution) {
        this.index=index;
        this.fixed_cells=fixed_cells;
        this.solution=solution;
    }
    
    public String getIndex() {
        return index;
    }
    
    public String getFixedCells() {
        return fixed_cells;
    }
    
    public String getSolution() {
        return solution;
    }
    
    public void setIndex() {
        this.index=index;
    }
    
    public void setFixedCells() {
        this.fixed_cells=fixed_cells;
    }
    
    public void gstSolution() {
        this.solution=solution;
    }
    
}
