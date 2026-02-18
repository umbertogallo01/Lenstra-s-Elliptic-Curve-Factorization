function x = inverso(n, m)
    % La funzione prende in input due interi n ed m e restituisce, se esiste, un inverso di n mod m.
    
    % ATTENZIONE: affinché l'inverso di n modulo m sia ben definito (ossia
    % n sia un elemento di (Z/(m))*), n dev'essere coprimo con m. Pertanto
    % verifichiamo se MCD(n, m) = 1: se ciò non avviene, usciamo dal
    % programma.

    if(MCD(n, m) ~= 1)
        error('I due argomenti inseriti non sono fra loro coprimi, pertanto non è possibile calcolarne un inverso.');
        return;
    end
    
    % Una volta verificato che n ed m sono coprimi, l'inverso di n mod(m)
    % lo troviamo usando l'identità di Bezout. In particolare l'inverso di
    % n mod(m) è il coefficienti di n nell'identità

    [x,~]=calcola_bezout(n,m);
end
