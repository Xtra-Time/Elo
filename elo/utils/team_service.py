import requests, json
from utils.connections import connections

class TeamsService:
    def __init__(self):
        self.url=connections['team_service_url']

    def get_all_elos(self):
        response = requests.request("GET", self.url+"/v1/elo/")
        #print(response.text.encode('utf8'))
        return response.json()

    def get_elo(self,team_id,user_id):
        response = requests.request("GET", self.url+"/v1/elo/?team_id=" +team_id +"&user_id=" +user_id)
        #print(response.text.encode('utf8'))
        return response.json()

    def create_elo(self, team_id, user_id): 
        headers = {'Content-Type': 'application/json'} 
        data ={
            "team_id":team_id,
            "user_id":user_id
        }
        payload=json.dumps(data, indent=4)

        response = requests.request("POST", self.url+"/v1/elo", headers=headers, data = payload)        
        #print(response.text.encode('utf8'))

    def update_elo(self, team_id, user_id, elo, nr_games): 
        data ={
            "elo": elo,
            "games_played": nr_games
        }
        payload=json.dumps(data)
        headers = {
        'Content-Type': 'application/json'
        }

        response = requests.request("PATCH", self.url+"/v1/elo/?user_id="+user_id+"&team_id="+team_id , headers=headers, data = payload)
        print(response.text.encode('utf8'), "elo updated!")
    



