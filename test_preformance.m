close all

tic
t_1 = readtable('/home/marques/Desktop/test_elos/test_elo_w1.csv', 'HeaderLines', 0, 'ReadVariableName', true);
t_2 = readtable('/home/marques/Desktop/test_elos/test_elo_w2.csv', 'HeaderLines', 0, 'ReadVariableName', true);
t_3= readtable('/home/marques/Desktop/test_elos/test_elo_3.csv', 'HeaderLines', 0, 'ReadVariableName', true);
t_4= readtable('/home/marques/Desktop/test_elos/test_elo_4.csv', 'HeaderLines', 0, 'ReadVariableName', true);
t_5 = readtable('/home/marques/Desktop/test_elos/test_elo_5.csv', 'HeaderLines', 0, 'ReadVariableName', true);

distance_p1 = t_1{:,6};distance_p2 = t_2{:,6}; distance_p3 = t_3{:,6}; distance_p4 = t_4{:,6}; distance_p5 = t_5{:,6}; 
e=2.71828182846;

for player=1:5
    if player==1
        goals=t_1{:,10};
        assists=t_1{:,11};
        team=t_1{:,5};     
        distance=t_1{:,6};
        duration = t_1{:,7};
        top_speed = t_1{:,8};
        pace= t_1{:,9};
        goals_A=t_1{:,12};
        goals_B=t_1{:,13};
        
    elseif player==2
        goals=t_2{:,10};
        assists=t_2{:,11};
        team=t_2{:,5};  
        distance=t_2{:,6};
        duration = t_2{:,7};
        top_speed = t_2{:,8};
        pace= t_2{:,9};
        goals_A=t_2{:,12};
        goals_B=t_2{:,13};
        
    elseif player==3
        goals=t_3{:,10};
        assists=t_3{:,11};
        team=t_3{:,5};
        distance=t_3{:,6};
        duration = t_3{:,7};
        top_speed = t_3{:,8};
        pace= t_3{:,9};
        goals_A=t_3{:,12};
        goals_B=t_3{:,13};
        
    elseif player==4
        goals=t_4{:,10};
        assists= t_4{:,11};
        team= t_4{:,5};
        distance=t_4{:,6};
        duration = t_4{:,7};
        top_speed = t_4{:,8};
        pace= t_4{:,9};
        goals_A =t_4{:,12};
        goals_B = t_4{:,13};
        
    else 
        goals=t_5{:,10};
        assists=t_5{:,11};
        team=t_5{:,5}; 
        distance=t_5{:,6}; 
        duration = t_5{:,7};
        top_speed = t_5{:,8};
        pace= t_5{:,9};
        goals_A=t_5{:,12};
        goals_B=t_5{:,13};
        
    end 
        

    for n=1:height(t_1)
        elo_my_team=elo; 
        d_total = distance_p1(n)+distance_p2(n)+distance_p3(n)+distance_p4(n)+distance_p5(n);
        if team(n) == 1
            result(n) =  goals_A(n)-goals_B(n);        

            g= (goals(n)/ (goals_A(n)+goals_B(n)));  % g -> fator de golos ponderado
            
            if goals_A(n)-goals(n)==0   % marcou os golos todos da equipa
               perf=0.7 * g + 0.3 *(0.5*d+0.05*t_s);
            else 
                g= (goals(n)/ (goals_A(n)));
                a= assists(n)/ (goals_A(n)-goals(n));  % a -> fator de assistencias ponderado
                d= distance(n)/d_total;
                t_s=(str2double(top_speed(n)))/17;
                adv_goals = abs(goals_A(n)-goals_B(n))/goals_A(n)+goals_B(n);
                perf=0.5 * g + 0.3 * a + 0.2 *(0.5*d+0.05*t_s)-0.01*adv_goals;           
            end
            
            performance= 100/(1+e^(-15*(perf-0.20)));

        else
            result(n) = goals_B(n)-goals_A(n);
            g= (goals(n)/ (goals_A(n)+goals_B(n)));
            a= assists(n)/ (goals_B(n)-goals(n));
            d= distance(n)/d_total;
            t_s=(str2double(top_speed(n)))/17;
            perf=0.5 * g + 0.3 * a + 0.2 *(0.5*d+0.05*t_s);
            performance= 100/(1+e^(-15*(perf-0.20)));

        end

        K(n) = 1+(90/(10 + (n)));                                % fator que depende do número de jogos
        S(n)= 10-(20/(1+10^(0.1*result(n))));                    % valor do resultado ponderado
        E_a= 2-(4/(1+1.2^((elo_team_adv-elo_my_team)*0.1)));     % Valor de variação do Elo da equipa

        elo=elo+(K(n)*(S(n)+E_a)+perf*10);
        %elo=elo+(K(n)*(S(n)+E_a)); 
        %plot(0,1500,'bo');        
               
        ln=plot(n,performance,'bo');               
        

        hold on
        grid on

       
    end
figure('name', 'player')
end


toc