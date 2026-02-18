% Metodo p-1 di Pollard

clc
clear

% Chiedo in input un n da fattorizzare
prompt = "Inserire n da fattorizzare: ";
n = input(prompt);

% Controllo che n sia intero e positivo
while n ~= floor(n) || n <= 0
    warning('bisogna inserire un numero intero e positivo.')
    prompt = "Inserire n da fattorizzare: ";
    n = input(prompt);
end

% Escludo il caso banale n = 1
if n == 1
    disp(['Il valore inserito in input è pari a 1, quindi ha ' ...
        'fattorizzazione banale.'])
    return;
end

% Escludo il caso banale in cui n sia pari
if mod(n,2)==0
    q=n/2;
    disp(['Il valore inserito è pari, dunque ha una ' ...
        'fattorizzazione banale n = 2 * ', num2str(q)])
    return;
end

% Controlliamo l'eventuale primalità di n usando uno dei test di primalità visti. 
% Se il test usato dà esito positivo, segnaliamo all'utente che n è primo ed 
% usciamo dal programma.

if (test_Miller_Rabin(n, 100) == true)
    disp(['Il valore n inserito in input è un numero primo. Il programma ' ...
        'verrà interrotto.'])
    return;
end

% Prendo a in {2,...,n-1}. Lo inizializzo a 2
a=2;

% Fisso la scommessa 
b=sqrt(n);


while a<n
    
    flag=0; % marcatore che mi permette di uscire dai cicli quando serve

    % Controllo che MCD(a,n)=1
    d=MCD(a,n);

    if d==n
        a=a+1;
    end
    
    if d~=1 && d~=n
        disp(['Ho trovato un divisore d = ', num2str(d)])
        return
    end

    % In p salvo una lista di primi.
    p = [2, 3, 5, 7];

    pot=a; % variabile di appoggio per il calcolo di a^m mod(n)
    
    for i = 1:length(p)
        k = p(i);
        e = floor(log(b) / log(k)); 
        j = 1;

        while j<=e
            pot=potenza_mod(pot,k,n);
            d=MCD(pot-1,n);

            if d~=1 && d~=n
                disp(['Ho trovato un divisore d = ', num2str(d)])
                return
            end
            
            if d==n
                % dobbiamo cambiare a, quindi usciamo da questo ciclo while
                flag=1;
                break
            end
            j=j+1;
        end

        if flag==1
            % devo uscire anche dal for
            break
        end

    end

    if flag==1
        % cambio a e salto tutte le istruzioni del while rimanenti
        a=a+1;
        continue
    else
        % flag è rimasto sempre 0, ma non ho mai trovato un divisore.
        % Questo vuol dire che devo cambiare a
        a=a+1;
    end
end