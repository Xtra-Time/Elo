close all

tic
t_1 = readtable('/home/marques/Desktop/test_elos/test_elo_w1.csv', 'HeaderLines', 0, 'ReadVariableName', true);
t_2 = readtable('/home/marques/Desktop/test_elos/test_elo_w2.csv', 'HeaderLines', 0, 'ReadVariableName', true);
t_3= readtable('/home/marques/Desktop/test_elos/test_elo_3.csv', 'HeaderLines', 0, 'ReadVariableName', true);
t_4= readtable('/home/marques/Desktop/test_elos/test_elo_4.csv', 'HeaderLines', 0, 'ReadVariableName', true);
t_5 = readtable('/home/marques/Desktop/test_elos/test_elo_5.csv', 'HeaderLines', 0, 'ReadVariableName', true);


%distance = t{:,6}; 
%duration = t{:,7};
%pace= duration./(distance/1000);

for player=1:5
    if player==1
        goals=t_1{:,10};
        assists=t_1{:,11};
        team=t_1{:,5};
        goals_A=t_1{:,12};
        goals_B=t_1{:,13};
        
    elseif player==2
        goals=t_2{:,10};
        assists=t_2{:,11};
        team=t_2{:,5};
        goals_A=t_2{:,12};
        goals_B=t_2{:,13};
        
    elseif player==3
        goals=t_3{:,10};
        assists=t_3{:,11};
        team=t_3{:,5};
        goals_A=t_3{:,12};
        goals_B=t_3{:,13};
        
    elseif player==4
        goals=t_4{:,10};
        assists= t_4{:,11};
        team= t_4{:,5};
        goals_A =t_4{:,12};
        goals_B = t_4{:,13};
        
    else 
        goals=t_5{:,10};
        assists=t_5{:,11};
        team=t_5{:,5};
        goals_A=t_5{:,12};
        goals_B=t_5{:,13};
        
    end 
        

    for teste=1:2
        elo=1500;
        if teste==1
            elo_team_adv=1700;
        else
            elo_team_adv=1000;
        end

        for n=1:height(t_1)
            elo_my_team=elo;  
            if team(n) == 1
                result(n) =  goals_A(n)-goals_B(n);        

                g= (goals(n)/ (goals_A(n)+goals_B(n)));  % g -> fator de golos ponderado
                a= assists(n)/ ((goals_A(n)+goals_B(n))-goals(n));  % a -> fator de assistencias ponderado
                perf=0.5 * g + 0.3 * a;

            else
                result(n) = goals_B(n)-goals_A(n);
                g= (goals(n)/ (goals_A(n)+goals_B(n)));
                a= assists(n)/ ((goals_A(n)+goals_B(n))-goals(n));
                perf=0.5 * g + 0.3 * a;  

            end

        K(n) = 1+(90/(10 + (n)));                                % fator que depende do número de jogos
        S(n)= 10-(20/(1+10^(0.1*result(n))));                    % valor do resultado ponderado
        E_a= 2-(4/(1+1.2^((elo_team_adv-elo_my_team)*0.1)));     % Valor de variação do Elo da equipa

        elo=elo+(K(n)*(S(n)+E_a)+perf*10);
        %elo=elo+(K(n)*(S(n)+E_a)); 
        plot(0,1500,'bo');
        
        if teste==1        
            ln=plot(n,elo,'bo');
        else
            ln=plot(n,elo,'ro');
        end 

        hold on
        grid on

        end
    end
figure('name', 'player')
end


toc