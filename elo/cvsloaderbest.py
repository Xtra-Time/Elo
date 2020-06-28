
import csv, json , requests

csvFilePath = 'elo_db_test.csv'
jsonFilePath='testdb.json'

url = "http://doitasapro.com/v1/sessions/"

data_1 ={}

with open(csvFilePath) as csvFile:    
    csvReader = csv.DictReader(csvFile) 
    for row in csvReader:  
        id =row['game_id']
        data_1[id]=row



with open(jsonFilePath, 'w') as jsonFile:
    jsonFile.write(json.dumps(data_1, indent=4))

files = {'file': open(jsonFilePath, 'r')}
headers = {'Content-Type': 'application/json'}

response = requests.post(url,files=files, headers=headers)

#response = requests.request("POST", url, headers=headers, data = payload)

print(response.text.encode('utf8'))
#print(data_1)

print(data_1)

#payload = "{\n    \"game_id\":\"1\",\n    \"player_id\":\"2\",\n    \"created_at\":\"2020-02-03T19:00:00.000Z\"\n}"



