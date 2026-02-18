function [Q, flag] = calcola_kP(T, k, n, a)
    % Presi in input un punto T e tre interi k, n ed a, la funzione calcola 
    % k * P mod n come punto sulla curva ellittica di parametro a modulo n.
    
    % Definisco Q come (0,0) per iniziare il calcolo kP
    Q=[0,0]; 

    % scrivo k in binario con la funzione dec2bin che però mi da un char
    % come output
    bin = dec2bin(k);

    for i = length(bin) : -1 : 1 
        if bin(i) == '1'
            [Q, flag]=somma(Q, T, n, a);
            if flag == 2
                % In questo caso somma ha trovato e stampato un divisore, 
                % quindi resituisco al main flag=2 per terminare tutto
                return;
            end
            if flag == 1
                % flag = 1 vuol dire che il denominatore delle somme 
                % divide n, quindi bisogna cambiare a e ricominciare
                return;
            end
        end

        % Raddoppio T
        [T, flag] = raddoppia(T, n, a);
        if flag == 2
            % In questo caso raddoppia ha un trovato e stampato un 
            % divisore, quindi restituisco al main flag=2 per terminare
            % tutto
            return
        end
        if flag == 1
             % se flag = 1, allora MCD(yP, n) = n, quindi bisogna
             % cambiare a.
             return
        end
    end