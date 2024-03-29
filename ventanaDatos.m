pkg load control;
pkg load signal;

function ventanaDatos (handlesource,event)
  PantallaCPG = figure;
  
  set (PantallaCPG,"name","Funcion de transferencia: Ceros, polos y ganancia");
  set (PantallaCPG,"numbertitle","off");
  set (PantallaCPG,"menubar","none");
    
  entornoCPG = uibuttongroup (PantallaCPG, "position", [ 0 0 1 1],"title","Indique los ceros, polos y ganancia y elija su opcion", "titleposition","centertop");
               
  textCeros = uicontrol (entornoCPG,"style","text", "string","Ceros","position",[50,320,80,40], "fontsize",16);  
  
  ceros = uicontrol (entornoCPG, "style", "edit", "string", "1,4,1+i,3,8", "position",[15,280,150,40], "fontsize",12,"backgroundcolor","white");        
               
  textPolos = uicontrol (entornoCPG,"style","text", "string","Polos","position",[230,320,80,40], "fontsize",16);  
  
  polos = uicontrol (entornoCPG, "style", "edit", "string", "5+2i,9,1+i,4,12-i", "position",[200,280,150,40], "fontsize",12,"backgroundcolor","white");  
               
  textGanancia = uicontrol (entornoCPG,"style","text", "string","Ganancia","position",[400,320,100,40], "fontsize",16);  
  
  ganancia = uicontrol (entornoCPG, "style", "edit", "string", "2", "position",[380,280,150,40], "fontsize",12,"backgroundcolor","white");  
               
  botonExpresion = uicontrol (entornoCPG,"string","Expresion", "position",[10,190,150,35],"callback", {@calcularExpresion,ceros,polos,ganancia,true}, "backgroundcolor",[.8,.8,.8]);
  
  botonPolos = uicontrol (entornoCPG,"string","Polos", "position",[200,190,150,35],"callback",{@calcularPolos,ceros,polos,ganancia,true}, "backgroundcolor",[.8,.8,.8]);
  
  botonCeros = uicontrol (entornoCPG,"string","Ceros", "position",[390,190,150,35],"callback",{@calcularCeros,ceros,polos,ganancia,true}, "backgroundcolor",[.8,.8,.8]);
  
  botonGanancia = uicontrol (entornoCPG,"string","Ganancia", "position",[10,130,150,35],"callback",{@mostrarGanancia,ceros,polos,ganancia,true}, "backgroundcolor",[.8,.8,.8]);
  
  botonExpresionCPG = uicontrol (entornoCPG,"string","Expresion C-P-G", "position",[200,130,150,35],"callback",{@calcularExpresionCPG,ceros,polos,ganancia,true},"backgroundcolor",[.8,.8,.8]);
  
  botonGraficar = uicontrol (entornoCPG,"string","Graficar ceros y polos", "position",[390,130,150,35],"callback",{@graficar,ceros,polos,ganancia,true}, "backgroundcolor",[.8,.8,.8]);
  
  botonEstabilidad = uicontrol (entornoCPG,"string","Indicar estabilidad", "position",[200,70,150,35],"callback",{@calcularEstabilidad,ceros,polos,ganancia,true}, "backgroundcolor",[.8,.8,.8]);
  
  botonTodo = uicontrol (entornoCPG,"string","Analizar todo", "position",[123,5,300,40],"callback",{@calcularTodo,ceros,polos,ganancia,true}, "backgroundcolor",[.8,.8,.8],"fontsize",16);
  
  botonLimpiar = uicontrol (entornoCPG, "string", "Limpiar","position", [200,235,150,40], "backgroundcolor",[.8,.2,.2], 'callback',{@Limpiar});

endfunction
