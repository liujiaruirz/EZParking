import csv
import json

id = 0

cuisines = ['Italian', 'Chinese', 'Mexican', 'Japanese', 'French', 'American']
for cui in cuisines:
    with open(cui+'_data_clean.csv', 'r') as csv_file:
        csv_data = csv.reader(csv_file)
        next(csv_data)
        for res in csv_data:
            head = {"index" : { "_index": "restaurants", "_id" : str(id)}}
            data = {"business_id": str(res[0]), "cuisine": str(res[2])}
            id += 1
            with open('restaurants.json', 'a') as outfile:  
                json.dump(head, outfile)
                outfile.write('\n')
                json.dump(data, outfile)
                outfile.write('\n')
