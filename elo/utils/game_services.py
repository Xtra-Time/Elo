import requests

class GamesService:
    def __init__(self):
        self.url="http://7f2fc4ecc240.ngrok.io/v1/"

    def get_all_sessions(self):
        response = requests.request("GET", self.url+"/sessions")
        return response.json()
    
    def clr_all_sessions(self):
        t=self.get_all_sessions()        
        session_id=[]
        for k in t:
            for n in k:
                if n=='session_id':
                    session_id.append(k[n])
        
        for i in session_id:
            r=requests.delete(self.url+"/sessions/"+i)
            print(r.text.encode('utf8'))

    
    