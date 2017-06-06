pkg load control;
pkg load signal;

function abrirPantallaInicio()
  InicioView = figure;
  set (InicioView,"name","Trabajo Practico Matematica Superior");
  set (InicioView,"numbertitle","off");
  set (InicioView,"color","white");
  set (InicioView,"menubar","none");

  entornoPrincipal = uibuttongroup (InicioView, "position", [ 0 0 1 1]);
   
  botonCoeficientes = uicontrol (entornoPrincipal,"string","Coeficientes", ...
                 "position",[125,250,300,100],"callback",{@abrirVentanaCoeficientes}, ...
                 "backgroundcolor",[.8,.8,.8],"fontsize",13);
  botonPCG = uicontrol (entornoPrincipal,"string","Ceros, polos y ganancia", ...
                 "position",[125,100,300,100],"callback",{@abrirVentanaCPG}, ...
                 "backgroundcolor",[.8,.8,.8],"fontsize",13);
endfunction

function abrirVentanaCoeficientes (handlesource,event)
  ventanaCoeficientes = figure;
  set (ventanaCoeficientes,"name","Función de transferencia: Coeficientes");
  set (ventanaCoeficientes,"numbertitle","off");
  
  entornoCoeficientes = uibuttongroup (ventanaCoeficientes, "position", [ 0 0 1 1], ...
               "title","Establezca los coeficientes y elija su opción","titleposition","centertop");
               
  textoCoeficientesNumerador = uicontrol (entornoCoeficientes,"style","text", ...
               "string","Coeficientes del numerador:","position",[10,350,300,40], ... 
               "fontsize",16);  
  coeficientesNumerador = uicontrol (entornoCoeficientes, "style", "edit", ...
               "string", "2,7,4", "position",[20,310,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);              
               
  textoCoeficientesDenominador = uicontrol (entornoCoeficientes,"style","text", ...
               "string","Coeficientes del denominador:","position",[10,250,300,40], ... 
               "fontsize",16);  
  coeficientesDenominador = uicontrol (entornoCoeficientes, "style", "edit", ...
               "string", "6,1,9,3", "position",[20,210,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);
               
  botonExpresion = uicontrol (entornoCoeficientes,"string","Expresión", ...
               "position",[390,350,150,30],"callback", ...
               {@mostrarExpresion,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonPolos = uicontrol (entornoCoeficientes,"string","Polos", ...
               "position",[390,300,150,30],"callback",...
               {@mostrarPolos,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonCeros = uicontrol (entornoCoeficientes,"string","Ceros", ...
               "position",[390,250,150,30],"callback",...
               {@mostrarCeros,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonGanancia = uicontrol (entornoCoeficientes,"string","Ganancia", ...
               "position",[390,200,150,30],"callback",...
               {@mostrarGanancia,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonExpresionCPG = uicontrol (entornoCoeficientes,"string","Expresión C-P-G", ...
               "position",[390,150,150,30],"callback",...
               {@mostrarExpresionCPG,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonGraficar = uicontrol (entornoCoeficientes,"string","Graficar ceros y polos", ...
               "position",[390,100,150,30],"callback",...
               {@mostrarGrafico,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonEstabilidad = uicontrol (entornoCoeficientes,"string","Indicar estabilidad", ...
               "position",[390,50,150,30],"callback",...
               {@mostrarEstabilidad,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonTodo = uicontrol (entornoCoeficientes,"string","Analizar todo", ...
               "position",[60,80,200,50],"callback",...
               {@mostrarTodo,coeficientesNumerador,coeficientesDenominador,0,false}, ...
               "backgroundcolor",[.2,.8,.2],"fontsize",16);
endfunction

function abrirVentanaCPG (handlesource,event)
  ventanaCPG = figure;
  set (ventanaCPG,"name","Función de transferencia: Ceros, polos y ganancia");
  set (ventanaCPG,"numbertitle","off");
  
  entornoCPG = uibuttongroup (ventanaCPG, "position", [ 0 0 1 1], ...
               "title","Establezca los ceros, polos y ganancia y elija su opción", ...
               "titleposition","centertop");
               
  textoCeros = uicontrol (entornoCPG,"style","text", ...
               "string","Ceros:","position",[40,320,80,40], ... 
               "fontsize",16);  
  ceros = uicontrol (entornoCPG, "style", "edit", ...
               "string", "1,1,3", "position",[150,320,200,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);        
               
  textoPolos = uicontrol (entornoCPG,"style","text", ...
               "string","Polos:","position",[40,250,80,40], ... 
               "fontsize",16);  
  polos = uicontrol (entornoCPG, "style", "edit", ...
               "string", "3,4,5,6", "position",[150,250,200,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);  
               
  textoGanancia = uicontrol (entornoCPG,"style","text", ...
               "string","Ganancia:","position",[40,180,100,40], ... 
               "fontsize",16);  
  ganancia = uicontrol (entornoCPG, "style", "edit", ...
               "string", "5", "position",[150,180,200,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);  
               
  botonExpresion = uicontrol (entornoCPG,"string","Expresión", ...
               "position",[390,350,150,30],"callback", ...
               {@mostrarExpresion,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonPolos = uicontrol (entornoCPG,"string","Polos", ...
               "position",[390,300,150,30],"callback",...
               {@mostrarPolos,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonCeros = uicontrol (entornoCPG,"string","Ceros", ...
               "position",[390,250,150,30],"callback",...
               {@mostrarCeros,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonGanancia = uicontrol (entornoCPG,"string","Ganancia", ...
               "position",[390,200,150,30],"callback",...
               {@mostrarGanancia,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonExpresionCPG = uicontrol (entornoCPG,"string","Expresión C-P-G", ...
               "position",[390,150,150,30],"callback",...
               {@mostrarExpresionCPG,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonGraficar = uicontrol (entornoCPG,"string","Graficar ceros y polos", ...
               "position",[390,100,150,30],"callback",...
               {@mostrarGrafico,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonEstabilidad = uicontrol (entornoCPG,"string","Indicar estabilidad", ...
               "position",[390,50,150,30],"callback",...
               {@mostrarEstabilidad,ceros,polos,ganancia,true}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonTodo = uicontrol (entornoCPG,"string","Analizar todo", ...
               "position",[60,80,200,50],"callback",...
               {@mostrarTodo,ceros,polos,ganancia,true}, ...
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
 
function mostrarExpresion (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  helpdlg (evalc ("ft"),"Expresion de la funcion de transferencia"); 
endfunction

function mostrarPolos (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  [z,p,g] = tf2zp(ft);
  helpdlg (evalc ("p"),"Polos");
endfunction

function mostrarCeros (handlesource,event,numBox,denBox,gainBox,hayGanancia)
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
function mostrarExpresionCPG (handlesource,event,numBox,denBox,gainBox,hayGanancia)
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

function mostrarEstabilidad (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  [z,p,g] = tf2zp(ft);
  helpdlg (estabilidad (p),"Estabilidad");
endfunction

function mostrarTodo (handlesource,event,numBox,denBox,gainBox,hayGanancia)
  ft = procesarFT (numBox,denBox,gainBox,hayGanancia);
  [z,p,g] = tf2zp(ft);
  mostrarGrafico(handlesource,event,numBox,denBox,gainBox,hayGanancia)
  helpdlg (strcat (evalc ("ft"),"\n",evalc ("z"),"\n",evalc ("p"), ...
  "\n",evalc ("g"),"\nExpresion CPG\n",obtenerExpresionCPG(ft),"\n\n",estabilidad (p)),"Todos los datos");
endfunction

abrirPantallaInicio();