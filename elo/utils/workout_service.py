import requests

class WorkoutService:
    def __init__(self):
        self.url="http://cab21360f198.ngrok.io/v1/"

    def get_workout(self, workout_id):
        response = requests.request("GET", self.url+"/") #falta o resto do link
        return response.json()
