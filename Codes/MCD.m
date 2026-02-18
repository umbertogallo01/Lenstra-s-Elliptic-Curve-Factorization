function d = MCD(a, b)
    % Funzione per il calcolo del massimo comun divisore di due interi a e
    % b (con a>b)
    
    % Ci riduciamo a lavorare con numeri positivi.
    a = abs(a);
    b = abs(b);
    
    % Controllo che a>b, altrimenti scambio i due numeri
    if a<b
        temp=a;
        a=b;
        b=temp;
    end
  
    if(b == 0)
        % Per definizione, MCD(a, 0) := a
        d = a;
    elseif(b == 1)
        % a è coprimo con b
        d = 1;
    else
        % Eseguiamo iterativamente il calcolo del MCD finché non troviamo
        % resto 0
        d = MCD(b, mod(a, b));
    end
end