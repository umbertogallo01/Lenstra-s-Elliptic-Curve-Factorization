function [T, flag] = somma(P, Q, n, a)
    % Presi in input due punti P e Q e due interi n ed a, 
    % la funzione calcola la somma P + Q mod n come punto della curva 
    % ellittica di parametro a modulo n.
    
    if P == Q
        % Richiamo raddoppia
        [T, flag] = raddoppia(P, n, a);
    else
        % Estraggo le coordinate
        xP = P(1);
        xQ = Q(1);
        yP = P(2);
        yQ = Q(2);

        % Calcolo del MCD fra il denominatore xQ - xP ed n.
        d = MCD(xQ - xP, n);
        flag = 0;

      if d == n
          % Se flag è 1, bisogna cambiare a nell'algoritmo di Lenstra.
          flag = 1;
          T = 0; % Punto all'infinito

      elseif d ~= 1 && d ~= n
          disp(['Ho trovato un divisore d = ', num2str(d)]);
          flag = 2; %bisogna uscire da tutto
          T = 0; % Punto all'infinito
      else 
          % xQ - xP è invertibile
          % Calcolo l'inverso di xQ - xP
          i = inverso(xQ - xP, n);
          
          % Calcolo le coordinate di P+Q con la formula della somma
          xT = xP + ( i*(a + 3*(xP^2) ) - (i^2)*2*yP*(yQ-yP) );
          xT = mod(xT, n);
          yT = -yP - ( (i^2)*(a + 3*(xP^2)) - (i^3)*2*yP*(yQ-yP) )*(yQ-yP);
          yT = mod(yT, n);
          T = [xT, yT];
      end
    end
  