function test = test_Fermat(n, iter)
    % Test di primalità di Fermat sul numero n e con massimo numero di iterazioni pari a iter.
    % Il test restituisce false=0 quando il numero inserito non è sicuramente
    % primo e restituisce true=1 se il numero inserito ha probabilità di
    % esserlo
    
    % L'input dell'utente deve essere intero e positivo
    if(n ~= floor(n) || n <= 0)
        test = false;
        error('Il valore di n deve essere intero e positivo.');
        return;
    end

    % Escludiamo i casi banali n = 2, n pari ed n = 1
    if (n == 2)
        test = true;
        return;
    elseif (mod(n, 2) == 0 || n == 1)
        test = false;
        return;
    end

    % Inizializziamo test al valore true: non appena rileviamo che il test
    % di Fermat NON è soddisfatto, cambiamo il suo valore a false
    test = true;

    for i = 1:iter
        % Scegliamo in maniera uniforme un numero intero fra 2 ed n - 1
        x = randi([2 (n -1)]);
        d = MCD(x, n);
        if(d > 1)
            % Se il massimo comun divisore fra x ed n è d > 1, esso è un
            % divisore proprio di n -> n non è primo
            test = false;
            return;
        end
        % Dobbiamo verificare se x^(n - 1) = 1 mod n
        if(potenza_mod(x, n - 1, n) ~= mod(1, n))
            % In questo caso n non è primo
            test = false;
            return;
        end
        % Se arriviamo qui, n supera il test di Fermat in base x e quindi
        % è uno pseudoprimo di Fermat
    end
end