pkg load control;
pkg load signal;

function ventanaCoeficientes (handlesource,event)
  PantallaCoeficientes = figure;
  
  set (PantallaCoeficientes,"name","Funcion de transferencia: Coeficientes");
  set (PantallaCoeficientes,"numbertitle","off");
  set (PantallaCoeficientes,"menubar","none");
   
  Coeficientes = uibuttongroup (PantallaCoeficientes, "position", [ 0 0 1 6], "title","Establezca los coeficientes y elija su opcion","titleposition","centertop");
               
  textCoeficientesNumerador = uicontrol (Coeficientes,"style","text", "string","Coeficientes del numerador:","position",[5,350,250,40], "fontsize",12);  
               
  coeficientesNumerador = uicontrol (Coeficientes, "style", "edit", "string", "1,2,-5,20,-141,18,-135", "position",[250,350,250,40], "fontsize",14,"backgroundcolor","white");            
             
  separador = uicontrol (Coeficientes,"style","text", "string","________________________________","position",[250,315,250,40], "fontsize",12);             
               
  textCoeficientesDenominador = uicontrol (Coeficientes,"style","text", "string","Coeficientes del denominador:","position",[5,270,250,40], "fontsize",12);  
  
  coeficientesDenominador = uicontrol (Coeficientes, "style", "edit", "string", "1,-4,4,-4,3", "position",[250,270,250,40], "fontsize",14,"backgroundcolor","white");
               
  botonExpresion = uicontrol (Coeficientes,"string","Expresion", "position",[10,170,150,35],"callback", {@calcularExpresion,coeficientesNumerador,coeficientesDenominador,0,false}, "backgroundcolor",[.8,.8,.8]);
  
  botonPolos = uicontrol (Coeficientes,"string","Polos", "position",[200,170,150,35],"callback",{@calcularPolos,coeficientesNumerador,coeficientesDenominador,0,false}, "backgroundcolor",[.8,.8,.8]);
  
  botonCeros = uicontrol (Coeficientes,"string","Ceros", "position",[390,170,150,35],"callback",{@calcularCeros,coeficientesNumerador,coeficientesDenominador,0,false}, "backgroundcolor",[.8,.8,.8]);
  
  botonGanancia = uicontrol (Coeficientes,"string","Ganancia", "position",[10,110,150,35],"callback",{@mostrarGanancia,coeficientesNumerador,coeficientesDenominador,0,false}, "backgroundcolor",[.8,.8,.8]);
  
  botonExpresionCPG = uicontrol (Coeficientes,"string","Expresion CPG", "position",[200,110,150,35],"callback",{@calcularExpresionCPG,coeficientesNumerador,coeficientesDenominador,0,false}, "backgroundcolor",[.8,.8,.8]);
  
  botonGraficar = uicontrol (Coeficientes,"string","Graficar ceros y polos", "position",[390,110,150,35],"callback",{@graficar,coeficientesNumerador,coeficientesDenominador,0,false}, "backgroundcolor",[.8,.8,.8]);
  
  botonEstabilidad = uicontrol (Coeficientes,"string","Indicar estabilidad", "position",[200,50,150,35],"callback",{@calcularEstabilidad,coeficientesNumerador,coeficientesDenominador,0,false}, "backgroundcolor",[.8,.8,.8]);
  
  botonTodo = uicontrol (Coeficientes,"string","Analizar todo", "position",[123,0,300,40],"callback",{@calcularTodo,coeficientesNumerador,coeficientesDenominador,0,false}, "backgroundcolor",[.8,.8,.8],"fontsize",16);
   
  botonLimpiar = uicontrol (Coeficientes, "string", "Limpiar","position", [250,225,150,40], "backgroundcolor",[.8,.2,.2], 'callback',{@Limpiar});

endfunction
