pkg load control;
pkg load signal;

function init()
  Inicio = figure;
  set (Inicio,"name","Trabajo Practico - Matematica Superior");
  set (Inicio,"color","white");
  set (Inicio,"menubar","none");
  set (Inicio,"numbertitle","off");

  pantalla = uibuttongroup (Inicio, "position", [ 0 0 1 1],...
      "title","Menu","titleposition","centertop");
  
  tituloPrincipal = uicontrol (Inicio,"style","text", ...
      "string","Seleccione datos a ingresar:","position",[85,300,400,50], ... 
      "fontsize",20); 
  
  calculoConCoeficientes = uicontrol (pantalla,"string","Coeficientes", ...
      "position",[50,150,200,100],"callback",{@ventanaCoeficientes}, ...
      "backgroundcolor",[.8,.8,.8],"fontsize",13);
   
  calculoConDatosCPG = uicontrol (pantalla,"string","Ceros, polos y ganancia", ...
      "position",[300,150,200,100],"callback",{@ventanaDatos}, ...
      "backgroundcolor",[.8, .8, .8  ],"fontsize",13);
endfunction

init();
