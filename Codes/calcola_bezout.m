function [x, y] = calcola_bezout(n, m)
    
    % La funzione calcola i coefficienti di Bézout per nx + my = MCD(n, m).

    check=false;

    % Controllo se n>m. Se non lo è li scambio
    if n<m
        check=true;
        temp=n;
        n=m;
        m=temp;
    end
    
    % Creo la matrice che mi permetterà di trovare i coefficienti di Bezout
    A=zeros(2);
    A(1,2)=1;
    A(2,1)=1;
    B=eye(2);
    
    while mod(n,m)~=0
        q=floor(n/m);
        r=n-q*m;
        A(2,2)=-q;
        B=A*B; % Devo moltiplicare a sinistra
        n=m;
        m=r;
    end
    
    % Devo fare un ultima iterazione
    q=floor(n/m);
    A(2,2)=-q;
    B=A*B;
    
    coeff=[1,0]*B;

    % Se n ed m sono stati scambiati all'inizio, allora il coefficiente di
    % n è coeff(2) e quello di m è coeff(1)
    if check==true
        x=coeff(2);
        y=coeff(1);
    else
        x=coeff(1);
        y=coeff(2);
    end
end