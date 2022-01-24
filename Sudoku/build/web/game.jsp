<%-- 
    Document   : gam
    Created on : 15-gen-2022, 17.15.08
    Author     : paoloaliprandi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            
            array=[];
            array1=[];
            array2=[];
            
            $(document).ready(function () {
                //console.log("++++++");
                $.ajax({
                    type: 'GET',
                    url: 'GameServlet',
                    data: 'index='+ <%= request.getParameter("index") %>,
                    datatype: 'html',
                    success: function(data) {
                        
                        
                        array = data.split(" ");
                        
                        for (var i=0; i< array.length-1; i++){
                            var str = array[i].substring(0,2);
                            array1[i]=str;
                            array2[i]=array[i].slice(-1); //prendi l'ultimo carattere della stringa
                        }
                        
                        generateSudoku(array1, array2);
                        //console.log("*****");
                    }
                        
                });
            });
            
            function isDiag(i, j) {
                cond=false;
                
                if ((((i>=1 && i<=3) || (i>=7 && i<=9)) && ((j>=1 && j<=3) || (j>=7 && j<=9))) || ((i>=4 && i<=6) && (j>=4 && j<=6))) {
                    cond=true;
                }
                
                return cond;
            }
            
            function checkValue() {
                
                console.log("checkvalue");
                
                var riga = document.getElementById("riga");
                var colonna = document.getElementById("colonna");
                
                var input_field=document.getElementById(riga.value + colonna.value);
                var value = input_field.value;
                
                if (value === "") {
                    alert("Cella vuota");
                    return;
                }   
                
                console.log(value);
                
                $.ajax({
                    type: 'GET',
                    url: 'GetCellaValue',
                    data: 'riga='+riga.value+'&colonna='+colonna.value+'&value='+value+'&index='+ <%= request.getParameter("index") %>,
                    datatype: 'html',
                    success: function(data) {
                        
                        console.log("data:"+data);
                        var json = JSON.parse(data);
                        
                        //var isCorrect = data.slice(-1);
                        //var num = data.substring(0,1);
                        
                        if (!json.isCorrect) {
                            
                            alert("Il numero inserito è sbagliato! D:");
                        } else {
                            
                            alert("Il numero inserito è corretto! :D");
                            
                            input_field = document.getElementById(""+riga.value+colonna.value); //disabilito la cella col valore giusto
                            input_field.value = json.soluzione;
                            input_field.disabled = "disabled";
                        }
                        
                    } 
                })
                
            }
            
            function generateSudoku(array1, array2) {
            
                table = document.getElementById("grid");
                
                for (var i =1; i<10; i++) {
                    
                    var tr=document.createElement("tr");
                    
                    for (var j=1; j<10; j++) {
                        
                        let style="";
                        
                        var td = document.createElement("td");
                        var input_field = document.createElement("input");
                        
                        
                        if (array1.includes(""+i+j)) {
                            
                            var number = array1.indexOf(""+i+j);
                            
                            style = "color: #FF0000; ";
                            input_field.value = array2[number];
                            input_field.disabled = "disabled";
                        }
                        
                        
                        
                        input_field.class="gridblu";
                        input_field.type = "number";
                        input_field.min = "1";
                        input_field.max = "9";
                        input_field.id = ""+i+""+j;
                        style = style + "background-color: #F0F8FF; margin:0; padding:15px; border:none; display:inline-block;";
                        
                        if (isDiag(i,j)) {
                             style = style + "background-color: #FFE4E1";
                        } else {
                            style = style + "background-color: #F0F8FF";
                        }
                        
                        input_field.style = style;
                        
                        td.appendChild(input_field);
                        tr.appendChild(td);                       
                    }                   
                    table.appendChild(tr);
                    //console.log("*****"+table);
                }
            }
          
        </script>
    </head>
    <body> <!-- onload="generateSudoku()" !-->
        <h2>Gioca a Sudoku!</h2>
        
        <table id="grid"></table>
        
        <div>Riga:<input type="number" id="riga" min="1" max="9" required> 
             Colonna: <input type="number" id="colonna" min="1" max="9" required>
             <button onclick="checkValue()">Verifica</button>
             </div>                        
       
    </body>
</html>
