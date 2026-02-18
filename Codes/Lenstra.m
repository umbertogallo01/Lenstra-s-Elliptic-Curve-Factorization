% Progetto di Umberto Gallo & Giorgia Iannarelli

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

% Chiedo in input un punto P
disp('Inserire le coordinate del punto P.')

prompt = "Inserire xP: ";
xP = input(prompt);
% Controllo che xP sia intero
while xP ~= floor(xP) 
    disp('Errore: inserire un numero intero')
    prompt = "Inserire xP: ";
    xP = input(prompt);
end
xP=mod(xP,n);


prompt = "Inserire yP: ";
yP = input(prompt);
% Controllo che yP sia intero 
while yP ~= floor(yP) || MCD(yP,n)==n
    disp('Errore: inserire un numero intero')
    prompt = "Inserire yP: ";
    yP = input(prompt);
end
yP=mod(yP,n);


% Salvo P in un vettore
P = [xP, yP];

% Costruisco la curva ellittica: 
% Prendo 'a' pari ad 1 e incremento fino ad n - 1 se necessario 
% (a \in Z/(n)).
a = 0;
B = (nthroot(n, 4) + 1)^2; % Soglia determinata mediante la disuguaglianza 
% di Hasse

while a < n
    % Trovo b imponendo il passaggio di P per l'equazione della curva
    b = (yP^2) - (xP^3) - (a * xP);
    b = mod(abs(b), n);
    % Calcolo il discriminante 4a^3 + 27b^2 mod n
    disc = mod((4 * a^3) + (27 * b^2), n);
   
    % Calcolo il MCD fra il discriminante d ed n
    d = MCD(disc, n);
    if d ~= 1 && d ~= n
        disp(['Ho trovato un divisore d = ', num2str(d)])
        return
    end
    if d == n
        % Se d = n, allora n divide il discriminante, ossia disc = 0
        % mod n
        a = a + 1;
    end
    if d == 1
        p = 2; % perché partiamo calcolando (2^e2)*P
        e2 = floor(log(B) / log(p));
        j = 1;
        while j <= e2
            % In Q salvo un punto della forma 2^k * P
            [Q, flag] = raddoppia(P, n, a);
            if flag == 2
                % flag = 2 se raddoppia ha un trovato e stampato un 
                % divisore, quindi l'algoritmo termina
                return
            end
            if flag == 1
                % flag = 1 se MCD(yP, n) = n, quindi bisogna
                % cambiare a e ricominciare
                a = a + 1;
                break
            end
            if flag == 0
                j = j + 1;
                P = Q;
            end
        end
        
        if flag == 1
            % vuol dire che ho cambiato a nel ciclo precedente 
            % e devo passare alla prossima iterazione del while a<n
            continue
        end

        % Se nel while non abbiamo trovato un divisore si ha che
        % Q = 2^(e_2) * P.

        % In p salvo una lista di primi
        p = [3, 5, 7, 11];

        for i = 1:length(p)
            % Salvo in T l'ultimo punto trovato nel ciclo precedente
            T = Q;
            k = p(i);
            e = floor(log(B) / log(k));
            j = 1;

            while j <= e
                [Q,flag] = calcola_kP(T, k, n, a);
                if flag == 2
                    % flag = 2 se nel sottoprogramma calcola_kP, somma o
                    % raddoppia hanno trovato e stampato un divisore, 
                    % quindi l'algoritmo termina
                    return
                end
                if flag == 1
                    % flag = 1 vuol dire che o il denominatore di somma o
                    % di raddoppia si è annullato mod(n), quindi bisogna 
                    % cambiare a e ricominciare
                    a = a + 1;
                    break
                end
                if flag == 0
                    % flag = 0, quindi è stato possibile calcolare k *
                    % Q mod n e non sono stati trovati divisori propri
                    % di n procedendo con le somme/raddoppi. Incremento
                    % dunque il valore di j -> j + 1 e  vado avanti
                    j = j + 1;
                    
                    % salvo dentro T il Q calcolato con calcola_kP
                    T=Q;
                end 
            end
            
            if flag == 1
                % vuol dire che ho cambiato a e devo uscire dal ciclo for e
                % andare alla prossima iterazione del while (a<n)
                break
            end
        end
    end
end

disp("Non sono riuscito a fattorizzare n provando con tutti i possibili a" + ...
    "in Z/(n). Prova a rilanciare il programma cambiando le coordinate" + ...
    "del punto P...")