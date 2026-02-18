function potenza = potenza_mod(x, k, n)
    % Funzione che, presi in input tre interi x, k, n, calcola x^k mod n.
    
    % Verifichiamo se k è un intero non-negativo. In caso contrario,
    % interrompiamo l'esecuzione.
    if(k ~= floor(k) || k < 0)
        error('La potenza deve essere un numero intero non-negativo.')
        return;
    end

    % Verifichiamo se x è un numero intero. In caso contrario,
    % interrompiamo l'esecuzione.
    if(x ~= floor(x))
        error('La base della potenza deve essere un numero intero.')
    end

    % Infine, verifichiamo che n sia un numero intero positivo.
    if(n ~= floor(n) || n <= 0)
        error('Il numero rispetto cui si sta calcolando la classe di resto deve essere intero e positivo.');
        return;
    end

    % Calcoliamo l'espressione binaria di k come stringa di 0 e 1.
    % Attenzione: l'output è di tipo char.
    bin = dec2bin(k);

    % Attenzione: l'output è un vettore char. Inoltre, bin(1) si
    % riferisce alla potenza di ordine più alto, mentre bin(length(bin)) a
    % quella di ordine più basso.

    % Scorriamo in senso DECRESCENTE il vettore bin (ci serve partire dalla
    % potenza 0-esima, ndr) e calcoliamo le potenze di x^(2^(i - 1)) mod n
    % iterativamente. Se bin(i) == '1', calcoliamo potenza = potenza *
    % x^(2^(i - 1)) mod n iterativamente.
    
    potenza = 1;
    m = x; % Variabile di appoggio per il calcolo delle potenze x^(2^(i-1))

    for i = length(bin):-1:1
        % Attenzione: all'indice i-esimo è associata la potenza 2^(i-1)-esima
        % di x poiché quella di ordine più basso è x^(2^0) = x.
        if(bin(i) == '1')
            potenza = mod(potenza * m, n);
        end
        m = mod(m^2, n);
    end
end


    

    

