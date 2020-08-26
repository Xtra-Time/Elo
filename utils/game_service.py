import requests


class GamesService:
    def __init__(self):
        self.url = "http://86b93d359bed.ngrok.io"

    def get_all_sessions(self):
        response = requests.request("GET", self.url+"/v1/sessions")
        return response.json()

    def get_session_by_id(self, game_id):
        response = requests.request("GET", self.url+"/v1/sessions/?game_id=" + game_id)
        return response.json()
    
    def clr_all_sessions(self):
        sessions = self.get_all_sessions()
        session_id = []
        for k in sessions:
            for n in k:
                if n == 'session_id':
                    session_id.append(k[n])

        for i in session_id:
            r = requests.delete(self.url+"/v1/sessions/"+i)
            print(r.text.encode('utf8'))

    def get_game(self, game_id):      
        response = requests.request("GET", self.url+"/v1/games/" + game_id)
        return response.json()
