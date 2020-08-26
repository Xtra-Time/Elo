import requests
from utils.game_services import GamesService
from utils.team_services import TeamsService

gs = GamesService()
all_sessions=gs.get_all_sessions()

ts= TeamsService()

team_id=200

jogo =7
dist=[]
pace=[]
goals=[]
assists=[]
top_speed=[]
players=[]
elo=[]
n_games=[]

for session in all_sessions:
    players.append(session['player_id'])      
       
    dist.append(session['distance'])

    pace.append(session['pace'])

    goals.append(session['goals_scored'])

    assists.append(session['assists'])

    top_speed.append(session['top_speed'])      

               
score_a=session['score_a'] 
score_b=session['score_b']


for player in players:
    aux=ts.get_elo(str(team_id),str(player))   
    elo.append(aux[0]['elo'])
    n_games.append(aux[0]['games_played'])


print("1st ELO ---> " +str(elo))

elo_team_a = 0
elo_team_b = 0
#################################
total_goals= score_a + score_b
##############################
g=[] #facção goals/total_goals
d=[]
ast=[]
pac=[]
top=[]
k=[] #fator de peso em função do nº de jogos
s=[] #fator de peso em função do resultado
e_a=[] #fator de balanceamento sobre os elos das equipas
performance=[]
new_elo=[]

#string to int or float
for a in dist:
    d.append(int(a))
for a in pace:
    pac.append(float(a))
for a in top_speed:
    top.append(float(a))

#calculate team elo
for count, i in enumerate (elo):
    if(count < jogo):
        elo_team_a = elo_team_a + i
    else:
        elo_team_b = elo_team_b + i

#media do elo da equipa
elo_team_a = elo_team_a/jogo
elo_team_b = elo_team_b/jogo

#calculate performance
for count, i in enumerate (goals) :
    g.append(i/total_goals)
    ast.append((assists[count]/(total_goals-i))) 
    perf = 0.5 * g[count] + 0.3 * ast[count] 
    performance.append(perf)

    k.append(1+(90/(10 + n_games[count])))
    
    if(count<jogo):
        result=score_a-score_b
        s.append(10-(20/(1+(pow(10,0.1*result)))))
        e_a.append(2-(4/(1+pow(1.2,(elo_team_b-elo_team_a)*0.1))))
        
    else:
        result=score_b-score_a
        s.append(10-(20/(1+(pow(10,0.1*result)))))        
        e_a.append(2-(4/(1+pow(1.2,(elo_team_b-elo_team_a)*0.1))))

    a=elo[count]+(k[count]*s[count]*e_a[count]+performance[count]*3)

    new_elo.append(round(a))  

print("NEW ELO Calculado --->  " )
print(new_elo)

#update new elo na db para cada player
for count, p in enumerate (players): 
    a=new_elo[count] 
    print("Team: " +str(team_id) +"   player:   " +str(p) +"  elo: " +str(a) )      
    ts.update_elo(str(team_id),str(p),new_elo[count])


#print("NEW ELO (Guardado) --->  " +new_elo)
#print('PERFORMANCE: ',performance)


'''
print('Distance: ',dist)
print('Pace: ',pace)
print('Top Speed: ',top_speed)
print('GOALS: ',goals)
print('Assists: ',assists)
print('Score Team A: ',score_a)
print('Score Team B: ',score_b)'''

