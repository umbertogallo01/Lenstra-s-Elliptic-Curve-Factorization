function test = test_Solovay_Strassen(n, iter)
    % Test di primalità di Solovay-Strassen sul numero n e con massimo numero di iterazioni pari a iter.
    % Il test restituisce false=0 quando il numero inserito non è sicuramente
    % primo e restituisce true=1 se il numero inserito ha probabilità di
    % esserlo
    
    % N.B. Per questo test ci sono almeno la metà degli elementi in
    % (Z/(n))* che ci permettono di scoprire che n non è primo.
    
    % L'input dell'utente deve essere intero e positivo
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
        % N.B. il simbolo di Jacobi (x/n)_J è ben definito se e solo se
        % il denominatore n è DISPARI. Quindi il controllo mod(n, 2) == 0
        % serve anche ad avere la buona posizione di tale oggetto.
        test = false;
        return;
    end

    % Inizializziamo test al valore true: non appena rileviamo che il test
    % di Fermat NON è soddisfatto, cambiamo il suo valore a false
    test = true;
    
    for i = 1:iter
        x = randi([2 (n -1)]);
        d = MCD(x, n);
        if(d > 1)
            % se il massimo comun divisore fra x ed n è d > 1, esso è un
            % divisore proprio di n -> n non è primo.
            test = false;
            return;
        end

        % Dobbiamo verificare se è soddisfatta l'identità di Eulero x^((n
        % -1) / 2) = (x/n)_J mod n. In caso non fosse soddisfatta, n NON
        % può essere primo.
        % N.B. facciamo prima il test di Eulero che consiste nel calcolare
        % x^((n-1)/2) e verifichiamo che questo sia uguale a +/-1. Se non
        % lo è allora sicuramente n NON è primo. Se lo è allora calcoliamo
        % anche il simbolo di Jacobi

        pot=potenza_mod(x, (n - 1) / 2, n);
        if pot~=mod(1,n) && pot~=mod(-1,n)
            test=false;
            return
        end
        % Se arriviamo qui, n supera il test di Eulero in base x.

        if(pot ~= mod(simbolo_Jacobi(x, n, 1), n))
            test = false;
            return;
        end

        % Se arriviamo qui, n supera il test di Solovay-Strassen in base x.
    end



