function J = simbolo_Jacobi(m, n, J)
    
    % STEP 0: Caso base
    if m == 0
        J = 0;
        return
    elseif m == 1
        J=1;
        return;
    elseif m == -1
        if mod(n,4)==3
            J=-1;
            return;
        else
            J=1;
            return;
        end
    elseif m == 2
        if mod(n,8)==3 || mod(n,8)==5
            J=-1;
            return;
        else
            J=1;
            return;
        end
    end
    
    % STEP 1: Porta fuori i segni negativi
    if m < 0
        if mod(n,4)==3
            J=-1;
        end
        m=-m;
    end

    % Controllo di non avere un caso base 
    if m==2
        if mod(n,8)==3 || mod(n,8)==5
            J=-J;
            return;
        else
            return;
        end
    end

    
    % STEP 2: Porta fuori le potenze di 2
    bin = dec2bin(m);

    % contiamo il numero di 0 in fondo perché m=2^d*h e se #zeri è dispari
    % allora d è dispari, altrimenti è pari. Mentre h è il resto
    cont=0;
    for i=length(bin):-1:1
        if bin(i)=='0'
            cont=cont+1;
        end
        if bin(i)=='1'
            indice=i; % mi salvo l'indice per poi riconvertirlo e trovare h
            break
        end
    end

    if mod(cont,2)~=0
        if mod(n,8)==3 || mod(n,8)==5
            J=-J;
        end
    end
    
    h=bin2dec(bin(1:indice));
    % h è il nuovo m
    m=h;

    % STEP 3: abbiamo due dispari (m/n) quindi usiamo la reciprocità quadratica
    if MCD(m,n)==n
        J=0;
        return;
    elseif m == 1
        return;
    elseif m<n
        if mod(m, 4) == 3 && mod(n, 4) == 3
            J = -J;
        end

        % scambio m ed n
        temp=m;
        m=n;
        n=temp;
    end

    % calcolo il resto della divisione tra m e n e voglio che sia tra {-n/2,...,n/2}
    r = mod(m, n);
    while r > floor(n / 2)
        r = r - n;
    end

    L=J;
    J=L*simbolo_Jacobi(r, n, L);  % Chiamata ricorsiva

end