<%@page import="paolo.aliprandi.obj.Sudoku"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%
    String dbURL = "jdbc:derby://localhost:1527/SudokuDB"; 
    String dbUser = "WEBENGINE";
    String dbPassword = "WEBENGINE";
    Connection conn = null;
    ResultSet res = null;
       
    String query= "SELECT * FROM WEBENGINE.\"DATA\"";
    
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        Statement stmt = conn.createStatement();
        res = stmt.executeQuery(query);
        
        
    } catch (SQLException x) {
        
    }
    
%>

<html>
    <head>
        <title>SudokuWeb</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Benvenuto al Sudoku!</h1>
        <img src="img/sudoku.jpg">
        <ul>
            <%
                try {
                    while (res.next()) { //se uso <% non funziona, devo usare <%=
                        %>
                        <li>
                            <a href="game.jsp?index=<%= res.getInt(1) %>">Sudoku n.<%= res.getInt(1) %></a><br>
                        </li>
                        <%
                        String fixed_cells = res.getString("FIXEDCELLS");
                        String solution = res.getString("SOLUTION");
                        
                        String index = res.getString("ID");
                        System.out.println("-----------");
                        System.out.println(fixed_cells);
                        System.out.println(solution);
                        System.out.println(index);
                        
                        Sudoku s = new Sudoku(index, fixed_cells, solution);
                        
                        request.getServletContext().setAttribute("sudoku"+index, s);
                    }
                } catch (NullPointerException e) {
                    e.printStackTrace();
                    %>
                    <p>Errore di Connessione col DB</p>
                    <%
                } 

                
            %>
        </ul>
        
    </body>
</html>
