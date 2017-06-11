pkg load signal;
pkg load control;

function init()
  Inicio = figure;
  set (Inicio,"menubar","none");
  set (Inicio,"name","Trabajo Practico - Matematica Superior");
  set (Inicio,"numbertitle","off");
  set (Inicio,"color","white");

  pantalla = uibuttongroup (Inicio, "position", [ 0 0 1 1],...
        "title","Menu","titleposition","centertop");
  
  tituloPrincipal = uicontrol (Inicio,"style","text", ...
        "string","Seleccione datos a ingresar:","position",[85,300,400,50], ... 
        "fontsize",20); 
  
  calculoConCoeficientes = uicontrol (pantalla,"string","Coeficientes", ...
        "position",[50,150,200,100],"callback",{@abrirMetodoCoeficientes}, ...
        "backgroundcolor",[.8,.8,.8],"fontsize",13);
  
  calculoConDatosCPG = uicontrol (pantalla,"string","Ceros, polos y ganancia", ...
        "position",[300,150,200,100],"callback",{@abrirMetodoDatos}, ...
        "backgroundcolor",[.8, .8, .8  ],"fontsize",13);
       
endfunction

function abrirMetodoCoeficientes (handlesource,event)
  PantallaCoeficientes = figure;
  set (PantallaCoeficientes,"name","Funcion de transferencia: Coeficientes");
  set (PantallaCoeficientes,"numbertitle","off");
  set (PantallaCoeficientes,"menubar","none");
  
  Coeficientes = uibuttongroup (PantallaCoeficientes, "position", [ 0 0 1 6], ...
        "title","Establezca los coeficientes y elija su opcion","titleposition","centertop");
               
  textCoeficientesCeros = uicontrol (Coeficientes,"style","text", ...
       "string","Coeficientes del numerador:","position",[5,350,250,40], ... 
       "fontsize",12);  
               
  coeficientesCeros = uicontrol (Coeficientes, "style", "edit", ...
       "string", "5", "position",[250,350,250,40], ...
       "fontsize",14,"backgroundcolor","white");            
             
  separador = uicontrol (Coeficientes,"style","text", ...
       "string","________________________________","position",[250,315,250,40], ... 
       "fontsize",12);          
                      
  textCoeficientesPolos = uicontrol (Coeficientes,"style","text", ...
       "string","Coeficientes del denominador:","position",[5,270,250,40], ... 
       "fontsize",12);  
  
  coeficientesPolos = uicontrol (Coeficientes, "style", "edit", ...
        "string", "3,8,12,4", "position",[250,270,250,40], ...
        "fontsize",14,"backgroundcolor","white");
               
  botonExpresion = uicontrol (Coeficientes,"string","Expresion", ...
        "position",[10,170,150,35],"callback", ...
        {@calcularExpresion,coeficientesCeros,coeficientesPolos,0,false}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonPolos = uicontrol (Coeficientes,"string","Polos", ...
        "position",[200,170,150,35],"callback",...
        {@calcularPolos,coeficientesCeros,coeficientesPolos,0,false}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonCeros = uicontrol (Coeficientes,"string","Ceros", ...
        "position",[390,170,150,35],"callback",...
        {@calcularCeros,coeficientesCeros,coeficientesPolos,0,false}, ... 
        "backgroundcolor",[.8,.8,.8]);
  
  botonGanancia = uicontrol (Coeficientes,"string","Ganancia", ...
        "position",[10,110,150,35],"callback",... 
        {@mostrarGanancia,coeficientesCeros,coeficientesPolos,0,false}, ... 
        "backgroundcolor",[.8,.8,.8]);
  
  botonExpresionCPG = uicontrol (Coeficientes,"string","Expresion CPG", ...
        "position",[200,110,150,35],"callback",...
        {@calcularExpresionCPG,coeficientesCeros,coeficientesPolos,0,false}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonGraficar = uicontrol (Coeficientes,"string","Graficar ceros y polos", ...
        "position",[390,110,150,35],"callback",...
        {@graficar,coeficientesCeros,coeficientesPolos,0,false}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonEstabilidad = uicontrol (Coeficientes,"string","Indicar estabilidad", ...
        "position",[200,50,150,35],"callback",...
        {@calcularEstabilidad,coeficientesCeros,coeficientesPolos,0,false}, ...
        "backgroundcolor",[.8,.8,.8]);
      
  botonTodo = uicontrol (Coeficientes,"string","Analizar todo", ...
        "position",[123,0,300,40],"callback",...
        {@calcularTodo,coeficientesCeros,coeficientesPolos,0,false}, ...
        "backgroundcolor",[.2,.8,.2],"fontsize",16);

  botonLimpiar = uicontrol (Coeficientes, "string", "Limpiar",...
        "position", [250,225,150,40], ... 
        "backgroundcolor",[.8,.2,.2]);

endfunction

function abrirMetodoDatos (handlesource,event)
  PantallaCPG = figure;
  set (PantallaCPG,"name","Funcion de transferencia: Ceros, polos y ganancia");
  set (PantallaCPG,"numbertitle","off");
  set (PantallaCPG,"menubar","none");
  
  entornoCPG = uibuttongroup (PantallaCPG, "position", [ 0 0 1 1], ...
        "title","Indique los ceros, polos y ganancia y elija su opcion", ...
        "titleposition","centertop");
               
  textCeros = uicontrol (entornoCPG,"style","text", ...
        "string","Ceros","position",[50,320,80,40], ... 
        "fontsize",16);  
  
  ceros = uicontrol (entornoCPG, "style", "edit", ...
        "string", "1,1,3", "position",[15,280,150,40], ...
        "fontsize",12,"backgroundcolor","white");        
               
  textPolos = uicontrol (entornoCPG,"style","text", ...
        "string","Polos","position",[230,320,80,40], ... 
        "fontsize",16);  
  
  polos = uicontrol (entornoCPG, "style", "edit", ...
        "string", "3,4,5,6", "position",[200,280,150,40], ...
        "fontsize",12,"backgroundcolor","white");  
               
  textGanancia = uicontrol (entornoCPG,"style","text", ...
        "string","Ganancia","position",[400,320,100,40], ... 
        "fontsize",16);  
  
  ganancia = uicontrol (entornoCPG, "style", "edit", ...
        "string", "5", "position",[380,280,150,40], ...
        "fontsize",12,"backgroundcolor","white");  
               
  botonExpresion = uicontrol (entornoCPG,"string","Expresion", ...
        "position",[10,190,150,35],"callback", ...
        {@calcularExpresion,ceros,polos,ganancia,true}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonPolos = uicontrol (entornoCPG,"string","Polos", ...
        "position",[200,190,150,35],"callback",...
        {@calcularPolos,ceros,polos,ganancia,true}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonCeros = uicontrol (entornoCPG,"string","Ceros", ...
        "position",[390,190,150,35],"callback",...
        {@calcularCeros,ceros,polos,ganancia,true}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonGanancia = uicontrol (entornoCPG,"string","Ganancia", ...
        "position",[10,130,150,35],"callback",...
        {@mostrarGanancia,ceros,polos,ganancia,true}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonExpresionCPG = uicontrol (entornoCPG,"string","Expresion C-P-G", ...
        "position",[200,130,150,35],"callback",...
        {@calcularExpresionCPG,ceros,polos,ganancia,true}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonGraficar = uicontrol (entornoCPG,"string","Graficar ceros y polos", ...
        "position",[390,130,150,35],"callback",...
        {@mostrarGrafico,ceros,polos,ganancia,true}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonEstabilidad = uicontrol (entornoCPG,"string","Indicar estabilidad", ...
        "position",[200,70,150,35],"callback",...
        {@calcularEstabilidad,ceros,polos,ganancia,true}, ...
        "backgroundcolor",[.8,.8,.8]);
  
  botonTodo = uicontrol (entornoCPG,"string","Analizar todo", ...
        "position",[123,5,300,40],"callback",...
        {@calcularTodo,ceros,polos,ganancia,true}, ...
        "backgroundcolor",[.2,.8,.2],"fontsize",16);
  
  botonLimpiar = uicontrol (entornoCPG, "string", "Limpiar",...
        "position", [200,235,150,40], ...
        "backgroundcolor",[.8,.2,.2]);
endfunction

function funcionTransferencia = obtenerFuncionTransferencia (nums1,nums2,coeficienteGanancia) 
  if (coeficienteGanancia == 0)
    funcionTransferencia = tf(nums1,nums2);
  else
    funcionTransferencia = zpk(nums1,nums2,coeficienteGanancia);
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

function funcionTransferencia = procesarFuncionTransferencia (coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  coeficienteGanancia = 0;
  nums1 = stringAArray (get (coeficientesCeros,"string"));  
  nums2 = stringAArray (get (coeficientesPolos,"string"));
  if (hayGanancia)
    coeficienteGanancia = str2double (get (coeficienteGanancia,"string"));
    if (coeficienteGanancia == 0)
      warndlg ("No puede tener una ganancia de 0","Error");
      return;
    endif
  endif
  funcionTransferencia = obtenerFuncionTransferencia(nums1,nums2,coeficienteGanancia);
endfunction
 
function calcularExpresion (handlesource,event,coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia);
  helpdlg (evalc ("funcionTransferencia"),"Expresion de la funcion de transferencia"); 
endfunction

function calcularPolos (handlesource,event,coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  helpdlg (evalc ("p"),"Polos");
endfunction

function calcularCeros (handlesource,event,coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  helpdlg (evalc ("z"),"Ceros");  
endfunction

function mostrarGanancia (handlesource,event,coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  helpdlg (evalc ("g"),"Ganancia");
endfunction

function str = obtenerExpresionCPG (funcionTransferencia)
  [z,p,g] = tf2zp(funcionTransferencia);
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

function calcularExpresionCPG (handlesource,event,coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia);
  helpdlg (obtenerExpresionCPG(funcionTransferencia), "Expresion ceros, polos, ganancia");
endfunction

function graficar (handlesource,event,coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia);
  grafico = figure;
  set (grafico,"name","Grafico de ceros y polos");
  set (grafico,"numbertitle","off");
  pzmap (funcionTransferencia);
  title ("Ceros y polos");
  xlabel ("Eje real");
  ylabel ("Eje imaginario");
endfunction

function estable = esEstable (polos)
  cantidad = length (polos);
  for i = 1:cantidad
    if (real (polos(i)) > 0)
      estable = "El sistema es inestable";
      return;
    endif
  endfor
  estable = "El sistema es estable";
endfunction

function calcularEstabilidad (handlesource,event,coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  helpdlg (esEstable (p),"Estabilidad");
endfunction

function calcularTodo (handlesource,event,coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  graficar(handlesource,event,coeficientesCeros,coeficientesPolos,coeficienteGanancia,hayGanancia)
  helpdlg (strcat (evalc ("funcionTransferencia"),"\n",evalc ("z"),"\n",evalc ("p"), ...
  "\n",evalc ("g"),"\nExpresion CPG\n",obtenerExpresionCPG(funcionTransferencia),"\n\n",estabilidad (p)),"Todos los datos");
endfunction

init();
 
