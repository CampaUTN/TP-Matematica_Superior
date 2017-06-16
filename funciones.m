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
    [nums1,nums2] = cancelarRaices (nums1, nums2);
    if (ganancia == 0)
      warndlg ("La ganancia no puede ser igual a 0");
      return;
    else
      funcionTransferencia = zpk(nums1,nums2,ganancia,"OutputName","G(s)");
    endif
  
  else
    funcionTransferencia = tf(nums1,nums2,"OutputName","G(s)");

  endif
  
  return;
endfunction

function [array1,array2] = cancelarRaices (nums1, nums2)
  len1 = length(nums1);
  len2 = length(nums2);
  i = 1;
  j = 1;
  while (i != len1 + 1 )
      while (j != len2 + 1 )
              if (abs(nums1(i)-nums2(j)) < 1e4*eps(min(abs(nums1(i)),abs(nums2(j)))))
                    nums1(i) = [];
                    nums2(j) = [];
                    j=0;
                    i=1;
                    len1--;
                    len2--;
                    if( (len1 == 0)  || (len2 == 0))
                         array1 = nums1;
                         array2 = nums2;
                         return;
                    endif
              endif
          j++;
      endwhile
      i++;
      j=1;
  endwhile
  array1 = nums1;
  array2 = nums2;
endfunction

 
function calcularExpresion (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  stringExpresion = strcat("La expresion de la funcion de transferencia es \n",evalc ("funcionTransferencia"));
  h = msgbox (stringExpresion); 
endfunction

function calcularPolos (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [ceros,polos,ganancia] = tf2zp(funcionTransferencia);
  if (hayGanancia)
        nums1 = obtenerCoeficientesDe (get (coeficientesNumerador,"string"));  
        nums2 = obtenerCoeficientesDe (get (coeficientesDenominador,"string"));
        [nums1,nums2] = cancelarRaices (nums1, nums2);
        polos = nums2;
  else
        [ceros,polos] =  cancelarRaices (ceros, polos);
  endif
  stringPolos= strcat("Los polos son \n",evalc ("polos"));
  h = msgbox (stringPolos);
endfunction

function calcularCeros (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [ceros,polos,ganancia] = tf2zp(funcionTransferencia);
  if (hayGanancia)
        nums1 = obtenerCoeficientesDe (get (coeficientesNumerador,"string"));  
        nums2 = obtenerCoeficientesDe (get (coeficientesDenominador,"string"));
        [nums1,nums2] = cancelarRaices (nums1, nums2);
        ceros = nums1;
  else
        [ceros,polos] =  cancelarRaices (ceros, polos);
  endif
  stringCeros = strcat("Los ceros son \n",evalc ("ceros"));
  h = msgbox (stringCeros);
endfunction

function mostrarGanancia (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [ceros,polos,ganancia] = tf2zp(funcionTransferencia);
  stringGanancia = strcat("La ganancia del sistema es \n", evalc ("ganancia"));
  h = msgbox (stringGanancia);
endfunction

function str = expresionCerosPolosGanancia (funcionTransferencia, coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  [ceros,polos,ganancia] = tf2zp(funcionTransferencia);
    if (hayGanancia)
        nums1 = obtenerCoeficientesDe (get (coeficientesNumerador,"string"));  
        nums2 = obtenerCoeficientesDe (get (coeficientesDenominador,"string"));
        [nums1,nums2] = cancelarRaices (nums1, nums2);
        ceros = nums1;
        polos = nums2;
  else
        [ceros,polos] =  cancelarRaices (ceros, polos);
  endif
  cantidadDeCeros = length (ceros);
  cantidadDePolos = length (polos);
  
  str = num2str (ganancia);
  #Para obtener la expresion CPG voy concatenando polos y ceros 
  for i = 1:cantidadDeCeros 
    str = strcat(str, " (s - (",num2str (ceros(i)),")) ");
  endfor   
  str = strcat(str, "\n"); #Espacio
  
  str2 = "";
  
  for i = 1:cantidadDePolos 
    str2 = strcat(str2, "(s - (",num2str (polos(i)),")) ");
  endfor
  
  strlen = length (str2);
  for i = 1:strlen
    str = strcat(str, "-");
  endfor
  
  str = strcat(str, "\n");
  str = strcat(str, str2);
endfunction  

#CPG : ceros, polos, ganancia

function calcularExpresionCPG (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  stringExpresion = strcat("La expresion de ceros, polos y ganancia es \n",expresionCerosPolosGanancia(funcionTransferencia, coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia));
  h = msgbox (stringExpresion);
endfunction

function graficar (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  
  if(hayGanancia)
        grafico = figure;
        nums1 = obtenerCoeficientesDe (get (coeficientesNumerador,"string"));  
        nums2 = obtenerCoeficientesDe (get (coeficientesDenominador,"string"));
        [nums1,nums2] = cancelarRaices (nums1, nums2);
        ceros = nums1;
        polos = nums2;
        
        realCeros = real(ceros);
        imagCeros = imag(ceros);
        
        realPolos = real(polos);
        imagPolos = imag(polos);
        set (grafico,"name","Grafico de ceros y polos");
        set (grafico,"numbertitle","off");
        plot(realPolos,imagPolos,'x',realCeros,imagCeros,'o');
        grid on;
        title ("Ceros y polos");
        xlabel ("Eje real");
        ylabel ("Eje imaginario");
  else
        funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
        [ceros,polos,ganancia] = tf2zp(funcionTransferencia);
        [ceros,polos] =  cancelarRaices (ceros, polos);
        grafico = figure;
        realCeros = real(ceros);
        imagCeros = imag(ceros);
        
        realPolos = real(polos);
        imagPolos = imag(polos);
        set (grafico,"name","Grafico de ceros y polos");
        set (grafico,"numbertitle","off");
        plot(realPolos,imagPolos,'x',realCeros,imagCeros,'o');
        grid on;
        title ("Ceros y polos");
        xlabel ("Eje real");
        ylabel ("Eje imaginario");
  endif
endfunction

function estable = esEstable (polos)
  estable = "El sistema es estable";
  cantidad = length (polos);
  for i = 1:cantidad
    if(real(polos(i)) ==0)
      estable = "El sistema es marginalmente estable";
     endif
  endfor
  for i = 1:cantidad
    if (real(polos(i)) > 0)
      estable = "El sistema es inestable";
    endif
  endfor
  return;
endfunction


function calcularEstabilidad (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [ceros,polos,ganancia] = tf2zp(funcionTransferencia);
    if (hayGanancia)
        nums1 = obtenerCoeficientesDe (get (coeficientesNumerador,"string"));  
        nums2 = obtenerCoeficientesDe (get (coeficientesDenominador,"string"));
        [nums1,nums2] = cancelarRaices (nums1, nums2);
        polos = nums2;
  else
        [ceros,polos] =  cancelarRaices (ceros, polos);
  endif
  mensaje = esEstable(polos);
  h = msgbox(mensaje,"Estabilidad");
endfunction

function calcularTodo (handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia)
  funcionTransferencia = procesarFuncionTransferencia (coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
  [ceros,polos,ganancia] = tf2zp(funcionTransferencia);
    if (hayGanancia)
        nums1 = obtenerCoeficientesDe (get (coeficientesNumerador,"string"));  
        nums2 = obtenerCoeficientesDe (get (coeficientesDenominador,"string"));
        [nums1,nums2] = cancelarRaices (nums1, nums2);
        ceros = nums1;
        polos = nums2;
  else
        [ceros,polos] =  cancelarRaices (ceros, polos);
  endif
  stringExpresion = strcat("La expresion de la funcion de transferencia es \n",evalc ("funcionTransferencia"),...
  "\n\n", "La expresion de ceros, polos y ganancia es \n",expresionCerosPolosGanancia(funcionTransferencia, coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia),...
  "\n\n", esEstable(polos));
  h = msgbox (stringExpresion); 
  
  stringCeros = strcat("Los ceros son \n",evalc ("ceros"),"\n", "Los polos son \n",evalc ("polos"),"\n", "La ganancia del sistema es \n", evalc ("ganancia"));
  h = msgbox (stringCeros);
  
  graficar(handlesource,event,coeficientesNumerador,coeficientesDenominador,coeficienteGanancia,hayGanancia);
endfunction

function Limpiar 
  set(findobj(0,'style','edit'),'string','');
endfunction
function mostrarIntegrantes ()
    h = msgbox("Integrantes:\n\n    -Belogi, Santiago Tomas\n    -Blanco Bon, Juan Ignacio\n    -Campassi, Rodrigo\n    -Dominguez, Facundo Nicolas\n    -Nucera, Santiago\n\nMatematica Superior - Primer Cuatrimestre 2017","Integrantes");
     endfunction    
