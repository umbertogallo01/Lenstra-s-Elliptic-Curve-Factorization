function [Q, flag] = raddoppia(P, n, a)
    % Funzione che prende in input un punto P mod n sulla una curva 
    % ellittica di parametro a e che restituisce 2 * P mod n.
    
    xP = P(1);
    yP = P(2);

    d = MCD(yP, n); % calcolo questo perché è il termine che sta al 
    % denominatore nelle formule
    flag = 0;

    if d == n
        flag = 1; % bisogna cambiare a nell'algoritmo di Lenstra.
        Q = 0; % Punto all'infinito

    elseif d ~= 1 && d ~= n
        disp(['Ho trovato un divisore d = ', num2str(d)]);
        flag = 2; %bisogna uscire da tutto
        Q = 0; % Punto all'infinito

    else 
        % 2 * yP è invertibile.
        i = inverso(2 * yP, n);
        
        % Calcolo le coordinate di Q = 2 * P mod n con la formula del
        % raddoppio
        xQ = (i^2) * ((3 * (xP^2) + a)^2) - 2 * xP;
        xQ = mod(xQ, n);
        yQ = -yP - (3 * (xP^2) + a)*((i^3)*(3 * (xP^2) + a)^2 - i*3*xP);
        yQ = mod(yQ, n);
        Q = [xQ, yQ];
    end
end

