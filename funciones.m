pkg load control;
pkg load signal;

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
      warndlg ("La ganancia no puede ser igual a 0");
      return;
    else
      funcionTransferencia = zpk(nums1,nums2,ganancia,"OutputName","G(s)");
    endif
  
  else
    funcionTransferencia = tf(nums1,nums2,"OutputName","G(s)");
  endif
  
  return funcionTransferencia;
endfunction
 
function calcularExpresion (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  stringExpresion = strcat("La expresion de la funcion de transferencia es ",evalc ("funcionTransferencia"));
  h = msgbox (stringExpresion); 
endfunction

function calcularPolos (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  stringPolos= strcat("Los polos son ",evalc ("p"));
  h = msgbox (stringPolos);
endfunction

function calcularCeros (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  stringCeros = strcat("Los ceros son ",evalc ("z"));
  h = msgbox (stringCeros);
endfunction

function mostrarGanancia (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [z,p,g] = tf2zp(funcionTransferencia);
  stringGanancia = strcat("La ganancia del sistema es ", evalc ("g"));
  h = msgbox (stringGanancia);
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
  stringExpresion = strcat("La expresion de ceros, polos y ganancia es \n",obtenerExpresionCPG(funcionTransferencia));
  h = msgbox (stringExpresion);
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
  estable = "El sistema es estable";
  cantidad = length (polos);
  for i = 1:cantidad
    if (real (polos(i)) > 0)
      return estable = "El sistema es inestable";
    endif
    if(real(polos(i)) ==0){
      estable = "El sistema es marginalmente estable"
     endif
  endfor
  return estable
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
  
  stringExpresion = strcat("La expresion de la funcion de transferencia es ",evalc ("funcionTransferencia"));
  h = msgbox (stringExpresion); 
  
  stringCeros = strcat("Los ceros son ",evalc ("z"));
  h = msgbox (stringCeros);
  
  stringPolos= strcat("Los polos son ",evalc ("p"));
  h = msgbox (stringPolos);
  
  stringGanancia = strcat("La ganancia del sistema es ", evalc ("g"));
  h = msgbox (stringGanancia);
  
  stringExpresion = strcat("La expresion de ceros, polos y ganancia es \n",obtenerExpresionCPG(funcionTransferencia));
  h = msgbox (stringExpresion);
  
  h = msgbox(mensaje,"Estabilidad");
  
  graficar(handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
endfunction

function Limpiar (PantallaCPG)
  set(findobj(0,'style','edit'),'string','');
endfunction
