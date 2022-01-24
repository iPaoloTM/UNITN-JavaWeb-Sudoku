/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package paolo.aliprandi.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import paolo.aliprandi.obj.Sudoku;

/**
 *
 * @author paoloaliprandi
 */
public class GameServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("GameServlet");
        
        String index = request.getParameter("index");
        
        PrintWriter out = response.getWriter();
        ServletContext context = request.getServletContext();

        Sudoku s = (Sudoku)context.getAttribute("sudoku"+index);
        
        String fixed = s.getFixedCells();
        String[] fixed_cells = fixed.split("\\s");
        
        String so = s.getSolution();
        String[] sol = so.split("\\s");
        
        String[][] solution = new String[9][9];
        
        int dim=9;
        
        for (int i=0; i<9; i++) {
            for (int j=0; j<9; j++) {
                solution[i][j] = sol[(i*dim)+j];
            }
        }
        
        String[] number = new String[fixed_cells.length];
        
        for (int i=0; i <number.length; i++) {
            int first = Integer.parseInt(String.valueOf(fixed_cells[i].charAt(0)));
            int second = Integer.parseInt(String.valueOf(fixed_cells[i].charAt(1)));
            number[i] = solution[first-1][second-1];
            
            try {
                
                out.print(String.valueOf(first) + "" + String.valueOf(second) + "" +number[i]+" ");
            } catch (Exception x) {}
        }
    }

}
