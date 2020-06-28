from utils.team_services import TeamsService

ts = TeamsService()
team_id = 200
user_id = 1
player_elo=[]

while user_id < 14:
    t=ts.get_elo(str(team_id),str(user_id))
    if(len(t)<1):
        print("not found!")

    player_elo.append(t[0]['elo'])    
    user_id +=1  
        
print(player_elo)