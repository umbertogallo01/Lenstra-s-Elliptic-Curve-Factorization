function test = test_Miller_Rabin(n, iter)
    % Test di primalità di Miller-Rabin sul numero intero n e con massimo numero di iterazioni pari a iter.
    % Il test restituisce false=0 quando il numero inserito non è sicuramente
    % primo e restituisce true=1 se il numero inserito ha probabilità di
    % esserlo

    % N.B. Per questo test ci sono almeno i 3/4 degli elementi in
    % (Z/(n))* che ci permettono di scoprire che n non è primo.


    % Verifichiamo che n sia intero e positivo
    if(n ~= floor(n) || n <= 0)
        test = false;
        error('Il valore di n deve essere intero e positivo.');
        return;
    end

    % Escludiamo i casi banali n = 2, n pari ed n = 1
    if(n == 2)
        test = true;
        return;
    elseif(mod(n, 2) == 0 || n == 1)
        test = false;
        return;
    end

    % Inizializziamo test al valore true: non appena rileviamo che il test
    % di Fermat NON è soddisfatto, cambiamo il suo valore a false
    test = true;

    for i = 1:iter
        a = randi([2 (n -1)]);
        if(MCD(a, n) > 1)
            % se il massimo comun divisore fra a ed n è > 1, esso è un
            % divisore proprio di n -> n non è primo.
            test = false;
            return;
        end

        % Arrivati qui sappiamo che a è un invertibile di Z/n. Inoltre, n è
        % dispari -> n - 1 = 2^k * d, con d dispari. Calcoliamo i valori di 
        % k=#numero di elementi della successione di M-R (con divisioni 
        % successive) e d=divisore dispari di n-1.

        bin=dec2bin(n-1);
        for j=1:length(bin)
            % cerco l'ultimo 1 dello sviluppo binario e il #zeri in fondo
            % corrisponde a k
            if bin(j)=='1'
                indice=j;
            end
        end
        k=length(bin)-indice;
        d = bin2dec(bin(1:indice));

        % Verifichiamo se a^d = 1 mod n: se tale relazione non è soddisfatta,
        % procediamo con il calcolo della successione di M-R
        
        x_0=potenza_mod(a,d,n); % calcolo primo elemento della successione
        if(x_0 ~= mod(1, n))
            x_old = x_0;
            x_new = potenza_mod(x_old, 2, n);
            j = 0;
            flag = false; % Variabile flag per il ciclo while
            while(j <= k - 1)
                if(mod(x_new, n) == mod(1, n))
                    % Se trovo un termine della successione pari a 1,
                    % allora fermo il ciclo e vado a guardare il termine
                    % della successione precedente. Se trovo -1, allora il
                    % test è fallito e devo cambiare a. Se invece non
                    % troviamo -1, allora concludiamo che n NON è primo
                    flag = true;
                    break;
                end
                x_old = x_new;
                x_new = potenza_mod(x_old, 2, n);
                j = j + 1;
            end
            
            if(flag == true)
                % Se arriviamo qui, vuol dire che abbiamo trovato un 1 e
                % dobbiamo controllare il termine della successione
                % precedente
                if x_old~=mod(-1,n)
                    test = false;
                    return;
                end  
            else
                % se siao entrati qui vuol dire che non abbiamo mai trovato
                % 1, dunque il test di M-R è fallito, perché in realtà è
                % fallito Fermat --> dunque n NON è primo
                test=false;
                return
            end
        end
    end