/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package paolo.aliprandi.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class GetCellaValue extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    String index = request.getParameter("index");
    String riga = request.getParameter("riga");
    String colonna = request.getParameter("colonna");
    String value = request.getParameter("value");
    
    System.out.println("---------------");
    System.out.println("Valore letto "+value);
    
    PrintWriter out=response.getWriter();
    ServletContext context = request.getServletContext();
    
    System.out.println("Getting sudoku"+index);
    Sudoku s = (Sudoku) context.getAttribute("sudoku"+index);
    
    String so = s.getSolution();
    String[] sol = so.split("\\s");
    
    String [][] solution = new String[9][9];
    
    int dim=9;
    
    for (int i=0; i<9; i++) {
            for (int j=0; j<9; j++) {
                solution[i][j] = sol[(i*dim)+j];
            }
    }
    
    int r = Integer.parseInt(riga);
    int c = Integer.parseInt(colonna);
    
    System.out.println("SOLUZIONE r:"+r+" c:"+c+" "+solution[r-1][c-1]);
    
    String obj = "{ \"value\": \""+value+"\", \"soluzione\": \""+solution[r-1][c-1]+"\", \"isCorrect\": "+solution[r-1][c-1].equals(value)+" }";
    /**
    if (solution[r-1][c-1].equals(value)) {
        
       out.println(solution[r-1][c-1]+"0"); 
    } else {
        out.println(solution[r-1][c-1]+"0"); 
    }
    */
    
    System.out.println(obj);
    
    out.println(obj); 
    
    response.setContentType("text/plain;charset=UTF-8");
   
    out.close();
    }
}
