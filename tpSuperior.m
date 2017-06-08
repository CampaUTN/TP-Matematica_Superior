pkg load control;
pkg load signal;

function init()
  Inicio = figure;
  set (Inicio,"name","Trabajo Práctico - Matematica Superior");
  set (Inicio,"numbertitle","off");
  set (Inicio,"color","white");
  set (Inicio,"menubar","none");

  pantalla = uibuttongroup (Inicio, "position", [ 0 0 1 1],...
                            "title","Seleccione un metodo de ingreso de valores","titleposition","centertop");
  
   calculoConCoeficientes = uicontrol (pantalla,"string","Coeficientes", ...
                 "position",[125,250,300,100],"callback",{@abrirMetodoCoeficientes}, ...
                 "backgroundcolor",[.8,.8,.8],"fontsize",13);
   calculoConDatosCPG = uicontrol (pantalla,"string","Ceros, polos y ganancia", ...
                 "position",[125,100,300,100],"callback",{@abrirMetodoDatos}, ...
                 "backgroundcolor",[.8,.8,.8],"fontsize",13);
endfunction

function abrirMetodoCoeficientes (handlesource,event)
  PantallaCoeficientes = figure;
  set (PantallaCoeficientes,"name","Función de transferencia: Coeficientes");
  set (PantallaCoeficientes,"numbertitle","off");
  
  Coeficientes = uibuttongroup (PantallaCoeficientes, "position", [ 0 0 1 6], ...
               "title","Establezca los coeficientes y elija su opción","titleposition","centertop");
               
  textCoeficientesNumerador = uicontrol (Coeficientes,"style","text", ...
               "string","Coeficientes del numerador:","position",[5,350,250,40], ... 
               "fontsize",12);  
               
  coeficientesNumerador = uicontrol (Coeficientes, "style", "edit", ...
               "string", "2,7,4", "position",[250,350,250,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);            
             
  separador = uicontrol (Coeficientes,"style","text", ...
               "string","________________________________","position",[250,300,250,40], ... 
               "fontsize",12);          
         
               
  textCoeficientesDenominador = uicontrol (Coeficientes,"style","text", ...
               "string","Coeficientes del denominador:","position",[5,250,250,40], ... 
               "fontsize",12);  
  coeficientesDenominador = uicontrol (Coeficientes, "style", "edit", ...
               "string", "6,1,9,3", "position",[250,250,250,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);
               
  botonExpresion = uicontrol (Coeficientes,"string","Expresión", ...
               "position",[10,120,150,25],"callback", ...
               {@calcularExpresion,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonPolos = uicontrol (Coeficientes,"string","Polos", ...
               "position",[200,120,150,25],"callback",...
               {@calcularPolos,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonCeros = uicontrol (Coeficientes,"string","Ceros", ...
               "position",[400,120,150,25],"callback",...
               {@calcularCeros,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonGanancia = uicontrol (Coeficientes,"string","Ganancia", ...
               "position",[10,80,150,25],"callback",...
               {@mostrarGanancia,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonExpresionCPG = uicontrol (Coeficientes,"string","Expresión CPG", ...
               "position",[200,80,150,25],"callback",...
               {@calcularExpresionCPG,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonGraficar = uicontrol (Coeficientes,"string","Graficar ceros y polos", ...
               "position",[400,80,150,25],"callback",...
               {@mostrarGrafico,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonEstabilidad = uicontrol (Coeficientes,"string","Indicar estabilidad", ...
               "position",[100,35,150,25],"callback",...
               {@calcularEstabilidad,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonTodo = uicontrol (Coeficientes,"string","Analizar todo", ...
               "position",[300,35,150,25],"callback",...
               {@calcularTodo,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.2,.8,.2],"fontsize",16);
endfunction

function abrirMetodoDatos (handlesource,event)
  PantallaCPG = figure;
  set (PantallaCPG,"name","Función de transferencia: Ceros, polos y ganancia");
  set (PantallaCPG,"numbertitle","off");
  
  entornoCPG = uibuttongroup (PantallaCPG, "position", [ 0 0 1 1], ...
               "title","Indique los ceros, polos y ganancia y elija su opción", ...
               "titleposition","centertop");
               
  textCeros = uicontrol (entornoCPG,"style","text", ...
               "string","Ceros:","position",[40,320,80,40], ... 
               "fontsize",16);  
  ceros = uicontrol (entornoCPG, "style", "edit", ...
               "string", "1,1,3", "position",[150,320,200,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);        
               
  textPolos = uicontrol (entornoCPG,"style","text", ...
               "string","Polos:","position",[40,250,80,40], ... 
               "fontsize",16);  
  polos = uicontrol (entornoCPG, "style", "edit", ...
               "string", "3,4,5,6", "position",[150,250,200,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);  
               
  textGanancia = uicontrol (entornoCPG,"style","text", ...
               "string","Ganancia:","position",[40,180,100,40], ... 
               "fontsize",16);  
  ganancia = uicontrol (entornoCPG, "style", "edit", ...
               "string", "5", "position",[150,180,200,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);  
               
  botonExpresion = uicontrol (entornoCPG,"string","Expresión", ...
               "position",[390,350,150,30],"callback", ...
               {@calcularExpresion,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonPolos = uicontrol (entornoCPG,"string","Polos", ...
               "position",[390,300,150,30],"callback",...
               {@calcularPolos,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonCeros = uicontrol (entornoCPG,"string","Ceros", ...
               "position",[390,250,150,30],"callback",...
               {@calcularCeros,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonGanancia = uicontrol (entornoCPG,"string","Ganancia", ...
               "position",[390,200,150,30],"callback",...
               {@mostrarGanancia,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonExpresionCPG = uicontrol (entornoCPG,"string","Expresión C-P-G", ...
               "position",[390,150,150,30],"callback",...
               {@calcularExpresionCPG,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonGraficar = uicontrol (entornoCPG,"string","Graficar ceros y polos", ...
               "position",[390,100,150,30],"callback",...
               {@mostrarGrafico,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonEstabilidad = uicontrol (entornoCPG,"string","Indicar estabilidad", ...
               "position",[390,50,150,30],"callback",...
               {@calcularEstabilidad,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonTodo = uicontrol (entornoCPG,"string","Analizar todo", ...
               "position",[60,80,200,50],"callback",...
               {@calcularTodo,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.2,.8,.2],"fontsize",16);
endfunction

function funcionTransferencia = obtenerFT (nums1,nums2,ganancia) 
  if (ganancia == 0)
    funcionTransferencia = tf(nums1,nums2);
  else
    funcionTransferencia = zpk(nums1,nums2,ganancia);
  endif
endfunction
  
function array = stringAArray (str)
    charArray = strsplit(str,",");
    array = [];
    len = length (charArray);
    for i = 1:len
        array(i) = str2double (charArray{i});
    endfor
endfunction 

function ft = procesarFT (numBox,denBox,gainBox,hayGanancia)
  ganancia = 0;
  nums1 = stringAArray (get (numBox,"string"));  
  nums2 = stringAArray (get (denBox,"string"));
  if (hayGanancia)
    ganancia = str2double (get (gainBox,"string"));
    if (ganancia == 0)
      warndlg ("No puede tener una ganancia de 0","Error");
      return;
    endif
  endif
  ft = obtenerFT(nums1,nums2,ganancia);
endfunction
 
function calcularExpresion (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  helpdlg (evalc ("ft"),"Expresion de la funcion de transferencia"); 
endfunction

function calcularPolos (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  [z,p,g] = tf2zp(ft);
  helpdlg (evalc ("p"),"Polos");
endfunction

function calcularCeros (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  [z,p,g] = tf2zp(ft);
  helpdlg (evalc ("z"),"Ceros");
endfunction

function mostrarGanancia (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  [z,p,g] = tf2zp(ft);
  helpdlg (evalc ("g"),"Ganancia");
endfunction

function str = obtenerExpresionCPG (ft)
  [z,p,g] = tf2zp(ft);
  str = num2str (g);
  cantidadceros = length (z);
  cantidadpolos = length (p);
  for i = 1:cantidadceros 
    str = strcat(str, " [s - (",num2str (z(i)),")] ");
  endfor   
  str = strcat(str, "\n");
  
  str2 = "";
  for i = 1:cantidadpolos 
    str2 = strcat(str2, " [s - (",num2str (p(i)),")] ");
  endfor
  strlen = length (str2);
  for i = 1:strlen
    str = strcat(str, "-");
  endfor
  str = strcat(str, "\n");
  str = strcat(str, str2);
endfunction  
function calcularExpresionCPG (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  helpdlg (obtenerExpresionCPG(ft), "Expresion ceros, polos, ganancia");
endfunction

function mostrarGrafico (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  grafico = figure;
  set (grafico,"name","Grafico de ceros y polos");
  set (grafico,"numbertitle","off");
  pzmap (ft);
  title ("Ceros y polos");
  xlabel ("Eje real");
  ylabel ("Eje imaginario");
endfunction

function estable = estabilidad (polos)
  cantidad = length (polos);
  for i = 1:cantidad
    if (real (polos(i)) > 0)
      estable = "El sistema es inestable";
      return;
    endif
  endfor
  estable = "El sistema es estable";
endfunction

function calcularEstabilidad (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  [z,p,g] = tf2zp(ft);
  helpdlg (estabilidad (p),"Estabilidad");
endfunction

function calcularTodo (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  [z,p,g] = tf2zp(ft);
  mostrarGrafico(handlesource,event,numBox,denBox,gainBox,hayGanancia)
  helpdlg (strcat (evalc ("ft"),"\n",evalc ("z"),"\n",evalc ("p"), ...
  "\n",evalc ("g"),"\nExpresion CPG\n",obtenerExpresionCPG(ft),"\n\n",estabilidad (p)),"Todos los datos");
endfunction

init();
