
pkg load control;
pkg load signal;

function init()
  Inicio = figure('Position',[400 400 600 170],'Units','Pixels');
  set (Inicio,"name","ASIC");
  set (Inicio,"numbertitle","off");
  set (Inicio,"menubar","none");

  pantalla = uibuttongroup (Inicio, "position", [ 0 0 1 1],...
      "title","Menu","titleposition","centertop");

f = uimenu ("label", "&Archivo", "accelerator", "f");
e = uimenu ("label", "&Acerca del TP", "accelerator", "f");
uimenu (f, "label", "Cerrar", "accelerator", "q", ...
           "callback", "close (gcf)");
uimenu (e, "label", "Integrantes", "accelerator", "i", ...
           "callback",{@mostrarIntegrantes});
           
  tituloPrincipal = uicontrol (Inicio,"style","text", ...
      "string","Seleccione datos a ingresar","position",[100,100,400,50], ... 
      "fontsize",20); 
  
  calculoConCoeficientes = uicontrol (pantalla,"string","Coeficientes", ...
      "position",[0,40,300,60],"callback",{@ventanaCoeficientes}, ...
      "backgroundcolor",[.8,.8,.8],"fontsize",13);
   
  calculoConDatosCPG = uicontrol (pantalla,"string","Ceros, polos y ganancia", ...
      "position",[300,40,300,60],"callback",{@ventanaDatos}, ...
      "backgroundcolor",[.8, .8, .8  ],"fontsize",13);
endfunction

funciones;
ventanaCoeficientes;
ventanaDatos;
init();
