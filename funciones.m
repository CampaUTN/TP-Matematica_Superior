pkg load control;
pkg load signal;

function funcionTransferencia = obtenerFuncionTransferencia (nums1,nums2,ganancia) 
  if (ganancia == 0)
    funcionTransferencia = tf(nums1,nums2,"OutputName","G(s)");
  else
    funcionTransferencia = zpk(nums1,nums2,ganancia,"OutputName","G(s)");
  endif
endfunction
  
function coeficientes = obtenerCoeficientesDe(textBox)
    coeficientes = [];
    coeficientesStr = strsplit(textBox,",");
    cantCoeficientes = length (coeficientesStr);
    for i = 1:cantCoeficientes
        coeficientes(i) = str2double (coeficientesStr{i});
    endfor
endfunction 

function funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  ganancia = 0;
  nums1 = obtenerCoeficientesDe (get (coeficientesNumerador,"string"));  
  nums2 = obtenerCoeficientesDe (get (coeficientesDenominador,"string"));
  if (hayGanancia)
    ganancia = str2double (get (coeficienteGanancia,"string"));
    if (ganancia == 0)
      warndlg ("No puede tener una ganancia de 0","Error");
      return;
    endif
  endif
  funcionTransferencia = obtenerFuncionTransferencia(nums1,nums2,ganancia);
endfunction
 
function calcularExpresion (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  helpdlg (evalc ("funcionTransferencia"),"Expresion de la funcion de transferencia"); 
endfunction

function calcularPolos (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  helpdlg (evalc ("p"),"Polos");
endfunction

function calcularCeros (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  helpdlg (evalc ("z"),"Ceros");
endfunction

function mostrarGanancia (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  helpdlg (evalc ("g"),"Ganancia");
endfunction

function str = obtenerExpresionCPG (funcionTransferencia)
  [z,p,g] = tf2zp(funcionTransferencia);
  str = num2str (g);
  cantidadCeros = length (z);
  cantidadPolos = length (p);
  for i = 1:cantidadCeros 
    str = strcat(str, " (s - (",num2str (z(i)),")) ");
  endfor   
  str = strcat(str, "\n");
  
  str2 = "";
  for i = 1:cantidadPolos 
    str2 = strcat(str2, "(s - (",num2str (p(i)),")) ");
  endfor
  strlen = length (str2);
  for i = 1:strlen
    str = strcat(str, "-");
  endfor
  str = strcat(str, "\n");
  str = strcat(str, str2);
endfunction  
function calcularExpresionCPG (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  helpdlg (obtenerExpresionCPG(funcionTransferencia), "Expresion ceros, polos, ganancia");
endfunction

function graficar (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
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

function calcularEstabilidad (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  mensaje = esEstable(p);
  h = msgbox(mensaje,"Estabilidad");
endfunction

function calcularTodo (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  graficar(handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  helpdlg (strcat (evalc ("funcionTransferencia"),"\n",evalc ("z"),"\n",evalc ("p"), ...
  "\n",evalc ("g"),"\nExpresion CPG\n",obtenerExpresionCPG(funcionTransferencia),"\n\n",esEstable (p)),"Todos los datos");
endfunction

function Limpiar (PantallaCPG)
  set(findobj(0,'style','edit'),'string','');
endfunction
